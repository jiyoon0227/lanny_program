//Database 초기화 및 관리
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_table (
        user_id TEXT PRIMARY KEY,
        user_email TEXT NOT NULL,
        user_name TEXT NOT NULL,
        user_password TEXT NOT NULL,
        user_profile_image TEXT,
        user_selected_language TEXT,
        user_streak_count INTEGER,
        user_longest_streak_count INTEGER,
        user_total_attendance_count INTEGER,
        user_mastered_words_count INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE chapter_table (
        chapter_id INTEGER PRIMARY KEY, 
        chapter_name TEXT NOT NULL, 
        chapter_description TEXT NOT NULL, 
        progress REAL NOT NULL, 
        chapter_icon TEXT NOT NULL
      );
    ''');
    await db.execute('''
    CREATE TABLE word_table (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      chapter_id INTEGER NOT NULL,
      korean_word TEXT NOT NULL,
      translated_word TEXT NOT NULL,
      romanized_word TEXT NOT NULL,
      "order" INTEGER NOT NULL,
      is_learned INTEGER NOT NULL,
      FOREIGN KEY(chapter_id) REFERENCES chapter_table(chapter_id)
    )
  ''');
    await db.execute('''
      CREATE TABLE chapter_words_table (
        chapter_id INTEGER,
        words_json TEXT NOT NULL,
        FOREIGN KEY(chapter_id) REFERENCES chapter_table(chapter_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_user_words (
        user_word_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        word_id INTEGER NOT NULL,
        word_gauge REAL,
        FOREIGN KEY(user_id) REFERENCES user_table(user_id)
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_session (
        session_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        chapter_id INTEGER NOT NULL,
        session_start_time TEXT,
        session_end_time TEXT,
        session_state INTEGER,
        session_amount INTEGER,
        FOREIGN KEY(user_id) REFERENCES user_table(user_id),
        FOREIGN KEY(chapter_id) REFERENCES chapter_table(chapter_id)
      )
    ''');
  }
}
