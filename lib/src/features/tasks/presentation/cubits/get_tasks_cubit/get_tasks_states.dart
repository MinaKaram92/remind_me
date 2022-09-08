abstract class GetTasksStates {}

class InitialTodoStates extends GetTasksStates {}

class LoadingGetAllTasksState extends GetTasksStates {}

class GetAllTasksSuccessState extends GetTasksStates {}

class GetAllTasksErrorState extends GetTasksStates {
  String error;
  GetAllTasksErrorState({required this.error});
}
