import 'dart:async';

import 'package:e_voting/Screens/Voting/Confirmvote.dart';
import 'package:e_voting/Screens/Voting/faceDetect.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';

import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/utils/Appstyles.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FaceRecognition1 extends StatefulWidget {
  // const FaceRecognition1({super.key});
  @override
  State<FaceRecognition1> createState() => FaceRecognition1State();
}

class FaceRecognition1State extends State<FaceRecognition1> {
  bool verification = false;
  bool isDetected = false;

  void handleDetectingChange(bool value) {
    setState(() {
      isDetected = value;
    });
    if (value) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          verification = true;
        });
      });
    } else {
      setState(() {
        verification = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoteLabel(),
            const SizedBox(
              height: 10,
            ),
            VoteStepper(
              currentStepNo: 2,
            ),
            gap(
              Height: 4.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Facial Recognition",
                style: AppStyle.textStyleB4.copyWith(fontSize: 20.sp),
                textAlign: TextAlign.left,
              ),
            ),
            gap(
              Height: Applayout.getheight(30),
            ),
            verification
                ? const Center(
                    child: Image(
                        image: AssetImage(
                          "assets/icons/verified.gif",
                        ),
                        height: 250),
                  )
                : FaceDetectionScreen(onDetectingChange: handleDetectingChange),
            gap(Height: Applayout.getheight(30)),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  isDetected
                      ? 'Your face verified successfully!'
                      : 'To ensure that it  is you who is making this request,we will register your face ',
                  style: AppStyle.textstyle2B,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MyButton(
                  text: "Continue",
                  width: 100.w,
                  onPress: isDetected
                      ? () {
                          Timer(const Duration(seconds: 2), () {
                            setState(() {
                              verification = true;
                            });
                          });
                          Get.to(() => ConfirmVote(),
                              transition: Transition.fadeIn);
                        }
                      : () {},
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
