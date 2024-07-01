import 'package:e_voting/Providers/electionData.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:e_voting/Screens/Auth/authScreen.dart';

class VoteLabel extends StatelessWidget {
  String? voteName;
  double? fontsize;
  FontWeight? fontWeight;

  Alignment? alignment;
  VoteLabel(
      {this.voteName,
      this.fontsize = 18,
      this.fontWeight = FontWeight.w500,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    electionData elec_data = Get.put(electionData());
    return Container(
      padding: EdgeInsets.only(left: 12, top: 4.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: AppStyle.iconClr,
            ),
            // color: AppStyle.textClr,
            // iconSize: 25,
            // splashRadius: 20,
          ),
          // gap(
          //   Width: Applayout.getWidth(3),
          // ),
          Expanded(
            child: Obx(
              () => Text(
                elec_data.electionTitle.toString(),
                style: GoogleFonts.inter(
                    color: AppStyle.textClr,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  String? title;
  Widget? widget;
  ScreenTitle({super.key, this.title, this.widget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          // color: AppStyle.textClr,
          color: AppStyle.iconClr,
          size: 3.h,
        ),
      ),
      title: Text(
        title!,
        style: GoogleFonts.inter(
            // color: AppStyle.textClr,
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

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: AppStyle.iconClr,
        ),
      ),
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
