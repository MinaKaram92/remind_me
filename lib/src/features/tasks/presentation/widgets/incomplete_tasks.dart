import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/get_tasks_cubit/get_tasks_states.dart';
import '../cubits/get_tasks_cubit/get_tasks_cubit.dart';
import '../cubits/tasks_operation_cubit/tasks_operations_cubit.dart';
import '../cubits/tasks_operation_cubit/tasks_operations_states.dart';

import 'build_tasks.dart';

class IncompleteTasks extends StatelessWidget {
  const IncompleteTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksOperationsCubit, TasksOperationsStates>(
      builder: (operationsContext, operationsState) {
        return TabBarView(
          children: [
            BuildTasks(tasks: GetTasksCubit.get(context).incompleteTasks),
            BuildTasks(
                tasks: GetTasksCubit.get(context)
                    .getTodoTasks(GetTasksCubit.get(context).incompleteTasks)),
            BuildTasks(
                tasks: GetTasksCubit.get(context)
                    .getBirthdays(GetTasksCubit.get(context).incompleteTasks)),
          ],
        );
      },
    );
  }
}
