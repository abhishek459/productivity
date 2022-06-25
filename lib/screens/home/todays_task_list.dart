import 'package:flutter/material.dart';
import 'package:productivity/screens/home/task_layout.dart';
import 'package:productivity/widgets/notosans_text.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../../utils/date_methods.dart';
import './services/task_input_methods.dart';

class TodaysTasksList extends StatefulWidget {
  const TodaysTasksList({Key? key}) : super(key: key);

  @override
  State<TodaysTasksList> createState() => _TodaysTasksListState();
}

class _TodaysTasksListState extends State<TodaysTasksList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TaskProvider>(context, listen: false)
          .fetchAndSetTodaysTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<TaskModel> listOfTasks =
              Provider.of<TaskProvider>(context).getTasks;

          if (listOfTasks.isEmpty) {
            return Center(
              child: Text(
                'No tasks added today',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: listOfTasks.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  key: ValueKey(listOfTasks[index].timeStamp.toIso8601String()),
                  value: listOfTasks[index],
                  child: const TaskItem(),
                ),
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskItem = Provider.of<TaskModel>(context, listen: false);
    return TaskLayout(
      leadingIcon: Consumer<TaskModel>(
        builder: (context, value, child) => LeadingIcon(taskItem: taskItem),
        child: LeadingIcon(taskItem: taskItem),
      ),
      taskStatus: taskItem.isCompleted,
      taskTitle: Consumer<TaskModel>(
        builder: (context, value, _) => TaskTitle(taskItem: taskItem),
      ),
      taskSubtitle: Text(
        DateMethods.dateFormatter(taskItem.timeStamp),
      ),
    );
  }
}

class TaskTitle extends StatelessWidget {
  final TaskModel taskItem;
  const TaskTitle({Key? key, required this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!taskItem.isCompleted) {
      return NotoSansText(
        text: taskItem.taskTitle,
        overflow: true,
        fontSize: 20,
      );
    } else {
      return NotoSansText(
        text: taskItem.taskTitle,
        overflow: true,
        fontSize: 20,
        lineThrough: true,
        lightFont: true,
      );
    }
  }
}

class LeadingIcon extends StatelessWidget {
  final TaskModel taskItem;
  const LeadingIcon({Key? key, required this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image taskCompleteIcon = Image.asset('lib/assets/icons/check.png');
    if (taskItem.isCompleted) {
      return SizedBox(
        height: 35,
        child: taskCompleteIcon,
      );
    } else {
      return InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => TaskMethods.markTaskAsComplete(context, taskItem),
        child: const Icon(
          Icons.circle_outlined,
          color: Colors.green,
          size: 35,
        ),
      );
    }
  }
}
