import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyButton extends StatelessWidget {
  // const MyButton({super.key});

  final String text;
  double? width;
  Function? onPress;
  // void trigger(){}

  MyButton({required this.text, this.width, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: width,
      height: 40,
      child: ElevatedButton(
        onPressed: () => onPress,
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff2AAA8A),
        ),
      ),
    );
  }
}
