import 'package:simple_todo_app/src/core/error/exceptions.dart';
import 'package:simple_todo_app/src/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/src/features/tasks/data/models/task_model.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:simple_todo_app/src/features/tasks/domain/repository/todo_repository.dart';
import '../data_source/local_data_source/database/database_repository.dart';

class TaskRepositoryImpl extends TodoRepository {
  TaskRepositoryImpl({required this.databaseRepository});
  DatabaseRepository databaseRepository;
  @override
  Future<Either<Failure, Unit>> deleteTaskItem(int taskId) async {
    try {
      await databaseRepository.deleteTask(taskId);
      return right(unit);
    } on CacheException {
      return left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasksFromDatabase() async {
    try {
      List<TaskModel> tasks = await databaseRepository.getAllTasks();
      return right(tasks);
    } on CacheException {
      return left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> insertTaskIntoDatabase(TaskEntity task) async {
    TaskModel taskModel = TaskModel(
      title: task.title,
      details: task.details,
      category: task.category,
      date: task.date,
      time: task.time,
      remind: task.remind,
      repeat: task.repeat,
    );
    try {
      final int id = await databaseRepository.insertTask(taskModel);
      return right(id);
    } on CacheException {
      return left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTaskStatus(int taskId) async {
    try {
      await databaseRepository.updateDatabaseStatus(taskId);
      return right(unit);
    } on CacheException {
      return left(CacheFailure());
    }
  }
}
