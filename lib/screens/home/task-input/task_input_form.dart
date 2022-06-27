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
  late AnimationController _controller;
  late Animation _animation;

  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool showingDeadlineSetter = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Size>(
      begin: const Size(0, 0),
      end: const Size(
        double.infinity,
        80,
      ),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  void toggleDeadlineSetter() {
    if (!showingDeadlineSetter) {
      _controller.forward();
      showingDeadlineSetter = true;
    } else {
      _controller.reverse();
      showingDeadlineSetter = false;
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Widget verticalPadding = VerticalPadding();
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TaskInputField(
            hintText: 'New task',
            controller: _taskController,
            onEditingComplete: addTask,
          ),
          verticalPadding,
          SizedBox(
            height: _animation.value.height,
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
    getDeadline();
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

class VerticalPadding extends StatelessWidget {
  const VerticalPadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
