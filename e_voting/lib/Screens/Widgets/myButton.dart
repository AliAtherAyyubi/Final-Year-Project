import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyButton extends StatelessWidget {
  // const MyButton({super.key});

  final String text;
  double? width = 100.w;
  final double? height;
  final double? elevation;
  Color? backClr;
  final Color? textClr;
  Function? onPress;
  // Widget? page = Container();
  // void trigger(){}

  MyButton(
      {required this.text,
      this.width,
      this.height = 60,
      this.elevation = 10,
      this.backClr = AppStyle.primaryColor,
      this.textClr = Colors.white,
      this.onPress});

  void buttonFunction() {
    onPress!();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // margin: EdgeInsets.only(top: 10),
        width: width,
        height: height,
        // decoration:
        //     BoxDecoration(borderRadius: BorderRadius.circular(50), boxShadow: [
        //   BoxShadow(
        //       color: Color.fromARGB(255, 114, 247, 118),
        //       blurRadius: 10,
        //       spreadRadius: 0,
        //       offset: Offset(0, 10))
        // ]),
        child: ElevatedButton(
          onPressed: () {
            onPress!();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: backClr,
            elevation: elevation,
            shadowColor: AppStyle.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
                fontSize: Applayout.greater760() ? 15.sp : 17.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: textClr),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
