import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoteLabel extends StatelessWidget {
  // const VoteLabel({super.key});

  String? voteName;
  VoteLabel({this.voteName});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, weight: 20),
          iconSize: 22,
          splashRadius: 10,
          color: Color(0xff2AAA8A),
        ),
        Text(
          voteName!,
          style: GoogleFonts.inter(
              color: Colors.green,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
