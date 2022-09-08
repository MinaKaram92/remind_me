import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:simple_todo_app/src/features/tasks/domain/entities/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // create a singleton object

  NotificationService._internal();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  // create object of the notification plugin

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // create init method

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    tz.initializeTimeZones();
    _configureLocalTimeZone();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void selectNotification(String? payload) async {
    //Handle notification tapped logic here
  }

  final NotificationDetails _notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  tz.TZDateTime _setTaskDate({required String date, required String time}) {
    DateTime formattedDate = DateTime.parse(date);
    final formatTime = DateFormat.jm();
    TimeOfDay formattedTime = TimeOfDay.fromDateTime(formatTime.parse(time));

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      formattedDate.year,
      formattedDate.month,
      formattedDate.day,
      formattedTime.hour,
      formattedTime.minute,
    );
    return scheduledDate;
  }

  tz.TZDateTime _setRemindTime(
      {required String date, required String time, required String remind}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    DateTime? formattedDate = DateTime.tryParse(date);
    final formatTime = DateFormat.jm();
    TimeOfDay formattedTime = TimeOfDay.fromDateTime(formatTime.parse(time));
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      formattedDate!.year,
      formattedDate.month,
      formattedDate.day,
      formattedTime.hour,
      formattedTime.minute,
    );
    switch (remind) {
      case '5 mins before':
        scheduledDate = scheduledDate.subtract(Duration(minutes: 5));
        break;
      case '10 mins before':
        scheduledDate = scheduledDate.subtract(Duration(minutes: 10));
        break;
      case '30 mins before':
        scheduledDate = scheduledDate.subtract(Duration(minutes: 30));
        break;
      case '1 hour before':
        scheduledDate = scheduledDate.subtract(Duration(hours: 1));
        break;
      case '2 hours before':
        scheduledDate = scheduledDate.subtract(Duration(hours: 2));
        break;
      default:
        'not specified';
    }
    return scheduledDate;
  }

  Future<void> _scheduleNotification({
    required int taskId,
    required TaskEntity task,
    required tz.TZDateTime scheduledDate,
    DateTimeComponents? dateTimeComponents,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        taskId, task.title, task.details, scheduledDate, _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: dateTimeComponents);
  }

  void scheduleRepeatNotification({required TaskEntity task, required int id}) {
    switch (task.repeat) {
      case 'Daily':
        _scheduleNotification(
            taskId: id,
            task: task,
            scheduledDate: _setTaskDate(date: task.date, time: task.time),
            dateTimeComponents: DateTimeComponents.time);
        break;
      case 'Weekly':
        _scheduleNotification(
            taskId: id,
            task: task,
            scheduledDate: _setTaskDate(date: task.date, time: task.time),
            dateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
        break;
      case 'Monthly':
        _scheduleNotification(
            taskId: id,
            task: task,
            scheduledDate: _setTaskDate(date: task.date, time: task.time),
            dateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
        break;
      default:
        'Not specified';
    }
  }

  void scheduleRemindNotification({required TaskEntity task, required int id}) {
    _scheduleNotification(
        taskId: id,
        task: task,
        scheduledDate: _setRemindTime(
            date: task.date, time: task.time, remind: task.remind));
  }

  void scheduleOnTimeNotification({required TaskEntity task, required int id}) {
    _scheduleNotification(
        taskId: id,
        task: task,
        scheduledDate: _setTaskDate(date: task.date, time: task.time));
  }

  Future<void> cancelNotification(int notiId) async {
    return await flutterLocalNotificationsPlugin.cancel(notiId);
  }
}
