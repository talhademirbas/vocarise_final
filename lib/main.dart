// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vocarise_final/firebase_options.dart';
import 'package:vocarise_final/product/auth/auth_view.dart';
import 'package:vocarise_final/product/auth/login_view.dart';
import 'package:vocarise_final/product/question/view/question_view.dart';
import 'package:vocarise_final/utils/questcard_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await QuestcardController.instance.initializesDB();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocarise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const AuthView(),
    );
  }
}
