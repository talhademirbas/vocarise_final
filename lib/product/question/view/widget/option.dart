import 'package:flutter/material.dart';
import 'package:vocarise_final/constants.dart';
import 'package:vocarise_final/utils/quest_fb_controller.dart';

class Option extends StatefulWidget {
  const Option({required this.texttodisplay, required this.index, super.key});
  final String texttodisplay;
  final int index;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  var abv = QuestFbController.instance;

  Color getTheRightColor() {
    if (abv.isAnswered.value == false) {
      if (widget.index == abv.selectedAns.value) {
        return Colors.blue;
      }
    } else if (abv.isAnswered.value == true) {
      if (widget.index == abv.correctAns &&
          abv.selectedAns.value != abv.correctAns) {
        return ConstColors.kGreenColor; //yanlıs yapıldıysa correct silik yer
      } else if (widget.index == abv.correctAns) {
        return ConstColors.kGreenColor; //green light for the correct
      } else if (widget.index == abv.selectedAns.value &&
          abv.selectedAns.value != abv.correctAns) {
        return ConstColors.kRedColor; //seçilen şıksa ve doğru değilse red
      }
    }
    return MyColors.softGrey;
  }

  Color getTheRightColorForText() {
    if (abv.isAnswered.value == false) {
      if (widget.index == abv.selectedAns.value) {
        return Colors.blue;
      }
    } else if (abv.isAnswered.value == true) {
      if (widget.index == abv.correctAns &&
          abv.selectedAns.value != abv.correctAns) {
        return ConstColors.kGreenColor; //yanlıs yapıldıysa correct silik yer
      } else if (widget.index == abv.correctAns) {
        return ConstColors.kGreenColor; //green light for the correct
      } else if (widget.index == abv.selectedAns.value &&
          abv.selectedAns.value != abv.correctAns) {
        return ConstColors.kRedColor; //seçilen şıksa ve doğru değilse red
      }
    }
    return MyColors.pureBlack;
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == ConstColors.kRedColor
        ? Icons.close
        : Icons.done;
  }

  Color circleAvatarColor() {
    return getTheRightColor() == MyColors.softGrey ||
            getTheRightColor() == Colors.blue
        ? Colors.transparent
        : getTheRightColor();
  }

  Widget? getThatIcon() {
    return getTheRightColor() == MyColors.softGrey
        ? null
        : Icon(getTheRightIcon(), size: 16, color: MyColors.backgroundWhite);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
        valueListenable: abv.selectedAns,
        builder: (context, value, child) {
          return ValueListenableBuilder(
              valueListenable: abv.isAnswered,
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    abv.selectedAns.value = widget.index;
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: getTheRightColor()),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: Text(
                              widget.texttodisplay,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: getTheRightColorForText()),
                            ),
                          ),
                          FittedBox(
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: circleAvatarColor(),
                              child: getThatIcon(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
