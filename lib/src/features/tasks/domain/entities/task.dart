class TaskEntity {
  int? id;
  String title;
  String details;
  String category;
  String date;
  String time;
  String remind;
  String repeat;
  String? status;

  TaskEntity({
    this.id,
    required this.title,
    required this.details,
    required this.category,
    required this.date,
    required this.time,
    required this.remind,
    required this.repeat,
    this.status,
  });
}
