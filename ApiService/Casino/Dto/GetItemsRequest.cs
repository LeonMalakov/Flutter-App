using Newtonsoft.Json;

namespace Casino.Dto {
    public sealed class GetItemsRequest {
        [JsonProperty("item_ids")]
        public string? ItemIds { get; set; }
    }
}
