import 'package:e_voting/Screens/Profile/userProfile.dart';
import 'package:e_voting/Screens/Homepage/onGoing.dart';
import 'package:e_voting/Screens/Homepage/upcoming.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/tabBar.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  bool voted = true;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  // Completion screen//

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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Container(
                  margin: EdgeInsets.all(5),
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
                    onPressed: () {
                      Get.to(UserProfilePage(),
                          transition: Transition.rightToLeft);
                    },
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
          body: Column(
            children: [
              SizedBox(
                height: Applayout.getheight(20),
              ),
              //    Tab s//
              Expanded(
                flex: 1,
                child: Container(
                  height: Applayout.getheight(45),
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  margin: EdgeInsets.only(bottom: 12),
                  child: MyTabBar(
                    text1: 'ONGOING ELECTIONS',
                    text2: 'UPCOMING ELECTIONS',
                    controller: _tabController,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    /// Tab 1 //
                    widget.voted ? VoteCompletePage() : OnGoingElectionPage(),

                    //    Tab No.2 ///
                    UpcomingElection(),
                  ],
                ),
              ),
              gap(
                Height: Applayout.getheight(4),
              ),

              SizedBox(
                height: Applayout.getheight(15),
              ),
            ],
          )),
    );
  }
}
// Completion page class ///

class VoteCompletePage extends StatelessWidget {
  const VoteCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 5,
          child: Container(
              height: 200,
              width: 75.w,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(0, 10),
                        blurRadius: 10)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'YOU\'VE JUST VOTED!',
                    style: AppStyle.textStyle2
                        .copyWith(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'There are no ongoing elctions. We will send you a reminder for the next election.',
                    style: AppStyle.textStyle4.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 10,
          child: Container(
              height: 40.h,
              width: 75.w,
              child: Image.asset('assets/images/voted3.jpg')),
        ),
        Expanded(
          flex: 0,
          child: MyButton(
            text: 'SEE UPCOMING ELECTIONS',
            width: 90.w,
            onPress: () {
              Get.to(() => VotingPage(), transition: Transition.fade);
            },
          ),
        ),
      ],
    );
  }
}
