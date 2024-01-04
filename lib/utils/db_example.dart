/*import 'package:flutter/material.dart';
import 'package:vocarise_final/assets/data_en_tr.dart';
import 'package:vocarise_final/model/word.dart';
import 'package:vocarise_final/utils/database_helper.dart';
//bu sayfa db kullanımı örnek için yapıldı uygulamayla alakası yok zaten page bu, utils değil

class SqfliteProcess extends StatefulWidget {
  const SqfliteProcess({Key? key}) : super(key: key);

  @override
  _SqfliteProcessState createState() => _SqfliteProcessState();
}

class _SqfliteProcessState extends State<SqfliteProcess> {
  List<Word> wordlist = [];

  @override
  void initState() {
    super.initState();

    DatabaseHelper.instance.deleteWordTablo();
    DatabaseHelper.instance.addWordList(DataEnTr().InitialWordList);
    debugPrint('initstateb');
    DatabaseHelper.instance.queryAllWords().then((listthatkeepsallthewords) {
      for (Map okunankelimemapi in listthatkeepsallthewords!) {
        wordlist.add(Word.fromMap(okunankelimemapi));
      }
      debugPrint('Dbden gelen ögr sayısı:' + wordlist.length.toString());
    }).catchError((hata) {
      debugPrint('hata:' + hata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SqfliteProcesso'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(onPressed: () {}, child: const Text('Rankup'))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: wordlist.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  title: Text(wordlist[index].primarywrd),
                  subtitle: Text(wordlist[index].secondwrd),
                  leading: Text(wordlist[index].wrdlvl.toString()),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/