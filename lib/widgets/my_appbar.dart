import 'package:flutter/material.dart';

import './glassmorphic_cover.dart';
import './notosans_text.dart';

class MyAppBar extends StatelessWidget {
  final String appBarTitle;
  const MyAppBar({Key? key, required this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassMorphicEffect(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: Color.fromRGBO(80, 130, 252, 0.5),
            ),
          ),
        ),
        child: AppBar(
          foregroundColor: Theme.of(context).hintColor,
          backgroundColor: Colors.transparent,
          title: NotoSansText(
            text: appBarTitle,
            fontSize: 24,
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
