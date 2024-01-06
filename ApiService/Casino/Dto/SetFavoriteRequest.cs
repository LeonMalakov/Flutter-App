using Newtonsoft.Json;

namespace Casino.Dto {
    public sealed class SetFavoriteRequest {
        [JsonProperty("item_id")]
        public int ItemId { get; set; }

        [JsonProperty("is_favorite")]
        public bool IsFavorite { get; set; }
    }
}
