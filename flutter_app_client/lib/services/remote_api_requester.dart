import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/data/item_id.dart';
import 'package:flutter_app_client/services/i_remote_api_requester.dart';
import 'package:flutter_app_client/services/structures/token_pair.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../globals.dart';
import '../utility/string_array_serialization_utility.dart';

class RemoteApiRequester implements IRemoteApiRequester {

  @override
  Future<TokenPair?> signUp(String userName, String password) async {
    final response = await http.post(
        Uri.parse(ApiConstants.signupUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userName": userName,
          "password" : password
        })
    );

    if(response.statusCode != 200) {
      return null;
    }

    final tokenPair = _tryGetTokenPairFromJson(response.body);

    if(tokenPair == null) {
      return null;
    }

    return tokenPair;
  }

  @override
  Future<TokenPair?> logIn(String userName, String password) async {
    final response = await http.get(
        Uri.parse("${ApiConstants.loginUrl}?userName=$userName&password=$password"),
        headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode != 200) {
      return null;
    }

    final tokenPair = _tryGetTokenPairFromJson(response.body);

    if(tokenPair == null) {
      return null;
    }

    return tokenPair;
  }

  @override
  Future<TokenPair?> refresh(String refreshToken) async {
    final response = await http.post(
        Uri.parse(ApiConstants.refreshUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "refreshToken": refreshToken,
        })
    );

    if(response.statusCode != 200) {
      return null;
    }

    final tokenPair = _tryGetTokenPairFromJson(response.body);

    if(tokenPair == null) {
      return null;
    }

    return tokenPair;
  }

  @override
  Future<bool> getFavoriteItemIds(List<ItemId> outIds) async {
    final response = await http.get(
      Uri.parse(ApiConstants.getFavoritesUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Globals.services.auth.getAuthToken()}'
      },
    );

    if (kDebugMode) {
      print("getFavoriteItemIds: ${response.statusCode}, ${response.body}");
    }

    if(response.statusCode != 200) {
      return false;
    }

    final data = response.body;
    final ids = StringArraySerializationUtility.deserialize(data);
    for(ItemId id in ids){
      outIds.add(id);
    }

    return true;
  }

  @override
  Future<bool> getItemIdPage(int startIndex, int count, List<ItemId> outIds) async {
    final response = await http.get(
      Uri.parse("${ApiConstants.getItemIdPageUrl}?StartIndex=$startIndex&Count=$count"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Globals.services.auth.getAuthToken()}'
      },
    );

    if (kDebugMode) {
      print("getItemIdPage: ${response.statusCode}, ${response.body}");
    }

    if(response.statusCode != 200) {
      return false;
    }

    final data = response.body;
    final ids = StringArraySerializationUtility.deserialize(data);
    for(ItemId id in ids){
      outIds.add(id);
    }

    return true;
  }

  @override
  Future<bool> getItems(List<ItemId> ids, List<Item> outItems) async {
    String idsStr = StringArraySerializationUtility.serialize(ids);

    final response = await http.get(
      Uri.parse("${ApiConstants.getItemsUrl}?ItemIds=$idsStr"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Globals.services.auth.getAuthToken()}'
      },
    );

    if (kDebugMode) {
      print("getItems: ${response.statusCode}, ${response.body}");
    }

    if(response.statusCode != 200) {
      return false;
    }

    final data = jsonDecode(response.body);

    for(final itemData in data) {
      final item = Item(
        id: ItemId(itemData['Id']),
        title: itemData['Title'],
        subtitle: itemData['Subtitle'],
        description: itemData['Description'],
        imageUrl: itemData['ImageUrl'],
      );

      outItems.add(item);
    }

    return true;
  }

  @override
  Future<bool> setFavorite(ItemId favorite, bool isFavorite) async {
    final response = await http.post(
      Uri.parse(ApiConstants.setFavoriteUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Globals.services.auth.getAuthToken()}'
      },
      body: jsonEncode({
        "itemId": favorite.value,
        "isFavorite": isFavorite
      })
    );

    if (kDebugMode) {
      print("setFavorite: ${response.statusCode}, ${response.body}");
    }

    if(response.statusCode != 200) {
      return false;
    }

    return true;
  }

  TokenPair? _tryGetTokenPairFromJson(String json) {
    final data = jsonDecode(json);

    String? access = data['accessToken'];
    String? refresh = data['refreshToken'];

    if(access == null || refresh == null) {
      return null;
    }

    return TokenPair(access: access, refresh: refresh);
  }
}
