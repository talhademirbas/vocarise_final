// ignore_for_file: use_build_context_synchronously

library question_view;

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vocarise_final/constants.dart';
import 'package:vocarise_final/product/question/view/widget/question_appbar.dart';
import 'package:vocarise_final/service/get_service.dart';
import 'package:vocarise_final/service/model/question.dart';
import 'package:vocarise_final/product/question/view/widget/quest_card.dart';
import 'package:vocarise_final/service/model/word.dart';
import 'package:vocarise_final/service/model/word_detail_model.dart';
import 'package:vocarise_final/utils/quest_fb_controller.dart';
import 'package:vocarise_final/widgets/my_elevated_button.dart';

//part 'widget/question_appbar.dart';

//Bu sinif yeni soru cekecek servisi tetikleyecek vb isslemlerin dondugu sinif
@immutable
final class QuestionView extends StatefulWidget {
  const QuestionView(
      {super.key,
      required this.collectionName,
      required this.userID,
      required this.subColId});
  final String collectionName;
  final String userID;
  final String? subColId;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  var abv = QuestFbController.instance;

  late Future<bool> isInitialized;

  Future<bool> initializequestions() async {
    try {
      QuerySnapshot<Map<String, dynamic>> tumSorular = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(widget.userID)
          .collection('wordCollection')
          .doc(widget.subColId)
          .collection(widget.collectionName)
          .get();

      abv.wordlist = [];
      abv.wordmap = {};
      abv.wrdlvlmap = {};

      for (var element in tumSorular.docs) {
        var e = element.data();
        abv.wordlist.add(Word.withlvl(
            '${e['primary']}', '${e['secondary']}', e['wordLevel']));
      }

      for (var e in abv.wordlist) {
        abv.wordmap[e.primarywrd] = e.secondwrd;
        abv.wrdlvlmap[e.primarywrd] = e.wrdlvl;
      }

      await abv.getQuest();

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    isInitialized = initializequestions();
    //initialize listener
    abv.isWrong.addListener(() async {
      if (abv.isWrong.value) {
        try {
          abv.wordDetails = await GetService().fetchWordDetails(abv.secilenkey);
          await showWrongModal(context, abv.wordDetails);
        } catch (e) {
          debugPrint('$e');
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 220, 224),
      appBar: const QuestionAppbar(),
      body: FutureBuilder(
          future: isInitialized,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(
                        flex: 4,
                      ),
                      ValueListenableBuilder(
                        builder: (BuildContext context, value, Widget? child) {
                          inspect(abv.wordDetails);
                          return QuestCard(
                            question: Question(
                              question: abv.secilenkey,
                              options: abv.optionslist,
                              answer: abv.valueindex,
                              questlvl: abv.questlvl,
                            ),
                          );
                        },
                        valueListenable: abv.secilenKeyNotifier,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: MyElevatedButton(
                            onPressed: () {
                              if (abv.selectedAns.value != null) {
                                abv.checkAns(
                                  Question(
                                    question: abv.secilenkey,
                                    options: abv.optionslist,
                                    answer: abv.valueindex,
                                    questlvl: abv.questlvl,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Check',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: MyColors.backgroundWhite),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}/// ');
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          }),
    );
  }

  VoidCallback? getAudioOnPressed() {
    AudioPlayer().play(UrlSource(abv.wordDetails!.phonetics![0].audio!));
    return null;
  }

  Future<void> showWrongModal(
      BuildContext context, WordDetailModel? wordDetails) {
    return showModalBottomSheet<void>(
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: const Color.fromARGB(255, 248, 231, 231),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        FittedBox(
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: MyColors.red,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: MyColors.backgroundWhite,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Incorrect',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: MyColors.red,
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${wordDetails?.word?.toCapitalized()} : ${abv.optionslist[abv.valueindex].toCapitalized()}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '${wordDetails?.meanings?[0].partOfSpeech}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          wordDetails?.phonetic ?? '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Text(
                      wordDetails?.meanings?.first.definitions?.first.example ??
                          '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: MyElevatedButton(
                            child: Text(
                              'I understood',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: MyColors.backgroundWhite),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              abv.nextQuestion();
                            },
                          )),
                    ),
                  ]),
            ),
          );
        });
  }
}

/*
 bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.deepPurple,
        fixedColor: MyColors.backgroundWhite,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.airport_shuttle_outlined), label: 'Profile'),
        ],
      ),*/

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
