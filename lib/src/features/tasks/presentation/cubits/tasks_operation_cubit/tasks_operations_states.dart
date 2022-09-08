abstract class TasksOperationsStates {}

class InitialTasksOperationsState extends TasksOperationsStates {}

// delete task

class LoadingDeleteTaskItemState extends TasksOperationsStates {}

class DeleteTaskItemSuccessState extends TasksOperationsStates {}

class DeleteTaskItemErrorState extends TasksOperationsStates {
  final String error;

  DeleteTaskItemErrorState({required this.error});
}

// update task

class LoadingUpdateTaskItemState extends TasksOperationsStates {}

class UpdateTaskItemSuccessState extends TasksOperationsStates {}

class UpdateTaskItemErrorState extends TasksOperationsStates {
  final String error;

  UpdateTaskItemErrorState({required this.error});
}
