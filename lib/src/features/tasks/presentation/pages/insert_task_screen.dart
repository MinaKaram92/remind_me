import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_todo_app/src/core/app_cubit/app_cubit.dart';
import 'package:simple_todo_app/src/core/resources/strings_manager.dart';
import 'package:simple_todo_app/src/core/resources/values_manager.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/get_tasks_cubit/get_tasks_cubit.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/widgets/custom_material_button.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/components/components.dart';
import '../cubits/insert_task_cubit/insert_task_cubit.dart';
import '../cubits/insert_task_cubit/insert_task_states.dart';
import '../widgets/custom_dropdown_form.dart';
import 'package:simple_todo_app/src/core/injection_container.dart' as di;

class InsertTaskScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  Widget verticalContainer(context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
        child: Container(
          width: AppSize.s1,
          height: AppSize.s40,
          color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
        ));
  }

  TextStyle? styleForFormFeild(context) {
    return Theme.of(context).textTheme.headline6;
  }

  Widget formFeildIcon({required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p10),
      child: Icon(
        icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<InsertTaskCubit>(),
      child: BlocConsumer<InsertTaskCubit, InsertTaskStates>(
        listener: (context, state) {
          if (state is InsertTaskSuccessState) {
            GetTasksCubit.get(context).getAllTasks();
            Navigator.of(context).pop();
            customSnackBar(
              context,
              message: 'Task inserted successfully',
              color: Colors.green,
            );
          }
          if (state is InsertTaskErrorState) {
            customSnackBar(
              context,
              message: state.error,
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          InsertTaskCubit insertTaskCubit = InsertTaskCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              leading: goBack(context),
              title: Text(
                'Add Task',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        width: double.infinity,
                        height: AppSize.s70,
                        child: Row(
                          children: [
                            formFeildIcon(icon: Icons.title),
                            verticalContainer(context),
                            Expanded(
                              child: CustomTextFormField(
                                controller: insertTaskCubit.titleController,
                                hint: StringsManager.titleHint,
                                type: TextInputType.text,
                                border: InputBorder.none,
                                hintStyle: styleForFormFeild(context),
                                labelStyle: styleForFormFeild(context),
                                maxLength: AppValues.v20,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return StringsManager.validateTitle;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          width: double.infinity,
                          height: 92.0,
                          child: Row(
                            children: [
                              formFeildIcon(icon: Icons.details),
                              verticalContainer(context),
                              Expanded(
                                child: CustomTextFormField(
                                  controller: insertTaskCubit.detailsController,
                                  hint: StringsManager.detailsHint,
                                  maxLength: AppValues.v60,
                                  type: TextInputType.text,
                                  border: InputBorder.none,
                                  hintStyle: styleForFormFeild(context),
                                  labelStyle: styleForFormFeild(context),
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return StringsManager.validateDetails;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        width: double.infinity,
                        height: AppSize.s70,
                        child: Row(
                          children: [
                            formFeildIcon(icon: Icons.alarm),
                            verticalContainer(context),
                            Expanded(
                              child: CustomDropdownButtonFormField(
                                validate: (value) {
                                  if (value == null) {
                                    return StringsManager.validateCategory;
                                  }
                                },
                                style: styleForFormFeild(context),
                                dropDownColor: AppCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.white,
                                hint: StringsManager.categoryHint,
                                items: insertTaskCubit.categories
                                    .map<DropdownMenuItem<String>>(
                                        (e) => DropdownMenuItem(
                                              child: Text(
                                                e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                      color: e == 'Task'
                                                          ? Colors.blue
                                                          : Colors.pink,
                                                    ),
                                              ),
                                              value: e,
                                            ))
                                    .toList(),
                                changed: (newValue) {
                                  insertTaskCubit
                                      .changeCategoryValue(newValue!);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          width: double.infinity,
                          height: AppSize.s70,
                          child: Row(
                            children: [
                              formFeildIcon(icon: Icons.date_range),
                              verticalContainer(context),
                              Expanded(
                                child: CustomTextFormField(
                                  labelStyle: styleForFormFeild(context),
                                  controller: insertTaskCubit.dateController,
                                  hint: StringsManager.dateHint,
                                  readOnly: true,
                                  type: TextInputType.text,
                                  border: InputBorder.none,
                                  showCursor: false,
                                  hintStyle: styleForFormFeild(context),
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return StringsManager.validateDate;
                                    }
                                  },
                                  tap: () {
                                    showDatePicker(
                                      context: context,
                                      builder: (context, child) {
                                        return Theme(
                                            data: AppCubit.get(context).isDark
                                                ? ThemeData.dark()
                                                : ThemeData.light(),
                                            child: child!);
                                      },
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse(
                                          StringsManager.lastDate),
                                    ).then((value) {
                                      if (value != null) {
                                        final DateFormat formatter =
                                            DateFormat('yyyy-MM-dd');
                                        insertTaskCubit.dateController.text =
                                            formatter.format(value);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        width: double.infinity,
                        height: AppSize.s70,
                        child: Row(
                          children: [
                            formFeildIcon(icon: Icons.access_time_rounded),
                            verticalContainer(context),
                            Expanded(
                              child: CustomTextFormField(
                                labelStyle: styleForFormFeild(context),
                                controller: insertTaskCubit.timeController,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return StringsManager.validateTime;
                                  }
                                },
                                hint: StringsManager.timeHint,
                                type: TextInputType.text,
                                border: InputBorder.none,
                                showCursor: false,
                                hintStyle: styleForFormFeild(context),
                                readOnly: true,
                                tap: () {
                                  showTimePicker(
                                    context: context,
                                    builder: (context, child) {
                                      return Theme(
                                          data: AppCubit.get(context).isDark
                                              ? ThemeData.dark()
                                              : ThemeData.light(),
                                          child: child!);
                                    },
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      insertTaskCubit.timeController.text =
                                          value.format(context);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          width: double.infinity,
                          height: AppSize.s70,
                          child: Row(
                            children: [
                              formFeildIcon(icon: Icons.timer),
                              verticalContainer(context),
                              Expanded(
                                child: CustomDropdownButtonFormField(
                                  validate: (value) {
                                    if (value == null) {
                                      return StringsManager.validateRemind;
                                    }
                                  },
                                  style: styleForFormFeild(context),
                                  dropDownColor: AppCubit.get(context).isDark
                                      ? Colors.black
                                      : Colors.white,
                                  hint: StringsManager.remindHint,
                                  items: insertTaskCubit.remindList
                                      .map<DropdownMenuItem<String>>(
                                          (e) => DropdownMenuItem(
                                                child: Text(
                                                  e,
                                                ),
                                                value: e,
                                              ))
                                      .toList(),
                                  changed: (newValue) {
                                    insertTaskCubit
                                        .changeRemindValue(newValue!);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        width: double.infinity,
                        height: AppSize.s70,
                        child: Row(
                          children: [
                            formFeildIcon(icon: Icons.alarm),
                            verticalContainer(context),
                            Expanded(
                              child: CustomDropdownButtonFormField(
                                validate: (value) {
                                  if (value == null) {
                                    return StringsManager.validateRepeat;
                                  }
                                },
                                style: styleForFormFeild(context),
                                dropDownColor: AppCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.white,
                                hint: StringsManager.repeatHint,
                                items: insertTaskCubit.repeatList
                                    .map<DropdownMenuItem<String>>(
                                        (e) => DropdownMenuItem(
                                              child: Text(
                                                e,
                                              ),
                                              value: e,
                                            ))
                                    .toList(),
                                changed: (newValue) {
                                  insertTaskCubit.changeRepeatValue(newValue!);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      CustomMaterialButton(
                        text: StringsManager.addTask,
                        color: Colors.teal,
                        height: AppSize.s50,
                        textSize: AppSize.s25,
                        minWidth: double.infinity,
                        pressed: () {
                          if (formKey.currentState!.validate()) {
                            TaskEntity task = TaskEntity(
                              title: insertTaskCubit.titleController.text,
                              details: insertTaskCubit.detailsController.text,
                              category: insertTaskCubit.category,
                              date: insertTaskCubit.dateController.text,
                              time: insertTaskCubit.timeController.text,
                              remind: insertTaskCubit.remindValue,
                              repeat: insertTaskCubit.repeatValue,
                            );
                            insertTaskCubit.insertTaskIntoDatabase(
                                context, task);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
