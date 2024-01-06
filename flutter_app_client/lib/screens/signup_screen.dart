import 'package:flutter/material.dart';
import 'package:flutter_app_client/globals.dart';
import 'package:flutter_app_client/screens/widgets/auth_form.dart';

import '../constants/app_constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _login = "";
  String _password = "";

  void _moveToHome() {
    Globals.services.screen.moveScreen(context, RouteConstants.home);
  }

  void _moveToLogin() {
    Globals.services.screen.moveScreen(context, RouteConstants.login);
  }

  void _showError(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }

  void _onAuthClicked() async {
    if (!_formKey.currentState!.validate()) {
      _showError('Введите данные для регистрации');
      return;
    }

    bool result = await Globals.services.auth.trySignUp(_login, _password);

    if (!result) {
      _showError('Пользователь с таким именем уже существует');
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
              title: 'Регистрация',
              loginButtonText: 'Зарегистрироваться',
              onAuthClicked: _onAuthClicked,
              onLoginChanged: (value) {
                _login = value;
              },
              onPasswordChanged: (value) {
                _password = value;
              },
            ),
            TextButton(
              onPressed: _moveToLogin,
              child: const Text('Уже есть аккаунт? Войти'),
            ),
          ],
        )
    );
  }
}