import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
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
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          iconSize: 25,
          // splashRadius: 25,
          color: AppStyle.primaryColor,
        ),
        Text(
          voteName!,
          style: GoogleFonts.inter(
              color: AppStyle.textClr,
              // fontSize: 18.sp,
              fontSize: Applayout.getWidth(16),
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
