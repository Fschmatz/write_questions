import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class QuestionDao {

  static final _databaseName = 'Questions.db';
  static final _databaseVersion = 1;

  static final table = 'question';
  static final columnId = 'id';
  static final columnText = 'text';
  static final columnState = 'state';

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  QuestionDao._privateConstructor();
  static final QuestionDao instance = QuestionDao._privateConstructor();


  // Open db and create if it not exists
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL create DB
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
           $columnId INTEGER PRIMARY KEY,            
           $columnText TEXT NOT NULL,    
           $columnState INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY id DESC');
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getItemsState(int state) async {
    Database db = await instance.database;
    return await db.rawQuery('''    
        SELECT * FROM $table 
        WHERE $columnState=$state   
        ORDER BY id DESC
        ''');
  }

}