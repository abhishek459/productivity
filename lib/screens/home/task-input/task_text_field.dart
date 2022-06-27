import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function()? onEditingComplete;
  const TaskInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: "",
        filled: true,
      ),
      style: Theme.of(context).textTheme.displayMedium,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 !,.]'))
      ],
      textInputAction: TextInputAction.done,
      onEditingComplete: onEditingComplete,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      maxLength: 100,
    );
  }
}
