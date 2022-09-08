import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import '../../../../core/error/failures.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasksFromDatabase();

  Future<Either<Failure, int>> insertTaskIntoDatabase(TaskEntity task);

  Future<Either<Failure, Unit>> updateTaskStatus(int taskId);

  Future<Either<Failure, Unit>> deleteTaskItem(int taskId);
}
