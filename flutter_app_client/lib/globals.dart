import 'package:flutter_app_client/services/auth_service.dart';
import 'package:flutter_app_client/services/screen_service.dart';

class Globals {
  static final services = Services();
}

class Services {
  final auth = AuthService();
  final screen = ScreenService();
}