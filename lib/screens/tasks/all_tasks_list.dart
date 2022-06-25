import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../providers/task_provider.dart';
import '../../utils/date_methods.dart';

class AllTasksList extends StatefulWidget {
  const AllTasksList({Key? key}) : super(key: key);

  @override
  State<AllTasksList> createState() => _AllTasksListState();
}

class _AllTasksListState extends State<AllTasksList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: FutureBuilder(
        future: Provider.of<TaskProvider>(context, listen: false)
            .fetchAndSetTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<TaskModel> listOfTasks =
                Provider.of<TaskProvider>(context).getAllTasks;
            return ListView.builder(
              itemCount: listOfTasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(listOfTasks[index].taskTitle),
                subtitle: Text(
                  DateMethods.dateFormatter(listOfTasks[index].timeStamp),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
