import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:productivity/widgets/notosans_text.dart';

import './deadline_setter.dart';
import '../services/task_input_methods.dart';
import './task_text_field.dart';

class TaskInputForm extends StatefulWidget {
  const TaskInputForm({Key? key}) : super(key: key);

  @override
  State<TaskInputForm> createState() => _TaskInputFormState();
}

class _TaskInputFormState extends State<TaskInputForm>
    with SingleTickerProviderStateMixin {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool showingDeadlineSetter = false;

  void toggleDeadlineSetter() {
    // setState(() {
    //   showingDeadlineSetter = !showingDeadlineSetter;
    // });
    if (showingDeadlineSetter) {
      setState(() {
        showingDeadlineSetter = false;
      });
      _dateController.clear();
      _timeController.clear();
      _animationController.reverse();
    } else {
      setState(() {
        showingDeadlineSetter = true;
      });
      _animationController.forward();
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: AnimatedSize(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TaskInputField(
              hintText: 'New task',
              controller: _taskController,
              onEditingComplete: addTask,
            ),
            SizedBox(height: showingDeadlineSetter ? 20 : 10),
            if (showingDeadlineSetter)
              SlideTransition(
                position: _slideAnimation,
                child: DeadlineSetter(
                  dateController: _dateController,
                  timeController: _timeController,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.calendar_today,
                      color: (showingDeadlineSetter) ? Colors.blue : null),
                  onPressed: toggleDeadlineSetter,
                ),
                TextButton(
                  onPressed: addTask,
                  child: const NotoSansText(text: 'Save', fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    TaskMethods.addTask(
      context: context,
      title: _taskController.text,
      deadline: (getDeadline() == null) ? null : DateTime.parse(getDeadline()!),
    );
    finishingUp();
  }

  void finishingUp() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  String? getDeadline() {
    if (_dateController.text.isNotEmpty && _timeController.text.isEmpty) {
      selectedDate = DateFormat('dd/MM/yyyy').parse(_dateController.text);
      return selectedDate!.toIso8601String();
    } else if (_dateController.text.isNotEmpty &&
        _timeController.text.isNotEmpty) {
      var tempDate = DateFormat('dd/MM/yyyy').parse(_dateController.text);
      var time = DateFormat('hh:mm a').parse(_timeController.text);

      selectedDate = DateTime(
        tempDate.year,
        tempDate.month,
        tempDate.day,
        time.hour,
        time.minute,
      );
      return selectedDate!.toIso8601String();
    } else {
      return null;
    }
  }
}
