import 'package:flutter/cupertino.dart';

import '../models/task_model.dart';
import '../utils/db_helper.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];
  List<TaskModel> _allTasks = [];

  List<TaskModel> get getTasks => _tasks;
  List<TaskModel> get getAllTasks => _allTasks;

  Future<void> fetchAndSetTodaysTasks() async {
    final List<Map<String, Object?>> dataList =
        await DBHelper.fetchTodaysTasks();
    _tasks = dataList
        .map((element) => TaskModel.fromMap(element))
        .toList()
        .reversed
        .toList();
    notifyListeners();
  }

  Future<void> fetchAndSetTasks() async {
    final List<Map<String, Object?>> dataList = await DBHelper.fetchTasks();
    _allTasks = dataList
        .map((element) => TaskModel.fromMap(element))
        .toList()
        .reversed
        .toList();
    notifyListeners();
  }

  void addTask(TaskModel task) {
    _tasks.insert(0, task);
    notifyListeners();
    final Map<String, Object> sqlData = {
      'id': task.timeStamp.toIso8601String(),
      'title': task.taskTitle,
      'deadline': task.deadline?.toIso8601String() ?? '',
      'completed': (task.isCompleted) ? 1 : 0,
      'completedOn': '',
    };
    DBHelper.insertTask(sqlData);
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere(
        (element) => element.timeStamp.toIso8601String() == taskId);
    notifyListeners();
    DBHelper.deleteTask(taskId);
  }
}
