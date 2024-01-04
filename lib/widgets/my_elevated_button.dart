import 'package:flutter/material.dart';
import 'package:vocarise_final/constants.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: MyColors.deepPurple),
        onPressed: onPressed,
        child: Padding(padding: const EdgeInsets.all(18.0), child: child));
  }
}
