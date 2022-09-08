import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_cubit.dart';
import 'package:simple_todo_app/src/core/resources/strings_manager.dart';
import 'package:simple_todo_app/src/core/resources/values_manager.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/tasks_operation_cubit/tasks_operations_cubit.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);
  final TaskEntity task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: AppValues.ratio,
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                          title: const Text(StringsManager.alertTitle),
                          content: const Text(StringsManager.alertContent),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(StringsManager.cancelBtn)),
                            TextButton(
                              onPressed: () {
                                TasksOperationsCubit.get(context)
                                    .deleteTask(task.id!);
                                Navigator.of(context).pop();
                              },
                              child: const Text(StringsManager.acceptBtn),
                            )
                          ],
                        ));
              },
              icon: Icons.delete,
              label: StringsManager.delete,
              autoClose: true,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(AppValues.radius40),
            )
          ],
          motion: const ScrollMotion(),
        ),
        child: Card(
          color: AppCubit.get(context).isDark ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppValues.radius25),
            side: BorderSide(
                color: task.category == 'Birthday' ? Colors.pink : Colors.blue,
                width: AppSize.s1,
                style: BorderStyle.solid),
          ),
          elevation: AppValues.elevation20,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              if (task.status == 'complete')
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                  child: Icon(
                    Icons.check_circle_outline,
                  ),
                ),
              if (task.status == 'incomplete')
                IconButton(
                  icon: const Icon(
                    Icons.circle_outlined,
                  ),
                  onPressed: () {
                    TasksOperationsCubit.get(context)
                        .updateTaskStatus(task.id!);
                  },
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: task.category == 'Birthday'
                                ? Colors.pink
                                : Colors.blue,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 3 / 4,
                        child: Text(
                          task.details,
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: AppValues.v2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          task.date,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(width: AppSize.s20),
                        Text(
                          task.time,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
