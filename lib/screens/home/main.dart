import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity/providers/task_provider.dart';
import 'package:productivity/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../../widgets/glassmorphic_cover.dart';
import '../../widgets/notosans_text.dart';
import './todays_task_list.dart';
import 'task-input/task_input_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: const MyAppBar(),
      ),
      drawer: const MainDrawer(),
      body: const TodaysTasksList(),
      floatingActionButton: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => const TaskInputForm(),
        ),
        child: CircularGlassMorphicEffect(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Theme.of(context).hintColor.withOpacity(0.7),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child:
                  Icon(Icons.add, size: 40, color: Theme.of(context).hintColor),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    return GlassMorphicEffect(
      child: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NotoSansText(
                  text: 'Today\'s tasks',
                  fontSize: 20,
                  color: Color.fromRGBO(80, 130, 252, 1),
                ),
                Consumer(builder: (context, value, _) {
                  return NotoSansText(
                    text:
                        '${taskProvider.completedTasks}/${taskProvider.getTasks.length} done',
                    fontSize: 20,
                    color: Theme.of(context).hintColor,
                  );
                }),
              ],
            ),
          ),
        ),
        foregroundColor: Theme.of(context).hintColor,
        backgroundColor: Colors.transparent,
        title: NotoSansText(
          text: DateFormat('EEEE, MMM d').format(DateTime.now()),
        ),
        centerTitle: true,
      ),
    );
  }
}

class CircularGlassMorphicEffect extends StatelessWidget {
  final Widget child;
  const CircularGlassMorphicEffect({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: child,
      ),
    );
  }
}
