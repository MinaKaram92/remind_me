import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/todo_repository.dart';

class DeleteTaskUsecase {
  TodoRepository todoRepository;
  DeleteTaskUsecase({required this.todoRepository});
  Future<Either<Failure, Unit>> call(int taskId) async {
    return await todoRepository.deleteTaskItem(taskId);
  }
}
