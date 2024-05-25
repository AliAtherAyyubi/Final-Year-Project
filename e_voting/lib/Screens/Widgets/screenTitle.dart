import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoteLabel extends StatelessWidget {
  electionData elec_data = Get.put(electionData());
  //

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, top: 3.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            color: AppStyle.textClr,
            iconSize: 25,
            splashRadius: 20,
          ),
          // gap(
          //   Width: Applayout.getWidth(3),
          // ),
          Obx(
            () => Text(
              elec_data.electionTitle.toString(),
              style: GoogleFonts.inter(
                  color: AppStyle.textClr,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
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
          size: 25,
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

class TextLabel extends StatelessWidget {
  String field;
  TextLabel({required this.field});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(
        field,
        style: AppStyle().h2.copyWith(fontSize: 22, color: Colors.black),
      ),
    );
  }
}
