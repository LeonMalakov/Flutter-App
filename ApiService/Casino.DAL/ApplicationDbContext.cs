using Casino.DAL.Models;
using Microsoft.EntityFrameworkCore;

namespace Casino.DAL {
    public sealed class ApplicationDbContext : DbContext {
        public DbSet<User> Users { get; set; }

        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options) {
        }
    }
}
