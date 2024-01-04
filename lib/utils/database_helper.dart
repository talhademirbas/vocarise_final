/*
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  var abv = QuestcardController.instance;
  DatabaseHelper._init();

  final String _wordTable = 'word';
  final String _columnpri = 'primarywrd';
  final String _columnsec = 'secondwrd';
  final String _columnlvl = 'wrdlvl';

  Future<Database> get database async {
    debugPrint('db get');
    if (_database == null) {
      debugPrint('db nulldı ');
      _database = await _initDB();
    }
    debugPrint('db altı');
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'word.db');
    var wordDb = await openDatabase(path, version: 1, onCreate: _createDB);
    return wordDb;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
        "Create table $_wordTable($_columnpri TEXT PRIMARY KEY, $_columnsec TEXT NOT NULL, $_columnlvl INTEGER NOT NULL)");
  }

  //CRUD METHODS ARE HERE

  Future<List<Map<String, dynamic>>?> queryAllWords() async {
    Database db = await instance.database;
    var sonuc = await db.query(_wordTable, orderBy: '$_columnpri ASC');
    return sonuc;
  }

  Future<int?> addWordList(List<Word> wordlistesi) async {
    Future<int>? sonuc;
    Database db = await instance.database;
    for (var okunankel in wordlistesi) {
      sonuc = db.insert(_wordTable, okunankel.toMap());
    }
    return sonuc;
  }

  Future rankUpdate() async {
    Database db = await instance.database;
    int sonuc =
        await db.rawUpdate('UPDATE word SET wrdlvl = ? WHERE primarywrd = ?', [
      abv.wrdlvlmap[abv.wordmap.entries
          .firstWhere((element) =>
              element.value == abv.optionslist[abv.selectedAns.value!])
          .key
          .toString()],
      abv.secilenkey
    ]);
    DatabaseHelper.instance
        .queryAllWords()
        .then((value) => debugPrint('update sonrası sorgu:$value'));
    return sonuc;
  }

  Future<int?> deleteWordTablo() async {
    Database db = await instance.database;
    var sonuc = await db.delete(_wordTable);
    return sonuc;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

/*
  Future<int?> addWord(Word word) async {
    Database db = await instance.database;
    var sonuc = await db.insert(_wordTable, word.toMap());
    return sonuc;
  }
*/*/
