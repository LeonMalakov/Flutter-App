import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final String loginButtonText;
  final Function() onAuthClicked;
  final Function(String) onLoginChanged;
  final Function(String) onPasswordChanged;

  const AuthForm({super.key, required this.formKey, required this.title, required this.loginButtonText, required this.onAuthClicked, required this.onLoginChanged, required this.onPasswordChanged});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Введите логин',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите логин';
              }
              return null;
            },
            onChanged: onLoginChanged,
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Введите пароль',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите пароль';
              }
              return null;
            },
            onChanged: onPasswordChanged,
          ),
          ElevatedButton(
            onPressed: onAuthClicked,
            child: Text(loginButtonText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }


}