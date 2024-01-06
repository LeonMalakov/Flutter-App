using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System;
using Microsoft.Extensions.Configuration;
using Casino.Utils;
using System.Threading.Tasks;
using Casino.DAL.Respositories;
using System.Text;
using Microsoft.Extensions.Options;
using Casino.AppSettings;
using Casino.DAL.Models;
using Casino.Utility;
using Microsoft.Extensions.Logging;

namespace Casino.Services {
    public sealed class AuthService : IAuthService {
        private readonly IConfiguration _configuration;
        private readonly IAppRepository _repository;
        private readonly IOptions<JwtSettings> _jwtSettings;
        private readonly SymmetricSecurityKey _key;
        private readonly SymmetricSecurityKey _refreshKey;
        private readonly ILogger<AuthService> _logger;

        public AuthService(IConfiguration configuration, IAppRepository repository, IOptions<JwtSettings> jwtSettings, ILoggerFactory logger) {
            _configuration = configuration;
            _repository = repository;
            _jwtSettings = jwtSettings;
            _key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtSettings.Value.Key));
            _refreshKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_jwtSettings.Value.RefreshKey));
            _logger = logger.CreateLogger<AuthService>();
        }

        public async ValueTask<(bool Success, JwtTokenPair TokenPair)> SignUp(string userName, string password) {
            if(await _repository.GetUserByName(userName) != null) {
                _logger.LogInformation($"User '{userName}' already exists.");
                return (false, default);
            }

            await _repository.CreateUser(new User() {
                Name = userName,
                PasswordHash = password
            });

            var user = await _repository.GetUserByName(userName);
            if (user == null) {
                _logger.LogInformation($"Created user '{userName}' not found");
                return (false, default);
            }

            var tokens = GenerateTokens(user.Id);
            await _repository.UpdateRefreshToken(user.Id, tokens.Refresh);
            return (true, tokens);
        }

        public async ValueTask<(bool Success, JwtTokenPair TokenPair)> LogIn(string userName, string password) {
            var user = await _repository.GetUserByName(userName);
            if (user == null) {
                _logger.LogInformation($"User '{userName}' not found");
                return (false, default);
            }

            if(user.PasswordHash != password) {
                _logger.LogInformation($"User '{userName}' password not equal");
                return (false, default);
            }

            var tokens = GenerateTokens(user.Id);

            if (!await _repository.UpdateRefreshToken(user.Id, tokens.Refresh)) {
                // Не удалось обновить токен.
                _logger.LogInformation($"Refresh token not updated: {tokens.Refresh}");
                return (false, default);
            }
            return (true, tokens);
        }

        public async ValueTask<(bool Success, JwtTokenPair TokenPair)> Refresh(int userId, string refreshToken) {
            var refresh = _repository.GetRefreshToken(userId);

            if(refresh != refreshToken) {
                // Токен не соотвествует.
                _logger.LogInformation($"Refresh token not equal: {refresh} != {refreshToken}");
                return (false, default);
            }

            if(!JwtUtility.ValidateToken(refreshToken, _configuration, false)) {
                // Токен не валиден.
                _logger.LogInformation($"Refresh token not valid: {refreshToken}");
                return (false, default);
            }

            
            var tokens = GenerateTokens(userId);

            if(!await _repository.UpdateRefreshToken(userId, tokens.Refresh)) {
                // Не удалось обновить токен.
                _logger.LogInformation($"Refresh token not updated: {refreshToken}");
                return (false, default);
            }

            return (true, tokens);
        }

        private JwtTokenPair GenerateTokens(int userId) {
            var utcNow = DateTime.UtcNow;

            string authToken = GenerateJwtToken(userId, utcNow.AddHours(3));
            string refreshToken = GenerateJwtToken(userId, utcNow.AddHours(720), false);

            return new JwtTokenPair() {
                Access = authToken,
                Refresh = refreshToken,
            };
        }

        private string GenerateJwtToken(int userId, DateTime expireTime, bool auth = true) {
            var tokenHandler = new JwtSecurityTokenHandler();

            var tokenDescriptor = new SecurityTokenDescriptor {
                Subject = new ClaimsIdentity(new Claim[] {
                    new Claim(ClaimTypes.Name, userId.ToString())
                }),
                Expires = expireTime,
                Issuer = _jwtSettings.Value.Issuer,
                SigningCredentials = new SigningCredentials(auth ? _key : _refreshKey, SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            var authToken = tokenHandler.WriteToken(token);
            return authToken;
        }
    }
}
