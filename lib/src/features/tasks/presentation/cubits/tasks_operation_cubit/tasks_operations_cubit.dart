import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/core/helpers/local/local_notifications_helper/notification_service.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/tasks_operation_cubit/tasks_operations_states.dart';
import '../../../../../core/components/components.dart';
import '../../../domain/usecases/delete_task_usecase.dart';
import '../../../domain/usecases/update_task_usecase.dart';

class TasksOperationsCubit extends Cubit<TasksOperationsStates> {
  DeleteTaskUsecase deleteTaskUsecase;
  UpdateTaskUsecase updateTaskUsecase;

  TasksOperationsCubit({
    required this.deleteTaskUsecase,
    required this.updateTaskUsecase,
  }) : super(InitialTasksOperationsState());

  static TasksOperationsCubit get(context) => BlocProvider.of(context);

  void updateTaskStatus(int taskId) {
    emit(LoadingUpdateTaskItemState());
    updateTaskUsecase.todoRepository.updateTaskStatus(taskId).then((value) {
      value.fold((failure) {
        emit(UpdateTaskItemErrorState(error: errorMessage(failure)));
      }, (unit) {
        emit(UpdateTaskItemSuccessState());
        NotificationService().cancelNotification(taskId);
      });
    });
  }

  void deleteTask(int taskId) {
    emit(LoadingDeleteTaskItemState());
    deleteTaskUsecase.todoRepository.deleteTaskItem(taskId).then((value) {
      value.fold((failure) {
        emit(DeleteTaskItemErrorState(error: errorMessage(failure)));
      }, (unit) {
        emit(DeleteTaskItemSuccessState());
      });
    });
  }
}
