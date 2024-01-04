//This class provides business logic related to Question card. All the Methods and Variables.



/*
class QuestcardController {
  static final QuestcardController instance = QuestcardController();

  ValueNotifier<String> secilenKeyNotifier = ValueNotifier('');

  ValueNotifier<bool> isAnswered = ValueNotifier<bool>(false);

  ValueNotifier<int?> selectedAns = ValueNotifier<int?>(null);

  ValueNotifier<bool> isWrong = ValueNotifier(false);

  late int correctAns;
  int numOfCorrectAns = 0;
  late int valueindex;

  Map wordmap = {};
  Map wrdlvlmap = {};

  late List keysEnTr; //You made a list of map keys
  late List valuesEnTr; //You made a list of map values

  late String secilenkey; //choosing random key from the key list
  late String secilenkeyinvaluesi; //value of the key

  late List<String> optionslist;

  late int questlvl;
  String? lastkey; //this key provides not to ask last question after again

  List wordlist = [];
  final PageController pageController = PageController();
  var valuee = ' ';

  Future<bool> initializesDB() async {
    //await DatabaseHelper.instance.deleteWordTablo();

    await DatabaseHelper.instance.queryAllWords().then((value) async {
      if (value!.isEmpty) {
        await DatabaseHelper.instance.addWordList(DataEnTr().initialWordList);
      } else if (value.isNotEmpty) {
        valuee = value.toString();
      }
      await DatabaseHelper.instance.queryAllWords().then((values) async {
        for (Map x in values!) {
          wordlist.add(Word.fromMap(x)); //obje halinde wordler duruyor
        }
        for (Word oneword in wordlist) {
          wordmap[oneword.primarywrd] = oneword.secondwrd;
          wrdlvlmap[oneword.primarywrd] = oneword.wrdlvl;
        }
        getQuest(); //quest selection part
      }).catchError((hata) {});
    });
    return true;
  }

  getQuest() async {
    debugPrint("getQuest() metodu çalıştı");
    isAnswered.value = false; //
    keysEnTr = wordmap.keys.toList();
    valuesEnTr = wordmap.values.toList();

    if (lastkey != null) {
      // ilk soruysa last key olmayacağı için
      keysEnTr.remove(lastkey); //keylerin indeks 1 azaldı belki
    }
    int randnum = Random().nextInt(keysEnTr.length); //from 0 upto max included
    secilenkey = keysEnTr[randnum]; //choosing random key from the key list
    secilenkeyinvaluesi = wordmap[secilenkey]; //value of the key you choosed
    valuesEnTr.remove(secilenkeyinvaluesi); //To not reexist in options
    valuesEnTr.shuffle(); //so can choose other options çekilishly w indexes
    optionslist = [
      secilenkeyinvaluesi,
      valuesEnTr[0],
      valuesEnTr[1],
      valuesEnTr[2]
    ];
    optionslist.shuffle(); //şıklar düzgün, yerleri shuffle oluyor
    lastkey = secilenkey; //lastkey güncelleniyor

    valueindex = optionslist.indexOf(secilenkeyinvaluesi);

    questlvl = wrdlvlmap[secilenkey];
    secilenKeyNotifier.value = secilenkey;
    selectedAns.value = null;
  }

  Future<void> checkAns(Question question) async {
    correctAns = question.answer;
    isAnswered.value = true;

    if (correctAns == selectedAns.value) {
      //doğru cevap durumu
      numOfCorrectAns++;
      if (wrdlvlmap[question.question] < 4) {
        wrdlvlmap[question.question]++;
        await DatabaseHelper.instance.rankUpdate();
      }
      nextQuestion();
    } else if (correctAns != selectedAns.value) {
      //yanlış cevap durumu
      if (wrdlvlmap[question.question] > 0) {
        wrdlvlmap[question.question]--;
        DatabaseHelper.instance.rankUpdate();
      }
      //yanloş işsaretlediğinin primary si
      if (wrdlvlmap[wordmap.entries
              .firstWhere(
                  (element) => element.value == optionslist[selectedAns.value!])
              .key
              .toString()] >
          0) {
        wrdlvlmap[wordmap.entries
            .firstWhere(
                (element) => element.value == optionslist[selectedAns.value!])
            .key
            .toString()]--;
        //üçüncü database
        DatabaseHelper.instance.rankUpdate();
      }
      //üst tarafı listede güncelle gibi bi şey olark izole edebilirsin

      isWrong.value = true;
    }
  }

  void nextQuestion() async {
    isAnswered.value = false;
    isWrong.value = false;
    selectedAns.value = null;
    await getQuest();
  }
}
*/