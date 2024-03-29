﻿namespace Casino.DAL.Models {
    public sealed class Item {
        public int Id { get; set; }
        public string? Title { get; set; }
        public string? Subtitle { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
    }
}
