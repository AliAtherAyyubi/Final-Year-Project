import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'Hi Melina!\nWelcome to \nWeVote!',
                style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2AAA8A)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Your account has been created successfully!',
              style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 400,
              width: 100.w,
              // margin: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/castvote.jpg',
                filterQuality: FilterQuality.high,
              ),
            ),

            // continue Button //
            Align(
              alignment: Alignment.bottomCenter,
              child: MyButton(
                text: 'CONTINUE',
                width: 100.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}