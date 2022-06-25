import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/task_model.dart';
import '../../../../providers/task_provider.dart';
import '../../../utils/cheerful_messages.dart';

class TaskMethods {
  static void addTask({
    required BuildContext context,
    required String title,
    required DateTime? deadline,
  }) {
    if (title.isEmpty) {
      return;
    }
    TaskModel taskData = TaskModel(
        taskTitle: title, deadline: deadline, timeStamp: DateTime.now());
    Provider.of<TaskProvider>(context, listen: false).addTask(taskData);
  }

  static void markTaskAsComplete(BuildContext context, TaskModel taskItem) {
    taskItem.markTaskAsComplete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(cheerMeUp[Random().nextInt(cheerMeUp.length)]),
      ),
    );
  }

  static void deleteTask(BuildContext context, String taskId) {
    Provider.of<TaskProvider>(context, listen: false).deleteTask(taskId);
  }
}
