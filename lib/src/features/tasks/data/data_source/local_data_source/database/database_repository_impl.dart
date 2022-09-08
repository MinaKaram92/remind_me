import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/src/features/tasks/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'database_repository.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {
  static const _databaseName = 'todoDatabase.db';
  static const _tableName = 'tasks';
  static const _databaseVersion = 1;

  static const _columnId = 'id';
  static const _columnTitle = 'title';
  static const _columnDetails = 'details';
  static const _columnCategory = 'category';
  static const _columnDate = 'date';
  static const _columnTime = 'time';
  static const _columnRemind = 'remind';
  static const _columnRepeat = 'repeat';
  static const _columnStatus = 'status';

  static Database? _database;

  Future<Database> _initDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $_tableName ($_columnId INTEGER PRIMARY KEY, $_columnTitle TEXT,$_columnDetails TEXT, $_columnCategory TEXT, $_columnDate TEXT, $_columnTime TEXT, $_columnRemind TEXT, $_columnRepeat TEXT, $_columnStatus TEXT)',
        );
      },
    );
    return _database!;
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    Database db = await _initDatabase();
    late List<TaskModel> tasks;
    await db.rawQuery('SELECT * FROM Tasks').then((value) {
      tasks = value.map((e) => TaskModel.fromJson(e)).toList();
    });
    return tasks;
  }

  @override
  Future<int> insertTask(TaskModel taskModel) async {
    Database db = await _initDatabase();
    return await db.rawInsert(
        'INSERT INTO $_tableName($_columnTitle, $_columnDetails, $_columnCategory, $_columnDate, $_columnTime, $_columnRemind, $_columnRepeat, $_columnStatus) VALUES("${taskModel.title}","${taskModel.details}","${taskModel.category}","${taskModel.date}","${taskModel.time}","${taskModel.remind}","${taskModel.repeat}", "incomplete")');
  }

  @override
  Future<Unit> updateDatabaseStatus(int taskId) async {
    Database db = await _initDatabase();
    await db.rawUpdate(
        'UPDATE $_tableName SET $_columnStatus = ? WHERE $_columnId = ?',
        ['complete', '$taskId']);
    return unit;
  }

  @override
  Future<Unit> deleteTask(int taskId) async {
    Database db = await _initDatabase();
    await db
        .rawDelete('DELETE FROM $_tableName WHERE $_columnId = ?', ['$taskId']);
    return unit;
  }
}
