// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocarise_final/product/auth/login_or_register_view.dart';
import 'package:vocarise_final/product/home/view/home_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
//user logged in
              if (snapshot.hasData) {
                return const HomeView();
              }
//user not logged in
              else {
                return LoginOrRegisterView();
              }
            }));
  }
}
