import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphicEffect extends StatelessWidget {
  final Widget child;
  const GlassMorphicEffect({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: child,
      ),
    );
  }
}
