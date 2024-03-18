import 'dart:js_util';

import 'package:e_voting/Views/Widgets/homepage/Voting/voteLabel.dart';
import 'package:e_voting/Views/Widgets/homepage/tabBar.dart';
import 'package:e_voting/Views/Widgets/myAvatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class CandidateProfile extends StatefulWidget {
  @override
  State<CandidateProfile> createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile>
    with SingleTickerProviderStateMixin {
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
      // appBar: AppBar(
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(50),
      //     child:
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //      Clipper ///
                ClipPath(
                  clipper: BottomOvalArcClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 172, 246, 212),
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.black)
                        ]),
                    height: 280,
                    width: double.infinity,
                  ),
                ),

                Positioned(
                  top: 30,
                  left: 20,
                  child: VoteLabel(
                    voteName: 'Vote for Student Representatives',
                  ),
                ),
                //// Profile image ///
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Center(
                      child: MyAvatar(
                    radius: 80,
                    image: 'assets/images/profile.jpg',
                  )),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Ana Pilar Martinez',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //  Tabs /////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              child: MyTabBar(
                text1: 'ABOUT ',
                text2: 'CONTACT',
                controller: _tabController,
              ),
            ),
            Container(
              width: double.infinity,
              height: 500,
              color: Colors.amber,
              child: TabBarView(controller: _tabController, children: [
                Container(
                  child: Text('about'),
                ),
                Container(
                  child: Text('contat'),
                ),
              ]),
            )
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
    var controlPoint1 = Offset(50, size.height - 100);
    var controlPoint2 = Offset(size.width - 50, size.height);
    var endPoint = Offset(x, y);

    Path path = Path();
    path.lineTo(0, 0);
    // path.lineTo(0, y);
    path.lineTo(0, size.height - 150);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
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
