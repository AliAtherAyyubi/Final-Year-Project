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
        // tabAlignment: TabAlignment.center,
        controller: controller,
        indicatorSize: TabBarIndicatorSize.label,
        // indicatorWeight: 10,
        indicatorPadding: EdgeInsets.only(bottom: 2),
        // indicatorColor: Color(0xff2AAA8A),
        // unselectedLabelStyle: TextStyle(color: Colors.grey),
        isScrollable: true,
        labelColor: Color(0xff2AAA8A),
        unselectedLabelColor: Colors.black45,
        indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 7, color: Color(0xff2AAA8A))),
        tabs: [
          Tab(
            child: Text(
              text1,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Tab(
            child: Text(
              text2,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]);
  }
}
