import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/main_drawer.dart';
import '../../widgets/my_appbar.dart';
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
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: MyAppBar(
          appBarTitle: DateFormat('EEEE, MMM d').format(
            DateTime.now(),
          ),
        ),
      ),
      drawer: const MainDrawer(),
      drawerDragStartBehavior: DragStartBehavior.down,
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
