import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/globals.dart';

import '../data/item_id.dart';

class ItemOperationsService {
  void toggleFavorite(ItemId id) {
    final item = Globals.services.itemCollection.get(id);
    if(item == null) {
      return;
    }

    Globals.services.itemCollection.setIsFavorite(id, !item.isFavorite);

    // TODO: бэк.
  }

  Future<List<Item>> getItemPage(int startIndex, int count) async {
    final List<ItemId> pageItemIds = [];
    final List<ItemId> itemIdsToLoad = [];
    final List<Item> items = [];

    // Получаем список id элементов на странице.
    if(!tryGetCachedPageItemIds(startIndex, count, pageItemIds)) {
      await Globals.services.remoteApiRequester.getItemIdPage(startIndex, count, pageItemIds);

      for(int i = 0; i < pageItemIds.length; i++) {
        Globals.services.itemCollection.addSequenceItemId(startIndex + i, pageItemIds[i]);
      }
    }

    // Формируем список id элементов, которых нет в кэше.
    for(ItemId id in pageItemIds){
      if(Globals.services.itemCollection.get(id) == null){
        itemIdsToLoad.add(id);
      }
    }

    // Скачиваем недостающие элементы.
    if(itemIdsToLoad.isNotEmpty) {
      await Globals.services.remoteApiRequester.getItems(itemIdsToLoad, items);

      for(final item in items) {
        Globals.services.itemCollection.set(item);
      }

      items.clear();
    }

    // Формируем список элементов страницы.
    for(final itemId in pageItemIds) {
      final item = Globals.services.itemCollection.get(itemId);
      if(item != null) {
        items.add(item);
      }
    }

    return items;
  }

  bool tryGetCachedPageItemIds(int startIndex, int count, List<ItemId> ids) {
    for(int i = startIndex; i < startIndex + count; i++){
      final itemId = Globals.services.itemCollection.getSequenceItemId(i);
      if(itemId == null) {
        ids.clear();
        return false;
      }

      ids.add(itemId);
    }

    return true;
  }
}