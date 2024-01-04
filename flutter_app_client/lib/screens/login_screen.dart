import 'package:flutter/material.dart';
import 'package:flutter_app_client/globals.dart';

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
  String _email = "";
  String _password = "";

  void _moveToHome() {
    Globals.services.screen.moveScreen(context, RouteConstants.home);
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

    bool result = await Globals.services.auth.tryAuth(_email, _password);

    if (!result) {
      _showError('Неверный логин или пароль');
      return;
    }

    _moveToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  _email = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  _password = value;
                },
              ),
              ElevatedButton(
                onPressed: _onAuthClicked,
                child: const Text('Войти'),
              ),
            ],
          ),
        ),
      )
    );
  }
}