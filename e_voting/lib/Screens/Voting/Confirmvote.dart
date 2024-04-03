import 'package:e_voting/Screens/Voting/voteSuccess.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Applayout.getWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              VoteLabel(
                voteName: voteName,
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
                Height: Applayout.getheight(40),
              ),
              Container(
                height: Applayout.getheight(360),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: Applayout.getheight(180),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppStyle.textcolor.withOpacity(0.7),
                                spreadRadius: 0.7,
                                blurRadius: 1,
                                offset: Offset(0, 6))
                          ],
                          borderRadius:
                              BorderRadius.circular(Applayout.getheight(20)),
                          gradient: AppStyle.Gradientcolor1),
                    ),
                    Positioned(
                        top: 0,
                        child: CandidateAvatar(
                          radius: 30.w,
                          fontsize: 15,
                          image: 'assets/images/profile.jpg',
                          name: "Najam-Ud-Din",
                        )),
                    Positioned(
                      left: 0,
                      bottom: 10,
                      child: MyButton(
                        text: "CONFIRM",
                        onPress: () {
                          Get.to(() => VoteSuccess());
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 10,
                      child: MyButton(
                        text: "CANCEL",
                        backClr: Colors.white,
                        textClr: Colors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
