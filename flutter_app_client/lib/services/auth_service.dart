import 'dart:convert';
import 'package:flutter_app_client/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String? _authToken;
  String? _refreshToken;

  Future<bool> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    return false;
  }

  Future<bool> tryAuth(String email, String password) async {
    return true;
    /*final response = await http.post(
        Uri.parse(ApiConstants.loginUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password
        })
    );

    if(response.statusCode != 200){
      return false;
    }

    final data = jsonDecode(response.body);
    if (!data['auth']) {
      return false;
    }

    String authToken = data['auth'];
    String refreshToken = data['refresh'];

    _authToken = authToken;
    _refreshToken = refreshToken;
*/
    return true;
  }
}