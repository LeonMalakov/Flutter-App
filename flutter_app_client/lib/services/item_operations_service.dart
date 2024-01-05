import 'dart:math';

import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/globals.dart';

import '../data/item_id.dart';

class ItemOperationsService {
  bool _initialized = false;

  void toggleFavorite(ItemId id) {
    final item = Globals.services.itemCollection.get(id);
    if(item == null) {
      return;
    }

    Globals.services.itemCollection.setIsFavorite(id,
      !Globals.services.itemCollection.isFavorite(id));

    // TODO: бэк.
  }

  Future<List<Item>> getItemPage(int startIndex, int count) async {
    await _initialize();

    final List<ItemId> pageItemIds = [];
    final List<ItemId> itemIdsToLoad = [];
    final List<Item> items = [];

    // Получаем список id элементов на странице.
    if(!_tryGetCachedPageItemIds(startIndex, count, pageItemIds)) {
      await Globals.services.remoteApiRequester.getItemIdPage(startIndex, count, pageItemIds);

      for(int i = 0; i < pageItemIds.length; i++) {
        Globals.services.itemCollection.addSequenceItemId(startIndex + i, pageItemIds[i]);
      }
    }

    // Загружаем элементы.
    await _getOrLoadItems(pageItemIds, itemIdsToLoad, items);

    return items;
  }

  Future<List<Item>> getFavoriteItemPage(int startIndex, int count) async {
    await _initialize();

    final List<ItemId> pageItemIds = [];
    final List<ItemId> itemIdsToLoad = [];
    final List<Item> items = [];

    // Список id избранных.
    final favoriteItemIds = Globals.services.itemCollection.getFavoriteItemIds();

    // Формируем список id элементов страницы.
    for(int i = startIndex; i < min(startIndex + count, favoriteItemIds.length); i++) {
      final itemId = favoriteItemIds[i];
      pageItemIds.add(itemId);
    }

    // Загружаем элементы.
    await _getOrLoadItems(pageItemIds, itemIdsToLoad, items);

    return items;
  }

  Future _initialize() async {
    if(!_initialized){
      List<ItemId> itemIds = [];
      await Globals.services.remoteApiRequester.getFavoriteItemIds(itemIds);
      Globals.services.itemCollection.setFavoriteItemIds(itemIds);
      _initialized = true;
    }
  }

  Future _getOrLoadItems(List<ItemId> itemIds, List<ItemId> itemIdsToLoad, List<Item> items) async {
    // Формируем список id элементов, которых нет в кэше.
    for(ItemId id in itemIds){
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
    for(final itemId in itemIds) {
      final item = Globals.services.itemCollection.get(itemId);
      if(item != null) {
        items.add(item);
      }
    }
  }

  bool _tryGetCachedPageItemIds(int startIndex, int count, List<ItemId> ids) {
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