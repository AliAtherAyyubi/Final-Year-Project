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
      this.fontWeight = FontWeight.w500,
      this.alignment = Alignment.topLeft});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppStyle.textClr,
            size: 3.h,
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
                  fontSize: Applayout.smaller290() ? 17.sp : 18.sp,
                  fontWeight: fontWeight),
            ),
          ),
        ),
      ],
    );
  }
}

class ScreenTitle extends StatelessWidget {
  String? title;
  ScreenTitle({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: AppStyle.textClr,
          size: 3.h,
        ),
      ),
      title: Text(
        title!,
        style: GoogleFonts.inter(
            color: AppStyle.textClr,
            fontSize: 19.sp,
            fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
