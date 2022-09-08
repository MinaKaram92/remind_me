import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/todo_repository.dart';
import '../entities/task.dart';

class InsertTaskUsecase {
  TodoRepository todoRepository;
  InsertTaskUsecase({required this.todoRepository});
  Future<Either<Failure, int>> call(TaskEntity task) async {
    return await todoRepository.insertTaskIntoDatabase(task);
  }
}
