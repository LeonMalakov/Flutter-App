import 'package:flutter/material.dart';
import 'package:flutter_app_client/constants/app_constants.dart';

class ScreenService {
  String _activeScreenRoute = RouteConstants.boot;

  String getActiveScreen() {
    return _activeScreenRoute;
  }

  void moveScreen(BuildContext context, String route) {
    if(_activeScreenRoute == route) {
      return;
    }

    _activeScreenRoute = route;
    Navigator.pushReplacementNamed(context, route);
  }

  void openPopup(BuildContext context, Widget popup) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => popup),
    );
  }
}