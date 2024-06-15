import 'package:e_voting/Models/candidate.dart';
import 'package:e_voting/Providers/candidateData.dart';
import 'package:e_voting/Screens/Profile/contact.dart';
import 'package:e_voting/Screens/Voting/idCheck.dart';
import 'package:e_voting/Screens/Voting/vote.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/tabBar.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CandidateProfile extends StatefulWidget {
  CandidateModel? candidate;
  CandidateProfile({this.candidate});
  @override
  State<CandidateProfile> createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile>
    with SingleTickerProviderStateMixin {
  candidateData candi_data = Get.put(candidateData());

  // CandidateProfile({super.key});

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                //      Clipper ///

                Container(
                  height: 300,
                  child: ClipPath(
                    clipBehavior: Clip.antiAlias,
                    clipper: BottomOvalArcClipper(),
                    child: Container(
                      color: AppStyle.cardClr,
                      height: 320,
                      width: double.infinity,
                    ),
                  ),
                ),

                VoteLabel(),
                //// Profile image ///
                Container(
                  margin: EdgeInsets.only(top: 100),
                  alignment: Alignment.center,
                  child: MyAvatar(
                    radius: 90,
                    image: 'assets/images/profile.jpg',
                  ),
                )
              ],
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Text(
              widget.candidate!.name.toString().capitalize!,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            //  Tab container /////
            Center(
              child: MyTabBar(
                text1: 'ABOUT',
                text2: 'CONTACT',
                tabPadding: 40,
                controller: _tabController,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
            ),

            // Tabs Content //
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 40.h,
              child: TabBarView(controller: _tabController, children: [
                // !sst Page //
                AboutContent(
                  description: widget.candidate!.description ?? [],
                ),
                // 2nd page //
                ContactPage()
              ]),
            ),
            SizedBox(
              height: Applayout.getheight(10),
            ),
            MyButton(
              text: 'GO BACK TO VOTE',
              width: 90.w,
              // height: 50,
              onPress: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomOvalArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var x = size.width;
    var y = size.height;
    var controlPoint1 = Offset(50, size.height - 50);
    var controlPoint2 = Offset(size.width - 50, size.height);
    var endPoint = Offset(x, y);

    Path path = Path();
    path.lineTo(0, 0);
    // path.lineTo(0, y);
    path.lineTo(0, size.height - 130);
    path.cubicTo(
        controlPoint1.dx + 20,
        controlPoint1.dy - 40,
        controlPoint2.dx - 70,
        controlPoint2.dy,
        endPoint.dx + 70,
        endPoint.dy - 190);
    // path.lineTo(x, y + 150);
    path.lineTo(x, 0);

    // path.cubicTo(controlPoint2.dx, controlPoint2.dy, controlPoint1.dx,
    //     controlPoint1.dy, endPoint.dx, endPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

//

class AboutContent extends StatelessWidget {
  List<dynamic>? description;
  AboutContent({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SHORT BIOGRAPHY',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description![0] ?? " ",
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'ELECTION MANIFESTO',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description![1] ?? " ",
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
