import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';

import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/utils/Appstyles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FaceRecognition1 extends StatefulWidget {
  const FaceRecognition1({super.key});

  @override
  State<FaceRecognition1> createState() => FaceRecognition1State();
}

class FaceRecognition1State extends State<FaceRecognition1> {
  String voteName = 'Vote for Student Representatives';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              VoteLabel(
                voteName: voteName,
              ),
              VoteStepper(
                currentStepNo: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Facial Recognition",
                  style: AppStyle.textStyle2,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  //color: Colors.red,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Applayout.getWidth(10),
                          vertical: Applayout.getheight(15),
                        ),
                        height: Applayout.getheight(250),
                        width: Applayout.getWidth(250),
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                          top: BorderSide(
                              width: Applayout.getWidth(3),
                              color: AppStyle.primaryColor),
                          bottom: BorderSide(
                              width: Applayout.getWidth(3),
                              color: AppStyle.primaryColor),
                        )),
                        child: Image(
                            image: AssetImage("assets/images/women1.jpg")),
                      ),
                      Positioned(
                        top: Applayout.getheight(7.0),
                        left: Applayout.getWidth(40.0),
                        child: Container(
                          width: Applayout.getWidth(170),
                          height: Applayout.getheight(170),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                width: Applayout.getWidth(3.0),
                                color: AppStyle.primaryColor,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              gap(Height: Applayout.getheight(14), Width: 0),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'To ensure that it  is you who is making this\n ',
                    style: AppStyle.textstyle2B,
                    children: [
                      TextSpan(
                        text: 'request,we will register your face',
                        style: AppStyle.textstyle2B,
                      ),
                    ],
                  ),
                ),
              ),
              gap(Height: Applayout.getheight(40), Width: 0),
              Center(
                  child: MyButton(
                text: "Continue",
                width: 100.w,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
