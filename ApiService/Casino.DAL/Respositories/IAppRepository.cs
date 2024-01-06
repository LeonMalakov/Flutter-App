using Casino.DAL.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Casino.DAL.Respositories {
    public interface IAppRepository {
        void CreateItems(List<Item> items);
        Task CreateUser(User user);
        Task<List<int>> GetFavorites(int userId);
        ValueTask<Item?> GetItem(int itemId);
        Task<List<int>> GetItemIds(int startIndex, int count);
        string? GetRefreshToken(int userId);
        Task<User?> GetUserByName(string userName);
        ValueTask<bool> SetFavorite(int userId, int itemId, bool isFavorite);
        ValueTask<bool> UpdateRefreshToken(int userId, string refreshToken);
    }
}
