import 'package:flutter/material.dart';

import '../screens/home/main.dart';
import '../screens/tasks/all_tasks_list.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          DrawerItem(
            label: 'Today',
            onTap: () => switchScreens(
              context,
              const HomeScreen(),
            ),
          ),
          const SizedBox(height: 10),
          DrawerItem(
            label: 'Summary',
            onTap: () => switchScreens(
              context,
              const AllTasksList(),
            ),
          ),
        ],
      ),
    );
  }

  void switchScreens(BuildContext context, Widget targetPage) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String label;
  final Function() onTap;
  const DrawerItem({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: onTap,
    );
  }
}
