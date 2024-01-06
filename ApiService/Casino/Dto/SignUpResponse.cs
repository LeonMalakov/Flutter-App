using Newtonsoft.Json;

namespace Casino.Dto {
    public sealed class SignUpResponse {
        [JsonProperty("code")]
        public string? Code { get; set; }

        [JsonProperty("access")]
        public string? AccessToken { get; set; }

        [JsonProperty("refresh")]
        public string? RefreshToken { get; set; }
    }

    public static class SignUpResultCodes {
        public const string OK = "ok";
        public const string ERROR = "error";
        public const string USERNAME_USED = "username_used";
    }
}
