import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    int? id,
    required String title,
    required String details,
    required String category,
    required String date,
    required String time,
    required String remind,
    required String repeat,
    String? status,
  }) : super(
          id: id,
          title: title,
          details: details,
          category: category,
          date: date,
          time: time,
          remind: remind,
          repeat: repeat,
          status: status,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      category: json['category'],
      date: json['date'],
      time: json['time'],
      remind: json['remind'],
      repeat: json['repeat'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'id : $id, title :$title ,details: $details, category: $category, date :$date, time: $time, remind: $remind , repeat: $repeat,status: $status';
  }
}
