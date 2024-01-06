using Casino.DAL.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace Casino.DAL.Respositories {
    public sealed class AppRepository : IAppRepository {
        private readonly ApplicationDbContext _context;

        public AppRepository(ApplicationDbContext context) {
            _context = context;
        }

        public Task CreateUser(User user) {
            var createdUser = _context.Users.Add(user);
            return _context.SaveChangesAsync();
        }

        public async ValueTask<bool> UpdateRefreshToken(int userId, string refreshToken) {
            var user = await _context.Users.FindAsync(userId);

            if(user == null) {
                return false;
            }

            user.RefreshToken = refreshToken;
            _context.Users.Update(user);
            await _context.SaveChangesAsync();
            return true;
        }

        public string? GetRefreshToken(int userId) {
            var user = _context.Users.Find(userId);
            return user?.RefreshToken;
        }

        public Task<User?> GetUserByName(string userName) {
            return _context.Users.FirstOrDefaultAsync(x => x.Name == userName);
        }
    }
}
