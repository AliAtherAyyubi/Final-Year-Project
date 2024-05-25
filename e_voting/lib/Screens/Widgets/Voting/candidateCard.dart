import 'package:e_voting/Providers/candidateData.dart';
import 'package:e_voting/Screens/Profile/candi_Profile.dart';
import 'package:e_voting/Screens/Voting/idCheck.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CandidateCard extends StatelessWidget {
  // const CandidateCard({super.key});
  candidateData candi_data = Get.put(candidateData());
  final String name;
  final String? id;
  // final String description;
  List<dynamic>? description;
  List<String>? links;
  CandidateCard(
      {required this.name, this.description, this.links, this.id, super.key});

  double btnHeight = Applayout.smaller290() ? 45 : 55;

  @override
  Widget build(BuildContext context) {
    return //// Candidate Card Section ///
        ///
        Container(
      margin: EdgeInsets.only(bottom: Applayout.getheight(30)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                blurRadius: 7,
                offset: Offset(0, 3),
                color: Color.fromARGB(255, 105, 215, 157))
          ]),

      /// GF card //
      child: GFCard(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppStyle.cardClr,
        // borderRadius: const BorderRadius.all(Radius.circular(20)),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.only(top: 10, bottom: 15),

        ////                    ///////
        //// upper part ///
        title: GFListTile(
          padding: EdgeInsets.all(0),
          //// Avatar ///
          avatar: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: MyAvatar(
              image: 'assets/images/profile.jpg',
              radius: 15.w,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              name,
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          subTitle: Text(
            description![0],
            style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),
        // Buttons
        buttonBar: GFButtonBar(
          padding: EdgeInsets.all(0),
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Applayout.smaller290() ? Axis.vertical : Axis.horizontal,
          children: <Widget>[
            MyButton(
              height: btnHeight,
              width: Applayout.smaller290() ? 80.w : 50.w,
              text: 'VIEW PROFILE',
              elevation: 0,
              backClr: Colors.white,
              textClr: AppStyle.textClr,
              onPress: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: CandidateProfile(
                      name: name,
                      description: description,
                    ),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
            SizedBox(
              width: Applayout.smaller290() ? 0 : 5,
            ),
            MyButton(
              height: btnHeight,
              width: Applayout.smaller290() ? 80.w : 30.w,
              text: 'VOTE',
              elevation: 0,
              onPress: () {
                candi_data.setCandidateId(id);
                candi_data.setCandidateName(name);
                Navigator.push(
                  context,
                  PageTransition(
                    child: idValidationPage(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
