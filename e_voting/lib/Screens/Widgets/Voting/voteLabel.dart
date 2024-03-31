import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoteLabel extends StatelessWidget {
  String? voteName;
<<<<<<< Updated upstream
  double? fontsize;
  FontWeight? fontWeight;
  Alignment? alignment;

  VoteLabel(
      {this.voteName,
      this.alignment = Alignment.topLeft,
      this.fontsize = 18,
      this.fontWeight = FontWeight.w500});
=======
  final double gapval;
  VoteLabel({this.voteName, this.gapval = 3});
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
<<<<<<< Updated upstream
        InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppStyle.textClr,
            size: 25,
=======
        Container(
          margin: EdgeInsets.only(
              top: Applayout.getheight(5), bottom: Applayout.getheight(15)),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppStyle.primaryColor,
                  size: 22,
                ),
              ),
              gap(
                Width: Applayout.getWidth(gapval),
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
>>>>>>> Stashed changes
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
                  // fontSize: 18.sp,
                  fontSize: fontsize,
                  fontWeight: fontWeight),
            ),
          ),
        ),
      ],
    );
  }
}
