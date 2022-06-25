import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotoSansText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final bool overflow;
  final bool lineThrough;
  final bool lightFont;
  const NotoSansText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.overflow = false,
    this.lineThrough = false,
    this.lightFont = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.notoSans(
        color: color,
        fontSize: fontSize,
        decoration: lineThrough ? TextDecoration.lineThrough : null,
        fontWeight: lightFont ? FontWeight.w300 : null,
      ),
      overflow: overflow ? TextOverflow.ellipsis : null,
    );
  }
}
