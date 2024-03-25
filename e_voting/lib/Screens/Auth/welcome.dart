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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Applayout.getWidth(17),
            vertical: Applayout.getheight(15)),
        child: ListView(children: [
          Column(
            children: [
              Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: Applayout.getheight(12)),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => FirstScreen());
                    },
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 22,
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Hi Melina!\nWelcome to \nWeVote!',
                  style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2AAA8A)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Applayout.getheight(20),
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
                height: Applayout.getheight(300),
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
                  onPress: () {
                    Get.to(() => Dashboard());
                  },
                  width: 100.w,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
