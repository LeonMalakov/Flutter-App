namespace Casino.DAL.Models {
    public sealed class User {
        public int Id { get; set; }

        public string? Name { get; set; }

        public string? PasswordHash { get; set; }

        public string? RefreshToken { get; set; }
    }
}
