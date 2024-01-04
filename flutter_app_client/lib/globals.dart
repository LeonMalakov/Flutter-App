import 'package:flutter_app_client/services/auth_service.dart';
import 'package:flutter_app_client/services/screen_service.dart';

import 'factories/item_popup_factory.dart';

class Globals {
  static final services = Services();
  static final factories = Factories();
}

class Services {
  final auth = AuthService();
  final screen = ScreenService();
}

class Factories {
  final itemPopup = ItemPopupFactory();
}