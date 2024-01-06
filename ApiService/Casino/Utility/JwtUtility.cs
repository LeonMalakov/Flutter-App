using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System;
using Casino.Constants;
using System.Text;
using Microsoft.Extensions.Configuration;
using Casino.DAL.Models;
using System.Linq;

namespace Casino.Utility {
    public static class JwtUtility {
        public static bool ValidateToken(string token, IConfiguration configuration, bool auth = true) {
            var tokenHandler = new JwtSecurityTokenHandler();
            var validationParameters = GetValidationParameters(configuration, auth);

            try {
                SecurityToken securityToken;
                var principal = tokenHandler.ValidateToken(token, validationParameters, out securityToken);

                // If you reached here, the token is valid
                return true;
            } catch (SecurityTokenExpiredException) {
                // Token is expired
                return false;
            } catch (Exception) {
                // Other validation errors
                return false;
            }
        }

        public static bool TryGetUserId(string token, out int userId) {
            userId = 0;

            try {
                var handler = new JwtSecurityTokenHandler();
                var jsonToken = handler.ReadToken(token) as JwtSecurityToken;

                if (jsonToken == null) {
                    return false;
                }

                // Extract user name claim
                var userIdStr = jsonToken.Claims?.FirstOrDefault(c => c.Type == "unique_name")?.Value;

                if (int.TryParse(userIdStr, out userId)) {
                    return true;
                }
            } catch (Exception ex) {
                // Handle decoding exception
                Console.WriteLine($"Error decoding token: {ex.Message}");
            }

            return false;
        }

        public static TokenValidationParameters GetValidationParameters(IConfiguration configuration, bool auth = true) {
            return new TokenValidationParameters {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(configuration[
                    auth ? SettingsConstants.JWT_AUTH_KEY_KEY : SettingsConstants.JWT_REFRESH_KEY_KEY]!)),
                ValidateIssuer = true,
                ValidIssuer = configuration[SettingsConstants.JWT_ISSUER_KEY],
                ValidateAudience = false,
                ValidateLifetime = true,
            };
        }
    }
}
