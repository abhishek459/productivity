import 'package:flutter/material.dart';
import 'package:productivity/utils/date_methods.dart';
import 'package:productivity/widgets/notosans_text.dart';

class TaskLayout extends StatelessWidget {
  final bool taskStatus;
  final Widget taskTitle;
  final DateTime taskSubtitle;
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
                NotoSansText(
                  text: DateMethods.dateFormatter(taskSubtitle),
                  lightFont: true,
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
