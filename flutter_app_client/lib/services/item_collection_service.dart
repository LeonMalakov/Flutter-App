import 'dart:collection';

import 'package:flutter_app_client/data/item.dart';

import '../data/item_id.dart';

class ItemCollectionService {
  final Map<ItemId, Item> _map = {};
  final Map<int, ItemId> _itemSequence = {};
  final HashSet<ItemId> _favoriteItemIds = HashSet();

  ItemCollectionService() {
    //test();
  }

  bool isFavorite(ItemId id) {
    return _favoriteItemIds.contains(id);
  }

  List<ItemId> getFavoriteItemIds() {
    return _favoriteItemIds.toList();
  }

  void setFavoriteItemIds(List<ItemId> ids) {
    _favoriteItemIds.clear();
    _favoriteItemIds.addAll(ids);
  }

  ItemId? getSequenceItemId(int index) {
    return _itemSequence[index];
  }

  void addSequenceItemId(int index, ItemId id) {
    _itemSequence[index] = id;
  }

  List<Item> getAll() {
    return _map.values.toList();
  }

  Item? get(ItemId id) {
    return _map[id];
  }

  void set(Item item) {
    _map[item.id] = item;
  }

  void setIsFavorite(ItemId id, bool isFavorite) {
    if(isFavorite) {
      _favoriteItemIds.add(id);
    } else {
      _favoriteItemIds.remove(id);
    }
  }

/*  void test(){
    add(Item(
        id: const ItemId(1),
        title: 'Гнев Человеческий',
        subtitle: "Крутой фильм про стетхема",
        description: 'Крутой фильм про джейсона стетхема и его гнев. Очень крутой фильм. Смотрите его. В этом фильме стетхем всех убивает.',
        imageUrl: 'https://thumbs.dfs.ivi.ru/storage6/contents/8/8/84a1f2c0430452ab08f07c86eab477.jpg'
      ));

    add(Item(
        id: const ItemId(2),
        title: 'Гнев Человеческий 2',
        subtitle: "Еще не вышел",
        description: 'Такого фильма нет, но если бы он был, то он был бы про джейсона стетхема и его гнев. Очень крутой фильм. Смотрите его. В этом фильме стетхем всех убивает.',
        imageUrl: 'https://thumbs.dfs.ivi.ru/storage6/contents/8/8/84a1f2c0430452ab08f07c86eab477.jpg'
    ));

    setIsFavorite(const ItemId(1), true);
  }*/
}