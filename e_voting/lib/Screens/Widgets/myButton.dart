import 'package:e_voting/Screens/Widgets/loading.dart';
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
  final FontWeight fontWeight;
  Color? backClr;
  final Color? textClr;
  final bool? border;
  final bool? loading;
  Function? onPress;
  // Widget? page = Container();
  // void trigger(){}

  MyButton(
      {required this.text,
      this.width,
      this.height = 55,
      this.elevation = 10,
      this.fontWeight = FontWeight.bold,
      this.backClr = AppStyle.primaryColor,
      this.textClr = Colors.white,
      this.border = false,
      this.loading = false,
      this.onPress});

  void buttonFunction() {
    onPress!();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(top: 10),
        width: width,
        height: height,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50),
        //     boxShadow: const [
        //       BoxShadow(
        //           color: Color.fromARGB(185, 161, 255, 189),
        //           blurRadius: 3,
        //           spreadRadius: 0,
        //           offset: Offset(0, 5))
        //     ]),
        child: ElevatedButton(
          onPressed: loading! ? null : buttonFunction,
          // style
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppStyle.primaryColor,
            backgroundColor: backClr,
            elevation: elevation,
            shadowColor: AppStyle.primaryColor,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: border!
                    ? BorderSide(color: Colors.white, width: 2)
                    : BorderSide.none),
            // side: BorderSide(color: Colors.white)
          ),
          child: loading!
              ? Loading(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: GoogleFonts.inter(
                      fontSize: Applayout.greater760() ? 15.sp : 18.sp,
                      fontWeight: fontWeight,
                      letterSpacing: 1,
                      color: textClr),
                  textAlign: TextAlign.center,
                ),
        ));
  }
}

class MyTextButton extends StatelessWidget {
  final String text;
  final double? elevation;
  final FontWeight fontWeight;
  final bool? border;
  final Color? textClr;
  Function? onPress;

  MyTextButton(
      {required this.text,
      this.elevation = 10,
      this.fontWeight = FontWeight.bold,
      this.textClr = AppStyle.textClr,
      this.border = false,
      this.onPress});

  void buttonFunction() {
    onPress!();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonFunction,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
            Colors.transparent), // Remove background color on tap
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
            fontSize: Applayout.greater760() ? 15.sp : 18.sp,
            fontWeight: fontWeight,
            letterSpacing: 1,
            color: textClr),
        textAlign: TextAlign.center,
      ),
    );
  }
}
