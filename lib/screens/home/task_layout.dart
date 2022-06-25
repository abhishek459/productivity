import 'package:flutter/material.dart';

class TaskLayout extends StatelessWidget {
  final bool taskStatus;
  final Widget taskTitle;
  final Text taskSubtitle;
  final Widget leadingIcon;
  const TaskLayout({
    Key? key,
    required this.taskStatus,
    required this.taskTitle,
    required this.taskSubtitle,
    required this.leadingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      height: size.height * 0.09,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        children: [
          leadingIcon,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                taskTitle,
                const SizedBox(height: 5),
                Text(
                  'Task Time',
                  style: TextStyle(color: Colors.black.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz),
          const SizedBox(width: 10)
        ],
      ),
    );
  }
}
