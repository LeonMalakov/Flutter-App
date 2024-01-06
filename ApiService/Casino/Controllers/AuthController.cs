using Casino.Dto;
using Casino.Services;
using Casino.Utility;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;

namespace Casino.Controllers {
    [ApiController]
    [Route("auth")]
    public sealed class AuthController : ControllerBase {
        private readonly IAuthService _authService;
        private readonly ILogger<AuthController> _logger;

        public AuthController(IAuthService authService, ILoggerFactory loggerFactory) {
            _authService = authService;
            _logger = loggerFactory.CreateLogger<AuthController>();
        }

        /// <summary>
        /// Регистрирует пользователя.
        /// </summary>
        /// <param name="request">Данные для регистрации</param>
        /// <returns></returns>
        /// <response code="201">Пользователь был создан</response>
        /// <response code="400">Невозможно создать пользователя.</response>
        [HttpPost("signup")]
        public async Task<IActionResult> SignUp([FromBody] SignUpRequest request) {
            var (sucess, tokenPair) = await _authService.SignUp(request.UserName!, request.Password!);

            if(!sucess) {
                return BadRequest(new SignUpResponse() {
                    Code = SignUpResultCodes.ERROR
                });
            }

            return Ok(new SignUpResponse() {
                Code = SignUpResultCodes.OK,
                AccessToken = tokenPair.Access,
                RefreshToken = tokenPair.Refresh
            });
        }

        [HttpGet("login")]
        public async Task<IActionResult> LogIn([FromQuery] SignUpRequest request) {
            var (sucess, tokenPair) = await _authService.LogIn(request.UserName!, request.Password!);

            if (!sucess) {
                return BadRequest(new SignUpResponse() {
                    Code = SignUpResultCodes.ERROR
                });
            }

            return Ok(new SignUpResponse() {
                Code = SignUpResultCodes.OK,
                AccessToken = tokenPair.Access,
                RefreshToken = tokenPair.Refresh
            });
        }

        [HttpPost("refresh")]
        public async Task<IActionResult> Refresh([FromBody] AuthRefreshRequest request) {
            /* if(!ControllerUtility.GetAuthTokenInfo(HttpContext, out _, out int userId)) {
                 return Unauthorized();
             }*/

            if(!JwtUtility.TryGetUserId(request.RefreshToken, out int userId)) {
                _logger.LogInformation($"Cannot get user id from refresh token: {request.RefreshToken}");
                return BadRequest(new SignUpResponse());
            }

            var (sucess, tokenPair) = await _authService.Refresh(userId, request.RefreshToken!);

            if (!sucess) {
                return BadRequest(new SignUpResponse() {
                    Code = SignUpResultCodes.ERROR
                });
            }

            return Ok(new SignUpResponse() {
                Code = SignUpResultCodes.OK,
                AccessToken = tokenPair.Access,
                RefreshToken = tokenPair.Refresh
            });
        }
    }
}
