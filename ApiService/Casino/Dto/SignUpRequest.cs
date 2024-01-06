using Newtonsoft.Json;

namespace Casino.Dto {
    public sealed class SignUpRequest {
        [JsonProperty("user_name")]
        public string? UserName { get; set; }

        [JsonProperty("password")]
        public string? Password { get; set; }
    }
}
