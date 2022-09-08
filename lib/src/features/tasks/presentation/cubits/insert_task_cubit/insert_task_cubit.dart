import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/src/core/components/components.dart';
import 'package:simple_todo_app/src/core/error/failures.dart';
import 'package:simple_todo_app/src/features/tasks/presentation/cubits/insert_task_cubit/insert_task_states.dart';
import '../../../../../core/helpers/local/local_notifications_helper/notification_service.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/usecases/insert_task_usecase.dart';

class InsertTaskCubit extends Cubit<InsertTaskStates> {
  InsertTaskUsecase insertTaskUsecase;
  InsertTaskCubit({required this.insertTaskUsecase})
      : super(InitialInsertTaskState());

  static InsertTaskCubit get(context) => BlocProvider.of(context);

  var titleController = TextEditingController();

  var detailsController = TextEditingController();

  var dateController = TextEditingController();

  var timeController = TextEditingController();

  late String remindValue;
  List<dynamic> remindList = [
    '5 mins before',
    '10 mins before',
    '30 mins before',
    '1 hour before',
    '2 hours before',
  ];
  late String repeatValue;
  List<dynamic> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  late String category;
  List<dynamic> categories = ['Task', 'Birthday'];

  void changeCategoryValue(String newValue) {
    category = newValue;
    ChangeCategoryValueState();
  }

  void changeRemindValue(String newValue) {
    remindValue = newValue;
    ChangeRemindValueState();
  }

  void changeRepeatValue(String newValue) {
    repeatValue = newValue;
    ChangeRepeatValueState();
  }

  void insertTaskIntoDatabase(context, TaskEntity task) {
    emit(LoadingInsertTaskState());
    insertTaskUsecase.todoRepository.insertTaskIntoDatabase(task).then((value) {
      value.fold((failure) {
        emit(InsertTaskErrorState(error: errorMessage(failure)));
      }, (id) {
        emit(InsertTaskSuccessState());
        NotificationService().scheduleOnTimeNotification(task: task, id: id);
        NotificationService().scheduleRemindNotification(task: task, id: id);
        NotificationService().scheduleRepeatNotification(task: task, id: id);
      });
    });
  }
}
