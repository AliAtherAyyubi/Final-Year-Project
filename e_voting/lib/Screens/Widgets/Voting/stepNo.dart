import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteSteps extends StatelessWidget {
  final bool isStep;
  final String stepNo;

  VoteSteps({required this.isStep, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: isStep ? Color(0xff2AAA8A) : Colors.green.shade100,
        child: Text(
          stepNo,
          style: GoogleFonts.inter(
              color: isStep ? Colors.white : Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ));
  }
}
