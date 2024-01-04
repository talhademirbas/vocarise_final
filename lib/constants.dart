import 'package:flutter/material.dart';

const double kDefaultPadding = 20.0;

class ConstColors {
  static const MaterialColor kprimaryColor = Colors.deepPurple;
  static const MaterialAccentColor ksecondaryColor = Colors.deepPurpleAccent;
  static const kGreenColor = Color(0xFF209c05);
  static const kRedColor = Color(0xFFff0a0a);

  static const kPrimaryGradient = LinearGradient(
    colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class MyColors {
  static Color backgroundWhite = const Color(0XffF3F8FF);
  static Color whiteWithOpacity = Colors.white.withOpacity(0.7);
  static const Color softGrey = Color(0xffEEEEEE);
  static const Color pureBlack = Color(0xff000000);
  static const Color deepPurple = Color(0xff49108B);
  static const Color deepPurpleAccent = Color(0xff7E30E1);

  static const Color red = Color(0xFFff0a0a);
  static const Color orange = Color.fromARGB(255, 242, 118, 2);
  //static const Color neutral = Color.fromARGB(255, 255, 242, 0);
  static const Color neutral = MyColors.softGrey;
  static const Color green = Color(0xFF85e62c);
  static const Color darkGreen = Color(0xFF209c05);

//enum gelecek list icin

  //enum QuestLvlColors { MyColors.red, MyColors.orange, MyColors.neutral,MyColors.green,MyColors.darkGreen }
}
