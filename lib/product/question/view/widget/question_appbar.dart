//part of '../question_view.dart';

import 'package:flutter/material.dart';
import 'package:vocarise_final/constants.dart';

class QuestionAppbar extends StatelessWidget implements PreferredSizeWidget {
  final title = 'Vocarise';

  const QuestionAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
}
