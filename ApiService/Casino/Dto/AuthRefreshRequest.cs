using Newtonsoft.Json;

namespace Casino.Dto {
    public sealed class AuthRefreshRequest {
        [JsonProperty("refresh_token")]
        public string RefreshToken { get; set; } = null!;
    }
}
