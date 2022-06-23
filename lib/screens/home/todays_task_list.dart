import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            return ListView.builder(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: listOfTasks.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                key: ValueKey(listOfTasks[index].timeStamp.toIso8601String()),
                value: listOfTasks[index],
                child: const TaskItem(),
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
    return Card(
      child: ListTile(
        title: Consumer<TaskModel>(
          builder: (context, value, _) => TaskTitle(taskItem: taskItem),
        ),
        subtitle: Text(
          DateMethods.dateFormatter(taskItem.timeStamp),
        ),
        trailing: Consumer<TaskModel>(
            builder: (context, value, child) =>
                TrailingIcon(taskItem: taskItem)),
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
      return Text(
        taskItem.taskTitle,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.notoSans(
          fontSize: 20,
        ),
      );
    } else {
      return Text(
        taskItem.taskTitle,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.notoSans(
          fontSize: 20,
          decoration: TextDecoration.lineThrough,
          fontWeight: FontWeight.w300,
        ),
      );
    }
  }
}

class TrailingIcon extends StatelessWidget {
  final TaskModel taskItem;
  const TrailingIcon({Key? key, required this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Image taskCompleteIcon = Image.asset('lib/assets/icons/check.png');
    if (taskItem.isCompleted) {
      return SizedBox(
        height: 40,
        child: taskCompleteIcon,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => TaskMethods.markTaskAsComplete(context, taskItem),
                child: const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 35,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Card(
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => TaskMethods.deleteTask(
                    context, taskItem.timeStamp.toIso8601String()),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 35,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
