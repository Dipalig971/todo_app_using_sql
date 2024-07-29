import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_using_sql/todo_app/modal/todo_modal.dart';

class TodoDBHelper {
  static TodoDBHelper databaseHelper = TodoDBHelper();

  Database? _database;


  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    String dataBasePath = join(path, 'todo.db');

    Database database = await openDatabase(
      dataBasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE (id INTEGER PRIMARY KEY AUTOINCREMENT, taskName TEXT NOT NULL, isDone INTEGER NOT NULL, note TEXT, priority INTEGER NOT NULL)',
        );
      },
    );
    return database;
  }

  // Future<Database> get database async {
  //   return _database ??= await initDatabase();
  // }

  Future<void> insertData(Map<String,dynamic> task) async {
    final db = await database;
    await db!.insert('TodoModal',task);
  }

  Future<List<Map<String, Object?>>> getData() async {
    final db = await database;
    return await db!.query('TodoModal');
  }

  Future<void> updateData(int id,Map<String,dynamic> task) async {
    final db = await database;
    await db!.update('TodoModal',task ,where: 'id = ?' , whereArgs: [id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db!.delete('TodoModal',where: 'id = ? ',whereArgs: [id]);
  }
}
