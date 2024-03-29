import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                Width: Applayout.getWidth(3),
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
          ),
        )
        // IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //   ),
        //   iconSize: 20,
        //   // splashRadius: 25,
        //   color: AppStyle.primaryColor,
        // ),
        // Text(
        //   voteName!,
        //   style: GoogleFonts.inter(
        //       color: AppStyle.textClr,
        //       // fontSize: 18.sp,
        //       fontSize: Applayout.getWidth(16),
        //       fontWeight: FontWeight.w500),
        // ),
      ],
    );
  }
}
