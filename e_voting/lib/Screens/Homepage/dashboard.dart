import 'package:e_voting/Screens/Voting/onGoing.dart';
import 'package:e_voting/Screens/Voting/upcoming.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/tabBar.dart';
import 'package:e_voting/utils/Appstyles.dart';
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
                margin: EdgeInsets.all(5),
                height: 60,
                width: 60,
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
                height: 20,
              ),
              //    Tab s//
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: MyTabBar(
                    text1: 'ONGOING ELECTIONS',
                    text2: 'UPCOMING ELECTIONS',
                    controller: _tabController,
                  ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: MyButton(
                  text: 'VOTE NOW',
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
