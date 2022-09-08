import 'package:dartz/dartz.dart';

import '../../../models/task_model.dart';

abstract class DatabaseRepository {
  Future<List<TaskModel>> getAllTasks();
  Future<Unit> updateDatabaseStatus(int taskId);
  Future<int> insertTask(TaskModel taskModel);
  Future<Unit> deleteTask(int taskId);
}
