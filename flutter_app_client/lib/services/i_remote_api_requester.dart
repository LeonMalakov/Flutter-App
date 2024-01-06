import 'package:flutter_app_client/services/structures/token_pair.dart';

import '../data/item.dart';
import '../data/item_id.dart';

abstract interface class IRemoteApiRequester {
  Future<TokenPair?> signUp(String userName, String password);

  Future<TokenPair?> logIn(String userName, String password);

  Future<TokenPair?> refresh(String refreshToken);

  Future<bool> getItemIdPage(int startIndex, int count, List<ItemId> outIds);

  Future<bool> getItems(List<ItemId> ids, List<Item> outItems);

  Future<bool> getFavoriteItemIds(List<ItemId> outIds);

  Future<bool> setFavorite(ItemId favorite, bool isFavorite);
}