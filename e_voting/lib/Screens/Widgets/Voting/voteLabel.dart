import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoteLabel extends StatelessWidget {
  String? voteName;
  double? fontsize;
  FontWeight? fontWeight;
  Alignment? alignment;
  VoteLabel(
      {this.voteName,
      this.fontsize = 18,
      this.fontWeight,
      this.alignment = Alignment.topLeft});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppStyle.textClr,
            size: 22,
          ),
        ),

        // gap(
        //   Width: Applayout.getWidth(3),
        // ),
        Expanded(
          child: Align(
            alignment: alignment!,
            child: Text(
              voteName!,
              style: GoogleFonts.inter(
                  color: AppStyle.textClr,
                  fontSize: 18.sp,
                  fontWeight: fontWeight),
            ),
          ),
        ),
      ],
    );
  }
}
