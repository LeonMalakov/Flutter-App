using Newtonsoft.Json;

namespace Casino.Dto {
    public sealed class GetItemIdPageRequest {
        [JsonProperty("start_index")]
        public int StartIndex { get; set; }

        [JsonProperty("count")]
        public int Count { get; set; }
    }
}
