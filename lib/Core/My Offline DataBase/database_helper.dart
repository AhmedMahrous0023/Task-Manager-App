import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_app/Models/task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper._internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE tasks(
          id INTEGER PRIMARY KEY,
          todo TEXT,
          completed INTEGER,
          userId INTEGER
        )
      ''');
  }

  Future<int> insertTask(TaskModel task) async {
    final dbClient = await db;
    return await dbClient!.insert('tasks', task.toMap());
  }

  Future<List<TaskModel>> getTasks() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient!.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel(
        id: maps[i]['id'],
        taskName: maps[i]['todo'],
        isCompleted: maps[i]['completed'] == 1,
        userId: maps[i]['userId'],
      );
    });
  }

  Future<int> deleteTask(int id) async {
    final dbClient = await db;
    return await dbClient!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
