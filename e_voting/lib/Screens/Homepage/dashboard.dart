import 'package:e_voting/Screens/Voting/onGoing.dart';
import 'package:e_voting/Screens/Voting/upcoming.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/tabBar.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            actions: [
              Container(
                margin: EdgeInsets.all(Applayout.getWidth(5)),
                height: Applayout.getheight(62),
                width: Applayout.getWidth(60),
                decoration: BoxDecoration(
                    color: AppStyle.primaryColor,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Applayout.getheight(20),
              ),
              //    Tab s//
              Container(
                height: Applayout.getheight(45),
                padding: EdgeInsets.symmetric(horizontal: 1),
                margin: EdgeInsets.only(bottom: 12),
                child: MyTabBar(
                  text1: 'ONGOING ELECTIONS',
                  text2: 'UPCOMING ELECTIONS',
                  controller: _tabController,
                ),
              ),
              Container(
                width: double.infinity,
                height: 500,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    /// Tab 1 //
                    OnGoingElectionPage(),
                    //    Tab No.2 ///
                    UpcomingElection(),
                  ],
                ),
              ),
              gap(
                Height: Applayout.getheight(4),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MyButton(
                  text: 'VOTE NOW',
                  textClr: Colors.white,
                  width: 90.w,
                  backClr: AppStyle.primaryColor,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VotingPage()));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
