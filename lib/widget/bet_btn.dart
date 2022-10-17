import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BetButtons extends StatelessWidget {
  final Color color;
  final Color backgroundColor;
  double size;
  final Color borderColor;
  String text;

  BetButtons({
    super.key,
    required this.size,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.acme(color: color),
        ),
      ),
    );
  }
}
