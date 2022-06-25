import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeadlineSetter extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;

  const DeadlineSetter(
      {Key? key, required this.dateController, required this.timeController})
      : super(key: key);

  @override
  State<DeadlineSetter> createState() => _DeadlineSetterState();
}

class _DeadlineSetterState extends State<DeadlineSetter> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void pickDate() async {
    await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    ).then((value) {
      if (value != null) {
        setState(() {
          widget.dateController.text = DateFormat('dd/MM/yy').format(value);
        });
        selectedDate = value;
      }
    });
  }

  void pickTime() async {
    final int hour = DateTime.now().hour + 1;
    final int minute = DateTime.now().minute;
    await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay(hour: hour, minute: minute),
    ).then((value) {
      if (value != null) {
        setState(() {
          widget.timeController.text =
              MaterialLocalizations.of(context).formatTimeOfDay(value);
        });
        selectedTime = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TimeInputField(
          controller: widget.dateController,
          icon: Icons.calendar_month_outlined,
          hintText: 'Pick Date',
          onTap: pickDate,
        ),
        TimeInputField(
          controller: widget.timeController,
          icon: Icons.timer,
          hintText: 'Pick Time',
          onTap: pickTime,
        ),
      ],
    );
  }
}

class TimeInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final void Function()? onTap;
  const TimeInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextField(
        style: Theme.of(context).textTheme.displayMedium,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          suffixIconColor: Theme.of(context).hintColor,
          hintText: hintText,
          filled: true,
        ),
        readOnly: true,
        onTap: onTap,
      ),
    );
  }
}
