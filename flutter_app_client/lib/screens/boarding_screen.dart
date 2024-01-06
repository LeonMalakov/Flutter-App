import 'package:flutter/material.dart';
import 'package:flutter_app_client/constants/layout_constants.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_app_client/screens/widgets/boarding_screen_item.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

import '../constants/app_constants.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() {
    return _BoardingScreenState();
  }
}

class _BoardingScreenState extends State<BoardingScreen> {
  void _moveRegister() {
    Globals.services.screen.moveScreen(context, RouteConstants.signup);
  }

  void _moveLogin() {
    Globals.services.screen.moveScreen(context, RouteConstants.login);
  }

  @override
  Widget build(BuildContext context) {
    final items = Globals.services.boarding.getItems();

    List<Widget> background = [];
    List<Widget> bodies = [];
    for (var item in items) {
      background.add(Image.asset(item.imagePath, width: MediaQuery.of(context).size.width, alignment: Alignment.topCenter));
      bodies.add(BoardingScreenItem(description: item.description));
    }

    return OnBoardingSlider(
        headerBackgroundColor: LayoutConstants.headerColor,
        controllerColor: LayoutConstants.mainColor,
        finishButtonText: 'Зарегистрироваться',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: LayoutConstants.headerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        skipTextButton: const Text('Пропустить', style: TextStyle(color: Colors.black, fontSize: 18)),
        trailing: const Text('Войти', style: TextStyle(color: Colors.black, fontSize: 18)),
        background: background,
        totalPage: items.length,
        speed: 1.8,
        pageBodies: bodies,
        onFinish: _moveRegister,
        trailingFunction: _moveLogin
      );
  }
}