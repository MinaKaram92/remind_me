import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/widgets/task_item.dart';

class BuildTasks extends StatelessWidget {
  const BuildTasks({Key? key, required this.tasks}) : super(key: key);
  final List<TaskEntity> tasks;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return TaskItem(
              task: tasks[index],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10.0,
          ),
          itemCount: tasks.length,
        );
      },
      fallback: (context) => Center(
        child:
            Text('No tasks yet', style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}
