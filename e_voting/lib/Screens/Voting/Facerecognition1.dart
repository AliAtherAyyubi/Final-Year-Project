import 'dart:async';

import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';

import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/utils/Appstyles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FaceRecognition1 extends StatefulWidget {
  // const FaceRecognition1({super.key});

  bool verification = false;

  @override
  State<FaceRecognition1> createState() => FaceRecognition1State();
}

class FaceRecognition1State extends State<FaceRecognition1> {
  String voteName = 'Vote for Student Representatives';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
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
                currentStepNo: 2,
              ),
              gap(
                Height: Applayout.getheight(25),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Facial Recognition",
                  style: AppStyle.textStyleB4.copyWith(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
              // gap(
              //   Height: Applayout.getheight(30),
              // ),
              Center(
                child: Image(
                    image: AssetImage(
                      "assets/icons/${widget.verification ? 'verified' : 'face-scan'}.gif",
                    ),
                    height: 250),
              ),
              gap(Height: Applayout.getheight(30)),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.verification
                        ? 'Your face verified successfully!'
                        : 'To ensure that it  is you who is making this request,we will register your face ',
                    style: AppStyle.textstyle2B,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              gap(Height: Applayout.getheight(70), Width: 0),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: MyButton(
                    text: "Continue",
                    width: 100.w,
                    onPress: () {
                      Timer(Duration(seconds: 2), () {
                        setState(() {
                          widget.verification == true
                              ? widget.verification = false
                              : widget.verification = true;
                        });
                      });
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
