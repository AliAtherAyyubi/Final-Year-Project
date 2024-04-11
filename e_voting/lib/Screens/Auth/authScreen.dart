import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/registerPage.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppStyle.primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo //
            SizedBox(
              height: 40,
            ),
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'WeVote',
                  style: AppStyle.headstyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: SizedBox(
                width: 80.w,
                child: Text(
                  'Participate in elections easily!',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            Expanded(
                flex: 6,
                child: Column(
                  children: [
                    MyButton(
                      elevation: 0,
                      width: 90.w,
                      text: 'SIGN UP',
                      backClr: Colors.white,
                      textClr: AppStyle.textClr,
                      onPress: () {
                        Get.to(() => const RegisterPage(),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyButton(
                      elevation: 0,
                      width: 90.w,
                      text: 'LOG IN',
                      backClr: AppStyle.primaryColor,
                      border: true,
                      textClr: Colors.white,
                      onPress: () {
                        Get.to(() => LoginPage(),
                            transition: Transition.rightToLeft);
                      },
                    ),
                  ],
                ))
          ],
        ),

        // padding: EdgeInsets.symmetric(
        //       horizontal: Applayout.getWidth(15),
        //       vertical: Applayout.getheight(50)),
      ),
    );
  }
}
