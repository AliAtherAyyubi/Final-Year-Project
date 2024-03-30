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

class ConfirmVote extends StatelessWidget {
  const ConfirmVote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Applayout.getWidth(10),
            vertical: Applayout.getheight(10)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              gap(
                Height: Applayout.getheight(30),
              ),
              VoteLabel(
                voteName: "Vote for Student representative",
              ),
              gap(
                Height: Applayout.getheight(5),
              ),
              VoteStepper(currentStepNo: 3),
              gap(
                Height: Applayout.getheight(50),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Are you sure you want to vote for",
                      style: AppStyle.textStyleB4,
                    ),
                    Text(
                      "this candidate?Once confirmed,",
                      style: AppStyle.textStyleB4,
                    ),
                    Text(
                      "this action can not be undone.",
                      style: AppStyle.textStyleB4,
                    ),
                    gap(
                      Height: Applayout.getheight(40),
                    ),
                    Container(
                      //color: Colors.amber,
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
                                      color:
                                          AppStyle.textcolor.withOpacity(0.7),
                                      spreadRadius: 0.7,
                                      blurRadius: 1,
                                      offset: Offset(0, 6))
                                ],
                                borderRadius: BorderRadius.circular(
                                    Applayout.getheight(20)),
                                gradient: AppStyle.Gradientcolor1),
                          ),
                          Positioned(
                              top: 0,
                              child: MyProfileAvatar(
                                radius: 100,
                                image: 'assets/images/profile.jpg',
                                name: "Najam-Ud-Din",
                              )),
                          Positioned(
                              left: 0,
                              bottom: 10,
                              child: MyButton(text: "CONFIRM")),
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
