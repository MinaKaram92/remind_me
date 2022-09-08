import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import '../../../../core/error/failures.dart';
import '../repository/todo_repository.dart';

class GetAllTasksUsecase {
  TodoRepository todoRepository;
  GetAllTasksUsecase({required this.todoRepository});
  Future<Either<Failure, List<TaskEntity>>> call() async {
    return await todoRepository.getAllTasksFromDatabase();
  }
}
