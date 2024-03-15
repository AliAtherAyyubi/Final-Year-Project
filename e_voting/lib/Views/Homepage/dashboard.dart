import 'package:e_voting/Views/Homepage/Voting/onGoing.dart';
import 'package:e_voting/Views/Homepage/Voting/upcoming.dart';
import 'package:e_voting/Views/Widgets/Custom/myButton.dart';
import 'package:e_voting/Views/Widgets/Custom/profileAvatart.dart';
import 'package:e_voting/Views/Widgets/homepage/Dashboard/card.dart';
import 'package:e_voting/Views/Widgets/homepage/tabBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:card_swiper/card_swiper.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  TabController? controller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: AppBar(
              actions: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Color(0xff2AAA8A),
                      // borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.shade500,
                            blurRadius: 5,
                            spreadRadius: 2)
                      ]),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.user),
                    iconSize: 22,
                    alignment: Alignment.center,
                    splashRadius: 20,
                    color: Colors.white,
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: MyTabBar(
                  text1: 'ONGOING ELECTIONS',
                  text2: 'UPCOMING ELECTIONS',
                  controller: controller,
                ),
              ),
              title: Text(
                'WeVote',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                // textAlign: TextAlign.center,
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),

          ///////////////////////
          body: TabBarView(
            children: [
              /// Tab 1 //
              OnGoingElectionPage(),
              //    Tab No.2 ///
              UpcomingElection(),
            ],
          )),
    );
  }
}
