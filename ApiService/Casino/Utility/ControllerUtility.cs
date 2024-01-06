using Microsoft.AspNetCore.Http;
using System.Diagnostics.CodeAnalysis;

namespace Casino.Utility {
    public static class ControllerUtility {
        public static bool GetAuthTokenInfo(HttpContext context, [MaybeNullWhen(false)] out string authToken, out int userId) {
            authToken = null;
            userId = 0;

            string authHeader = context.Request.Headers["Authorization"]!;

            if (!string.IsNullOrEmpty(authHeader) && authHeader.StartsWith("Bearer ")) {
                authToken = authHeader.Substring("Bearer ".Length).Trim();
               

                return JwtUtility.TryGetUserId(authToken, out userId);
            }

            return false;
        }
    }
}
