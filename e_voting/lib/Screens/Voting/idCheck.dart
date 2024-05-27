import 'package:e_voting/Screens/Voting/Facerecognition1.dart';
import 'package:e_voting/Screens/Widgets/Voting/Stepper.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class idValidationPage extends StatefulWidget {
  @override
  State<idValidationPage> createState() => _idValidationPageState();
}

class _idValidationPageState extends State<idValidationPage> {
  // const idValidationPage({super.key});

  final formKey = GlobalKey<FormState>();

  TextEditingController cnic = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              VoteLabel(),
              const SizedBox(
                height: 10,
              ),
              VoteStepper(currentStepNo: 1),
              SizedBox(
                height: 4.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Enter your CNIC below',
                    style: AppStyle.textStyleB4.copyWith(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: AuthTextField(
                    controller: cnic,
                    keyboardType: TextInputType.number,
                    labelText: '35201-4565236-5',
                    obscureText: false,
                    icon: FontAwesomeIcons.idBadge,
                    maxlength: 15,
                    inputFormat: Validation().cnicFormatter,
                    validator: (value) => Validation().isValidCnic(value),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 0,
              // ),
              Container(
                height: 30.h,
                width: 90.w,
                child: Image.asset(
                  'assets/icons/id-card.png',
                  filterQuality: FilterQuality.high,
                  color: AppStyle.primaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                text: 'CONTINUE',
                backClr: AppStyle.primaryColor,
                width: 95.w,
                onPress: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: FaceRecognition1(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
