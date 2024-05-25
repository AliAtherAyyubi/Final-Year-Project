import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyTabBar extends StatelessWidget {
  // const MyTabBar({super.key});

  final String text1;
  final String text2;
  final TabController? controller;
  TabBarIndicatorSize? tabBarIndicatorSize;
  double? tabPadding;
  MyTabBar(
      {required this.text1,
      required this.text2,
      this.tabPadding = 8,
      this.controller,
      this.tabBarIndicatorSize});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        // enableFeedback: true,
        tabAlignment: TabAlignment.center,
        indicatorSize: tabBarIndicatorSize,
        // indicatorPadding: EdgeInsets.only(top: 10),
        // indicatorWeight: 50,
        labelPadding: EdgeInsets.symmetric(horizontal: tabPadding!),
        isScrollable: true,
        labelColor: AppStyle.textClr,
        labelStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelColor: Colors.grey,
        indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(width: 7, color: AppStyle.primaryColor)),
        tabs: [
          Tab(
            text: text1,
          ),
          Tab(
            text: text2,
          )
        ]);
  }
}
