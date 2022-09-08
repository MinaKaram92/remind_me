import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/get_tasks_cubit/get_tasks_states.dart';
import '../../../../../core/components/components.dart';
import '../../../domain/usecases/get_all_tasks_usecase.dart';

class GetTasksCubit extends Cubit<GetTasksStates> {
  GetAllTasksUsecase getAllTasksUsecase;
  GetTasksCubit({
    required this.getAllTasksUsecase,
  }) : super(InitialTodoStates());

  static GetTasksCubit get(context) => BlocProvider.of(context);

  List<TaskEntity> all = [];
  List<TaskEntity> completeTasks = [];
  List<TaskEntity> incompleteTasks = [];

  void getAllTasks() {
    emit(LoadingGetAllTasksState());
    getAllTasksUsecase.todoRepository.getAllTasksFromDatabase().then((value) {
      value.fold((failure) {
        emit(GetAllTasksErrorState(error: errorMessage(failure)));
      }, (tasks) {
        all = List.from(tasks);
        getComplete_IncmpleteTasks(tasks);
        emit(GetAllTasksSuccessState());
      });
    });
  }

  void getComplete_IncmpleteTasks(List<TaskEntity> tasks) {
    completeTasks = [];
    incompleteTasks = [];
    for (var task in tasks) {
      if (task.status == 'complete') {
        completeTasks.add(task);
      } else {
        incompleteTasks.add(task);
      }
    }
  }

  List<TaskEntity> birthdays = [];
  List<TaskEntity> todoTasks = [];

  List<TaskEntity> getBirthdays(List<TaskEntity> tasks) {
    birthdays = [];
    for (var task in tasks) {
      if (task.category == 'Birthday') {
        birthdays.add(task);
      }
    }
    return birthdays;
  }

  List<TaskEntity> getTodoTasks(List<TaskEntity> tasks) {
    todoTasks = [];
    for (var task in tasks) {
      if (task.category == 'Task') {
        todoTasks.add(task);
      }
    }
    return todoTasks;
  }
}
