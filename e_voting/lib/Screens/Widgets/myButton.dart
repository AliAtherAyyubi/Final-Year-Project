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
  final Color? backClr;
  final Color? textClr;
  // Widget? page = Container();
  // void trigger(){}

  MyButton(
      {required this.text,
      this.width,
      this.height = 50,
      this.elevation = 10,
      this.backClr,
      this.textClr});

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
        //           color: Color.fromARGB(255, 20, 242, 105),
        //           blurRadius: 8,
        //           spreadRadius: 2,
        //           offset: Offset(0, 5))
        //     ]),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => page));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyle.primaryColor,
            elevation: 10,
            shadowColor: AppStyle.bluecolor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Colors.white),
          ),
        ));
  }
}
