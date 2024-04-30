import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoteCard extends StatelessWidget {
  final String title;
  final String time;
  final String description;

  VoteCard(
      {required this.title, required this.time, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: Applayout.getWidth(15),
            vertical: Applayout.getheight(20)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: 75.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Applayout.getWidth(20),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  color: Colors.grey.shade400,
                  offset: Offset(1, 8))
            ],
            // gradient: AppStyle.Gradientcolor,
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff96F3CF), Color(0xffA3F8C6)])),
        child: Column(
          children: [
            Text(
              'Vote for \n $title',
              style: GoogleFonts.inter(
                  fontSize: 17.sp,
                  height: 1.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              time,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
