import 'package:flutter/cupertino.dart';

import '../utils/db_helper.dart';

class TaskModel with ChangeNotifier {
  final String taskTitle;
  final DateTime timeStamp;
  final DateTime? deadline;
  DateTime? completedOn;
  bool isCompleted;

  TaskModel({
    required this.taskTitle,
    required this.timeStamp,
    this.deadline,
    this.completedOn,
    this.isCompleted = false,
  });

  factory TaskModel.fromMap(Map<String, Object?> mapValue) => TaskModel(
        taskTitle: mapValue['title'] as String,
        timeStamp: DateTime.parse(mapValue['id'] as String),
        isCompleted: (mapValue['completed'] == 1) ? true : false,
        deadline: mapValue['deadline'] == ''
            ? null
            : DateTime.parse(mapValue['deadline'] as String),
        completedOn: mapValue['completedOn'] == ''
            ? null
            : DateTime.parse(mapValue['completedOn'] as String),
      );

  void markTaskAsComplete() {
    isCompleted = true;
    completedOn = DateTime.now();
    notifyListeners();
    DBHelper.markTaskAsComplete(
      timeStamp.toIso8601String(),
      completedOn!.toIso8601String(),
    );
  }
}
