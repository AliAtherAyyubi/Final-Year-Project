import 'package:e_voting/Screens/Auth/firstscreen.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Applayout.getWidth(17),
            vertical: Applayout.getheight(15)),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Hi Melina!\nWelcome to \nWeVote!',
              style: GoogleFonts.inter(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2AAA8A)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: Applayout.getheight(20),
            ),
            SizedBox(
              width: 80.w,
              child: Text(
                'Your account has been created successfully!',
                style: GoogleFonts.inter(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: Applayout.getheight(20),
            ),
            Expanded(
              flex: 10,
              // height: 40.h,
              // width: 80.w,
              // margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/voted2.jpg',
                filterQuality: FilterQuality.high,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // continue Button //
            MyButton(
              text: 'CONTINUE',
              width: 100.w,
              onPress: () {
                Get.off(() => Dashboard(),
                    // duration: const Duration(seconds: 1),
                    transition: Transition.rightToLeft);
              },
            ),
            // SizedBox(
            //   height: 10,
            // )
          ],
        ),
      ),
    );
  }
}
