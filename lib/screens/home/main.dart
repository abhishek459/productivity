import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/custom_scaffold.dart';
import './todays_task_list.dart';
import 'task-input/task_input_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBarTitle: DateFormat('EEE, MMM d').format(DateTime.now()),
      body: const TodaysTasksList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => const TaskInputForm(),
        ),
      ),
    );
  }
}
