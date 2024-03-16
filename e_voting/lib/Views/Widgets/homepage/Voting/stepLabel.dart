import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepLabel extends StatelessWidget {
  final String label;
  final bool isStep;

  StepLabel({required this.label, required this.isStep});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
          color: isStep ? Colors.black : Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w700),
      textAlign: TextAlign.center,
    );
  }
}
