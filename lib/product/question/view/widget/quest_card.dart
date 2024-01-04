import 'package:flutter/material.dart';
import 'package:vocarise_final/constants.dart';
import 'package:vocarise_final/service/model/question.dart';
import 'package:vocarise_final/product/question/view/widget/option.dart';

final class QuestCard extends StatelessWidget {
  const QuestCard({
    required this.question,
    super.key,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    final questLvlColors = <Color>[
      const Color(0xFFff0a0a),
      const Color(0xFFf2ce02),
      const Color(0xFFebff0a),
      const Color(0xFF85e62c),
      const Color(0xFF209c05),
    ];

    Color getTheLvlColor() {
      return questLvlColors[question.questlvl];
    }

    return Card(
      color: MyColors.backgroundWhite,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: MyColors.softGrey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    question.question,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: getTheLvlColor(),
                  border: Border.all(color: MyColors.softGrey),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 8,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 20 / 2),
            ...List.generate(
              question.options.length,
              (index) => Option(
                index: index,
                texttodisplay: question.options[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
