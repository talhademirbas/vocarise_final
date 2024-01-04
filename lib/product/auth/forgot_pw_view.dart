import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocarise_final/constants.dart';
import 'package:vocarise_final/widgets/components/my_textfield.dart';
import 'package:vocarise_final/widgets/my_elevated_button.dart';

class ForgotPwView extends StatefulWidget {
  const ForgotPwView({super.key});

  @override
  State<ForgotPwView> createState() => _ForgotPwViewState();
}

class _ForgotPwViewState extends State<ForgotPwView> {
  final pwResetController = TextEditingController();

  void showException(String exceptionMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(exceptionMessage));
        });
    debugPrint('exception dialog triggered');
  }

  Future pwResetOnPressed() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: pwResetController.text.trim());

      showException(
          'We ve sent you a link, check your email to reset your password.');
    } on FirebaseAuthException catch (e) {
      showException(e.code);
    }
  }

  @override
  void dispose() {
    pwResetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset your password'),
        backgroundColor: MyColors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter your email here, we ll send you a password reset link.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: pwResetController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: MyElevatedButton(
                    onPressed: () {
                      pwResetOnPressed();
                    },
                    child: const Text('Reset Your Password')),
              )
            ]),
      ),
    );
  }
}
