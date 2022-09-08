import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/widgets/build_tasks.dart';
import '../cubits/get_tasks_cubit/get_tasks_cubit.dart';
import '../cubits/tasks_operation_cubit/tasks_operations_cubit.dart';
import '../cubits/tasks_operation_cubit/tasks_operations_states.dart';

class CompleteTasks extends StatelessWidget {
  const CompleteTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksOperationsCubit, TasksOperationsStates>(
      builder: (operationsContext, operationsState) {
        return TabBarView(
          children: [
            BuildTasks(tasks: GetTasksCubit.get(context).completeTasks),
            BuildTasks(
                tasks: GetTasksCubit.get(context)
                    .getTodoTasks(GetTasksCubit.get(context).completeTasks)),
            BuildTasks(
                tasks: GetTasksCubit.get(context)
                    .getBirthdays(GetTasksCubit.get(context).completeTasks)),
          ],
        );
      },
    );
  }
}
