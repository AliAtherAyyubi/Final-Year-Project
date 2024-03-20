import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/Screens/Widgets/homepage/tabBar.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            const SizedBox(
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
              height: 250,
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                  child: Container(
                    // color: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SHORT BIOGRAPHY',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'My name is Ana Pilar, but you can just call me Ani. I am 26 years old and I\'m currently living in Belgrano, CABA. This is my third year studying Architecture in the University UIX. Also, I am working as a part-time teacig assistant.',
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
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'I combine experience with passion. I am incredibly commited to advocating for you. My focus: better mental health resources, fairer assessments, and affordable on-campus living. Open communication, strong advocacy - that\'s my promise. Let\'s make our university thrive!',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2nd page //
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SOCIAL NETWORKS',
                        style: AppStyle.textStyle2.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppStyle.primaryColor,
                            radius: 20,
                            child: const Icon(
                              Icons.facebook,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: AppStyle.primaryColor,
                            radius: 20,
                            child: const Icon(
                              FontAwesomeIcons.instagram,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              text: 'VOTE',
              width: 90.w,
              height: 60,
            ),
            SizedBox(
              height: 20,
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
