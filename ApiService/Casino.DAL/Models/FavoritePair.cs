using Microsoft.EntityFrameworkCore;

namespace Casino.DAL.Models {
    [PrimaryKey("UserId", "ItemId")]
    public sealed class FavoritePair {
        public int UserId { get; set; }
        public int ItemId { get; set; }
    }
}
