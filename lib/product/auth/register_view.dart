import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocarise_final/widgets/components/my_textfield.dart';
import 'package:vocarise_final/widgets/my_elevated_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.registerOnPressed});

  final VoidCallback registerOnPressed;
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  final nameController = TextEditingController();

  void showException(String exceptionMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(exceptionMessage));
        });
    debugPrint('exception dialog triggered');
  }

  // sign user in method
  void signUserUp() async {
    try {
      if (passwordController.text != passwordConfirmController.text) {
        showException("Passwords do not match");
        return;
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

//add user details
        await FirebaseFirestore.instance.collection('users').add({
          'displayName': nameController.text.trim(),
          'email': emailController.text.trim(),
        });
      }
    } on FirebaseAuthException catch (e) {
      showException(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                // name textfield
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                // confirm password textfield
                MyTextField(
                  controller: passwordConfirmController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // sign in button

                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: MyElevatedButton(
                      onPressed: signUserUp, child: const Text('Sign Up')),
                ),

                const SizedBox(height: 50),
                /*
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                   
                    InkWell(
                        onTap: () async {
                          await AuthService().signInWithGoogle();
                          await FirebaseFirestore.instance
                              .collection('users')
                              .add({
                            'displayName': nameController.text.trim(),
                            'email': emailController.text.trim(),
                          });
                        },
                        child: const SquareTile(
                            imagePath: 'assets/images/google.png')),
                  ],
                ),
*/
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: widget.registerOnPressed,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
