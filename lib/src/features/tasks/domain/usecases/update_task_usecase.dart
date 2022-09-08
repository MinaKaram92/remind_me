import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/todo_repository.dart';

class UpdateTaskUsecase {
  TodoRepository todoRepository;
  UpdateTaskUsecase({required this.todoRepository});
  Future<Either<Failure, Unit>> call(int taskId) async {
    return await todoRepository.updateTaskStatus(taskId);
  }
}
