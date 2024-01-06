using Casino.DAL.Models;
using Casino.DAL.Respositories;
using Casino.Utility;
using Microsoft.Extensions.Logging;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Casino.Services {
    public sealed class AppService : IAppService {
        private IAppRepository _repository;
        private ILogger<AppService> _logger;

        public AppService(IAppRepository repository, ILoggerFactory loggerFactory) {
            _repository = repository;
            _logger = loggerFactory.CreateLogger<AppService>();

            if (ItemDataLoading.TryLoad(out var dataItem)) {
                _repository.CreateItems(dataItem);
            }
        }

        public async ValueTask<List<Item>> GetItems(int[] itemIds) {
            var items = new List<Item>();
            
            foreach(var itemId in itemIds) {
                var item = await _repository.GetItem(itemId);
                if(item == null) {
                    _logger.LogInformation($"Item with id '{itemId}' not found");
                    continue;
                }
                items.Add(item);
            }

            return items;
        }

        public async ValueTask<List<int>> GetItemIdPage(int startIndex, int count) {
            return await _repository.GetItemIds(startIndex, count);
        }

        public async ValueTask<List<int>> GetFavorites(int userId) {
            return await _repository.GetFavorites(userId);
        }

        public async ValueTask<bool> SetFavorite(int userId, int itemId, bool isFavorite) {
            return await _repository.SetFavorite(userId, itemId, isFavorite);
        }
    }
}
