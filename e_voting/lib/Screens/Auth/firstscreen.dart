import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/registerPage.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/elogo.png'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF36bb75).withOpacity(0.5),
                  Color(0xFF29a0b0)..withOpacity(0.5)
                ],
                begin: Alignment.topLeft, // Where the gradient starts
                end: Alignment.bottomRight, // Where the gradient ends
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Applayout.getWidth(15),
              vertical: Applayout.getheight(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Participate in Elections\n easily!",
                style: AppStyle.textStyle3.copyWith(fontSize: 25),
              ),
              gap(
                Height: 320,
              ),
              Container(
                height: Applayout.getheight(55),
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return AppStyle.primaryColor;
                        } else if (states.contains(MaterialState.hovered)) {
                          return AppStyle.orangeColor;
                        }
                      }),
                      foregroundColor:
                          MaterialStatePropertyAll(AppStyle.bluecolor),
                      // backgroundColor:
                      //     MaterialStatePropertyAll(AppStyle.primaryColor),
                      elevation: MaterialStatePropertyAll(7.0),
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                    onPressed: () {
                      Get.to(() => RegisterPage());
                    },
                    child: Text(
                      "SIGN UP",
                      style: AppStyle.textStyleB4.copyWith(
                        fontSize: 17,
                      ),
                    )),
              ),
              gap(
                Height: Applayout.getheight(15),
              ),
              Container(
                height: Applayout.getheight(55),
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return AppStyle.primaryColor;
                        } else if (states.contains(MaterialState.hovered)) {
                          return AppStyle.orangeColor;
                        }
                      }),
                      // backgroundColor:
                      //     MaterialStatePropertyAll(AppStyle.primaryColor),
                      elevation: MaterialStatePropertyAll(7.0),
                      mouseCursor: MaterialStateMouseCursor.clickable,
                    ),
                    onPressed: () {
                      Get.toNamed("/loginpage");
                    },
                    child: Text(
                      "LOG IN",
                      style: AppStyle.textStyleB4.copyWith(fontSize: 17),
                    )),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
