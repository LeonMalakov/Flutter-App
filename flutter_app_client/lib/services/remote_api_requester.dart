import 'dart:convert';

import 'package:flutter_app_client/data/item.dart';
import 'package:flutter_app_client/data/item_id.dart';
import 'package:flutter_app_client/services/i_remote_api_requester.dart';
import 'package:flutter_app_client/services/structures/token_pair.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

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
  Future getFavoriteItemIds(List<ItemId> outIds) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future getItemIdPage(int startIndex, int count, List<ItemId> outIds) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future getItems(List<ItemId> ids, List<Item> outItems) async {
    await Future.delayed(const Duration(seconds: 1));
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
