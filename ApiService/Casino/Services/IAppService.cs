using Casino.DAL.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Casino.Services {
    public interface IAppService {
        ValueTask<List<int>> GetFavorites(int userId);
        ValueTask<List<int>> GetItemIdPage(int startIndex, int count);
        ValueTask<List<Item>> GetItems(int[] itemIds);
        ValueTask<bool> SetFavorite(int userId, int itemId, bool isFavorite);
    }
}
