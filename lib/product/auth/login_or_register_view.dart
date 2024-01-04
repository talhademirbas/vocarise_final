import 'package:flutter/material.dart';
import 'package:vocarise_final/product/auth/register_view.dart';
import 'package:vocarise_final/product/auth/login_view.dart';

class LoginOrRegisterView extends StatefulWidget {
  const LoginOrRegisterView({super.key});

  @override
  State<LoginOrRegisterView> createState() => _LoginOrRegisterViewState();
}

class _LoginOrRegisterViewState extends State<LoginOrRegisterView> {
  bool showLoginView = true;

  void togglePages() {
    setState(() {
      showLoginView = !showLoginView;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginView) {
      return LoginView(
        registerOnPressed: togglePages,
      );
    } else {
      return RegisterView(registerOnPressed: togglePages);
    }
  }
}
