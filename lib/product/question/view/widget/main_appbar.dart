//part of '../question_view.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocarise_final/constants.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final title = 'Vocarise';

  const MainAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: const Icon(Icons.logout_outlined))
      ],
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: MyColors.deepPurple,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}
