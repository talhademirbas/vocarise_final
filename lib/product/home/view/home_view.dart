import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vocarise_final/constants.dart';
import 'package:vocarise_final/product/question/view/question_view.dart';
import 'package:vocarise_final/product/question/view/widget/main_appbar.dart';
import 'package:vocarise_final/utils/quest_fb_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var abv = QuestFbController.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> postStream = FirebaseFirestore
      .instance
      .collection('wordCollection')
      .doc('EnTr')
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 83, 46, 122),
        appBar: const MainAppbar(),
        body: StreamBuilder(
            stream: postStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List? items = snapshot.data?.data()?['collectionNames'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: items?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, double> dataMap = {
                        "0": 0,
                        "1": 3,
                        "2": 2,
                        "3": 2,
                        "4": 2,
                      };
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: InkWell(
                          onTap: () async {
                            QuerySnapshot<Map<String, dynamic>>
                                wordCollectionSnapshot = await FirebaseFirestore
                                    .instance
                                    .collection('wordCollection')
                                    .doc('EnTr')
                                    .collection(items?[index])
                                    .get();

                            List<QueryDocumentSnapshot<Map<String, dynamic>>>
                                wordCollectionDOCS =
                                wordCollectionSnapshot.docs;

                            //user sync
                            var myuSER = await FirebaseFirestore.instance
                                .collection('users')
                                .where('email',
                                    isEqualTo: FirebaseAuth
                                        .instance.currentUser?.email)
                                .get();
                            String userId = myuSER.docs.first.id;
                            String? ref = snapshot.data?.reference.id;

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .collection('wordCollection')
                                .doc(ref)
                                .collection(items?[index])
                                .get()
                                .then((value) {
                              if (value.docs.isEmpty) {
                                wordCollectionDOCS.forEach((e) async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userId)
                                      .collection('wordCollection')
                                      .doc(ref)
                                      .collection(items?[index])
                                      .doc(e.data()['primary'])
                                      .set(e.data());
                                });
                              }
                            });
                            abv.userID = userId;
                            abv.collectionName = items?[index];
                            abv.subColId = ref;
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return QuestionView(
                                  collectionName: items?[index],
                                  userID: userId,
                                  subColId: ref,
                                );
                              },
                            ));
                          },
                          child: Card(
                            color: MyColors.backgroundWhite,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          '${items?[index]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                      PieChart(
                                        colorList: const [
                                          Color(0xFFff0a0a),
                                          Color(0xFFf2ce02),
                                          Color(0xFFebff0a),
                                          Color(0xFF85e62c),
                                          Color(0xFF209c05),
                                        ],
                                        legendOptions: const LegendOptions(
                                            showLegends: false),
                                        chartValuesOptions:
                                            const ChartValuesOptions(
                                                showChartValues: false),
                                        chartType: ChartType.ring,
                                        chartRadius: 40,
                                        dataMap: dataMap,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: MyColors.softGrey,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 14.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Study these words',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const Icon(Icons.chevron_right_outlined)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error!.toString()}');
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}
