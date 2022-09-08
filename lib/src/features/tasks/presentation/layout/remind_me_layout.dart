import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/config/routes/route_manager.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_cubit.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_states.dart';
import 'package:simple_todo_app/src/core/components/components.dart';
import 'package:simple_todo_app/src/core/resources/values_manager.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/get_tasks_cubit/get_tasks_cubit.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/get_tasks_cubit/get_tasks_states.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/insert_task_cubit/insert_task_cubit.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/insert_task_cubit/insert_task_states.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/tasks_operation_cubit/tasks_operations_cubit.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/tasks_operation_cubit/tasks_operations_states.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/widgets/loading_widget.dart';

class TodoLayout extends StatelessWidget {
  const TodoLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: _buildAppbar(context),
            body: BlocListener<TasksOperationsCubit, TasksOperationsStates>(
              listener: (operationsContext, operationsState) {
                if (operationsState is UpdateTaskItemSuccessState ||
                    operationsState is DeleteTaskItemSuccessState) {
                  GetTasksCubit.get(context).getAllTasks();
                }
                if (operationsState is UpdateTaskItemSuccessState) {
                  customSnackBar(context,
                      message: 'Task updated successfully',
                      color: Colors.green);
                } else if (operationsState is UpdateTaskItemErrorState) {
                  customSnackBar(context,
                      message: operationsState.error, color: Colors.red);
                }
                if (operationsState is DeleteTaskItemSuccessState) {
                  customSnackBar(context,
                      message: 'Task deleted successfully',
                      color: Colors.green);
                } else if (operationsState is DeleteTaskItemErrorState) {
                  customSnackBar(context,
                      message: operationsState.error, color: Colors.red);
                }
              },
              child: BlocBuilder<GetTasksCubit, GetTasksStates>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ConditionalBuilder(
                      condition: state is! LoadingGetAllTasksState,
                      builder: (context) {
                        return appCubit.screens[appCubit.currentIndex];
                      },
                      fallback: (context) => const LoadingWidget(),
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              items: appCubit.navItems,
              currentIndex: appCubit.currentIndex,
              onTap: (index) {
                appCubit.changeNavBarIndex(index);
              },
            ),
          ),
        );
      },
    );
  }

  final List<Widget> tabs = const [
    Text(
      'All',
    ),
    Text(
      'Tasks',
    ),
    Text(
      'Birthdays',
    )
  ];

  AppBar _buildAppbar(context) {
    return AppBar(
      elevation: 0,
      title: const Text(
        'Remind Me',
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(AppSize.s40),
        child: TabBar(
          tabs: tabs,
          labelPadding: const EdgeInsets.symmetric(vertical: AppSize.s10),
          isScrollable: false,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.insertTaskRoute);
          },
          child: const Text(
            'Add Task',
          ),
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(context).changeTheme();
          },
          icon: const Icon(
            Icons.dark_mode,
          ),
        ),
      ],
    );
  }
}
