import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Voting/receipt.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoteSuccess extends StatelessWidget {
  const VoteSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              gap(
                Height: Applayout.getheight(70),
              ),
              Container(
                width: 60.w,
                child: Text(
                  'Thank you! Your vote has submitted successfully.',
                  style: AppStyle.textStyle2.copyWith(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              gap(
                Height: Applayout.getheight(30),
              ),
              Image(image: AssetImage("assets/images/tic2.png")),
              gap(
                Height: Applayout.getheight(36),
              ),
              Container(
                width: 60.w,
                child: Text(
                  "The receipt is send to your email address.",
                  style:
                      AppStyle.textStyle4.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              gap(
                Height: Applayout.getheight(45),
              ),
              MyButton(
                text: "BACK TO HOME SCREEN",
                width: 90.w,
                onPress: () {
                  Get.to(() => Dashboard(), transition: Transition.rightToLeft);
                },
              ),
              gap(
                Height: Applayout.getheight(10),
              ),
              MyTextButton(
                onPress: () {
                  Get.to(() => ReceiptScreen());
                },
                text: "RECEIPT",
                textClr: AppStyle.textClr,
                elevation: 0,
                border: false,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Textwidget extends StatelessWidget {
  final String text;
  const Textwidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyle.textStyle2,
    );
  }
}
