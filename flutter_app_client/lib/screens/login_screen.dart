import 'package:flutter/material.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_app_client/screens/widgets/auth_form.dart';

import '../constants/app_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _login = "";
  String _password = "";

  void _moveToHome() {
    Globals.services.screen.moveScreen(context, RouteConstants.home);
  }

  void _moveToSignup() {
    Globals.services.screen.moveScreen(context, RouteConstants.signup);
  }

  void _showError(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }

  void _onAuthClicked() async {
    if (!_formKey.currentState!.validate()) {
      _showError('Введите данные для входа');
      return;
    }

    bool result = await Globals.services.auth.tryLogIn(_login, _password);

    if (!result) {
      _showError('Неверный логин или пароль');
      return;
    }

    _moveToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthForm(
              formKey: _formKey,
              title: 'Вход',
              loginButtonText: 'Войти',
              onAuthClicked: _onAuthClicked,
              onLoginChanged: (value) {
                _login = value;
              },
              onPasswordChanged: (value) {
                _password = value;
              },
            ),
            TextButton(
              onPressed: _moveToSignup,
              child: const Text('Нет аккаунта? Зарегистрируйтесь'),
            ),
          ],
        )
    );
  }
}