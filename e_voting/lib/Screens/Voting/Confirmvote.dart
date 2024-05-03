import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Voting/voteSuccess.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/candidateAvatar.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmVote extends StatelessWidget {
  String voteName = 'Vote for Student Representatives';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: VoteLabel(
                voteName: voteName,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            VoteStepper(
              currentStepNo: 3,
            ),
            gap(
              Height: Applayout.getheight(50),
            ),
            Container(
              width: 80.w,
              child: Text(
                'Are you sure you want to vote for this candidate? Once confirmed, this action can\'t be undone.',
                style: GoogleFonts.inter(
                    fontSize: 18.sp, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            gap(
              Height: Applayout.getheight(20),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: Applayout.getheight(380),
              // color: Colors.amber,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: Applayout.getheight(200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 92, 250, 163),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 39, 171, 79),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 5))
                      ],
                      borderRadius:
                          BorderRadius.circular(Applayout.getheight(30)),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      child: CandidateAvatar(
                        radius: 24.w,
                        fontsize: 20,
                        image: 'assets/images/profile.jpg',
                        name: "Najam-Ud-Din",
                      )),
                ],
              ),
            ),
            MyButton(
              text: 'CONFIRM',
              width: 95.w,
              onPress: () {
                Get.to(() => VoteSuccess(), transition: Transition.native);
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              text: 'CANCEL',
              width: 95.w,
              textClr: AppStyle.textClr,
              elevation: 0,
              border: false,
              backClr: Colors.transparent,
              onPress: () {
                Get.to(() => Dashboard(), transition: Transition.fadeIn);
              },
            ),
          ],
        ),
      ),
    );
  }
}
