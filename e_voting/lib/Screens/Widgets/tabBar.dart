import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTabBar extends StatelessWidget {
  // const MyTabBar({super.key});

  final String text1;
  final String text2;
  final TabController? controller;
  MyTabBar({required this.text1, required this.text2, this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        // enableFeedback: true,
        // tabAlignment: TabAlignment.center,
        indicatorSize: TabBarIndicatorSize.tab,
        // indicatorWeight: 10,
        indicatorPadding: EdgeInsets.only(bottom: 2),
        isScrollable: true,
        labelColor: AppStyle.primaryColor,
        unselectedLabelColor: Colors.grey,
        indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(width: 7, color: AppStyle.primaryColor)),
        tabs: [
          Tab(
            child: Text(
              text1,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Tab(
            child: Text(
              text2,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ]);
  }
}
