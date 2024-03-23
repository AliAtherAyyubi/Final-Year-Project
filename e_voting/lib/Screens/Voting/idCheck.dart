import 'package:e_voting/Screens/Voting/Facerecognition1.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class idValidationPage extends StatelessWidget {
  // const idValidationPage({super.key});
  final _formKey = GlobalKey<FormState>();

  TextEditingController cnic = TextEditingController();
  String voteName = 'Vote for Student Representatives';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
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
              // SizedBox(
              //   height: 20,
              // ),
              VoteStepper(currentStepNo: 1),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Enter your CNIC below',
                  style: AppStyle.textStyleB4.copyWith(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: AuthTextField(
                    controller: cnic,
                    keyboardType: TextInputType.number,
                    labelText: '35201-4565236-5',
                    obscureText: false,
                    icon: FontAwesomeIcons.idBadge,
                    maxlength: 15,
                  ),
                ),
              ),
              // SizedBox(
              //   height: 0,
              // ),
              Container(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/idCheck.jpg',
                  filterQuality: FilterQuality.high,
                ),
              ),
              MyButton(
                text: 'CONTINUE',
                backClr: AppStyle.primaryColor,
                width: 100.w,
                onPress: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: FaceRecognition1(),
                          type: PageTransitionType.fade));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
