import 'package:flutter/material.dart';

import './main_drawer.dart';

class MyScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final Widget? floatingActionButton;
  const MyScaffold({
    Key? key,
    required this.appBarTitle,
    required this.body,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
