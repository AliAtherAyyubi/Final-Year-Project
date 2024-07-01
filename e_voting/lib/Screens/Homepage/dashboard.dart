import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Providers/userData.dart';
import 'package:e_voting/Screens/Profile/userProfile.dart';
import 'package:e_voting/Screens/Homepage/onGoing.dart';
import 'package:e_voting/Screens/Homepage/upcoming.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/tabBar.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Dashboard extends StatefulWidget {
  // change voted screen var//
  bool voted = false;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UserData data = Get.put(UserData());

  // Completion screen//
  // late TabController? tabController;
  Future<void> setUserId() async {
    UserModel user = await UserLocalData().fetchLocalUser();
    data.setUserId(user.userId);
  }

  @override
  void initState() {
    super.initState();
    // tabController = TabController(vsync: this, length: 2);
    // setUserId();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            // toolbarHeight: 50,
            automaticallyImplyLeading: false,
            title: Text(
              'EasyVote',
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppStyle.primaryColor),
              // textAlign: TextAlign.center,
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),

          ///////////////////////
          body: RefreshIndicator(
            onRefresh: setUserId,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Elections',
                      style: AppStyle()
                          .h2
                          .copyWith(color: Colors.black, fontSize: 28),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  OnGoingElectionPage()
                ],
              ),
            ),
          )),
    );
  }
}
// Completion page class ///

class VoteCompletePage extends StatefulWidget {
  late TabController? tabController;
  VoteCompletePage({this.tabController});

  @override
  State<VoteCompletePage> createState() => _VoteCompletePageState();
}

class _VoteCompletePageState extends State<VoteCompletePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
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
                    const SizedBox(
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
                widget.tabController!.index = (widget.tabController!.index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
