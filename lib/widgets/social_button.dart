import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData buttonicon;
  final Color buttoncolor;

  const SocialButton(this.buttonicon, this.buttoncolor, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 60, height: 50),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: buttoncolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Center(child: Icon(buttonicon))),
    );
  }
}
