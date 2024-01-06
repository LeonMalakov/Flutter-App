import 'dart:convert';
import 'package:flutter_app_client/constants/api_constants.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_app_client/services/structures/token_pair.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String? _authToken;
  String? _refreshToken;

  bool _initialized = false;

  Future _initialize() async {
    if(_initialized) {
      return;
    }

    _initialized = true;
    _refreshToken= await Globals.services.storage.loadRefreshToken();
  }

  String getAuthToken() {
    return _authToken ?? "";
  }

  Future<bool> checkAuth() async {
    await _initialize();

    if(_refreshToken == null) {
      return false;
    }

    final pair = await Globals.services.remoteApiRequester.refresh(_refreshToken!);

    if(pair == null) {
      return false;
    }

    await _updateTokens(pair);
    return true;
  }

  Future<bool> tryLogIn(String email, String password) async {
    await _initialize();

    final pair = await Globals.services.remoteApiRequester.logIn(email, password);

    if(pair == null) {
      return false;
    }

    await _updateTokens(pair);
    return true;
  }

  Future<bool> trySignUp(String email, String password) async {
    await _initialize();

    final pair = await Globals.services.remoteApiRequester.signUp(email, password);

    if(pair == null) {
      return false;
    }

    await _updateTokens(pair);
    return true;
  }

  Future _updateTokens(TokenPair pair) async {
    _authToken = pair.access;
    _refreshToken = pair.refresh;
    await Globals.services.storage.saveRefreshToken(_refreshToken!);
  }
}