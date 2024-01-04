import 'package:flutter/widgets.dart';
import 'package:flutter_app_client/constants/app_constants.dart';

class ScreenService {
  String _activeScreenRoute = RouteConstants.boot;

  String getActiveScreen() {
    return _activeScreenRoute;
  }

  void moveScreen(BuildContext context, String route) {
    _activeScreenRoute = route;
    Navigator.pushReplacementNamed(context, route);
  }
}