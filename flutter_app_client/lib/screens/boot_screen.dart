import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../globals.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() {
    return _BootScreenState();
  }
}

class _BootScreenState extends State<BootScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _moveToScreen(String route) {
    Globals.services.screen.moveScreen(context, route);
  }

  void _init() async {
    bool authSuccess = await Globals.services.auth.checkAuth();

    if(authSuccess) {
      _moveToScreen(RouteConstants.home);
    } else{
      _moveToScreen(RouteConstants.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}