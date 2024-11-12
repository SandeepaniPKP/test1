import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test1/model/users.dart';
import '../model/notes_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  String users = "create table users (usrID INTEGER PRIMARY KEY AUTOINCREMENT , usrName TEXT UNIQUE, usrPassword TEXT )";


  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_notes.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      content TEXT,
      color TEXT,
      dateTime TEXT
    )
    ''');
    await db.execute(users);

  }

  // This method will handle database upgrades (e.g., adding new columns)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE notes ADD COLUMN content TEXT');
      print("Database upgraded, added 'content' column");
    }
  }

  //login method
  Future<bool> login(Users user) async{
    final Database db = await _initDatabase();

    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' "
            "AND usrPassword ='${user.usrPassword}'");
    if (result.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  //Sign up method
  Future<int> signup(Users user) async {
    final Database db = await _initDatabase();
    return db.insert('users', user.toMap());
  }


  Future<int> insertNote(Note note) async {
    final db = await database;
    final result = await db.insert('notes', note.toMap());
    print("Note inserted: ${note.toMap()}");
    return result;
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('notes');
    print("Fetched notes: ${maps.length}");
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  Future<int> updateNote(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}