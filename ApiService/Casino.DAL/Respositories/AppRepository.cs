using Casino.DAL.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Casino.DAL.Respositories {
    public sealed class AppRepository : IAppRepository {
        private readonly ApplicationDbContext _context;

        public AppRepository(ApplicationDbContext context) {
            _context = context;

            if(!_context.Items.Any()) {
                _context.Items.Add(new Item() {
                    Title = "Перевозчик",
                    Subtitle = "Первая часть трилогии",
                    Description = "Фильм перевозчик про стетхема",
                    ImageUrl = "https://thumbs.dfs.ivi.ru/storage6/contents/8/8/84a1f2c0430452ab08f07c86eab477.jpg"
                });
                _context.Items.Add(new Item() {
                    Title = "Гнев Человеческий",
                    Subtitle = "Крутой фильм",
                    Description = "Фильм гнев про стетхема",
                    ImageUrl = "https://thumbs.dfs.ivi.ru/storage6/contents/8/8/84a1f2c0430452ab08f07c86eab477.jpg"
                });
                _context.SaveChanges();
            }
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

        public ValueTask<Item?> GetItem(int itemId) {
            return _context.Items.FindAsync(itemId);
        }

        public Task<List<int>> GetItemIds(int startIndex, int count) {
            return _context.Items.OrderBy(x => x.Title)
                .Select(x => x.Id)
                .Skip(startIndex)
                .Take(count).ToListAsync();
        }

        public Task<List<int>> GetFavorites(int userId) {
            return _context.FavoritePairs.Where(x => x.UserId == userId)
                .Select(x => x.ItemId).ToListAsync();
        }

        public async ValueTask<bool> SetFavorite(int userId, int itemId, bool isFavorite) {
            var pair = await _context.FavoritePairs.FindAsync(userId, itemId);
            if(pair == null && isFavorite) {
                _context.FavoritePairs.Add(new FavoritePair() {
                    UserId = userId,
                    ItemId = itemId
                });
            } else if(pair != null && !isFavorite) {
                _context.FavoritePairs.Remove(pair);
            } else {
                return false;
            }
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
