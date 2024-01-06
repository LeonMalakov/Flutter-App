import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_constants.dart';

class StorageService{
  Future saveRefreshToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StorageConstants.refreshToken, value);
  }

  Future<String?> loadRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageConstants.refreshToken);
  }
}