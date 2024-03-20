import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primary = Color(0xFF36bb75);

class AppStyle {
  static Color primaryColor = primary;
  static Color bluecolor = Color(0xFF29a0b0);
  static const Color orangeColor = Color(0xfffb9736);
  static const Color darkblueColor = Color(0xff25b9ff);
  static const Color lightGrayColor = Color(0xff25b9ff);

  static LinearGradient Gradientcolor = const LinearGradient(
    colors: [Color(0xFF36bb75), Color(0xFF29a0b0)],
    begin: Alignment.topLeft, // Where the gradient starts
    end: Alignment.bottomRight, // Where the gradient ends
  );

  static Color textcolor = Color.fromARGB(255, 40, 40, 40);

  static TextStyle headstyle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle textStyle1 = GoogleFonts.inter(
    fontSize: 40,
    color: primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle2 = GoogleFonts.inter(
    fontSize: 20,
    color: primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle3 = GoogleFonts.inter(
      fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle headlinestyle3 = GoogleFonts.inter(
      fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.w500);

  static TextStyle textStyleB4 = GoogleFonts.inter(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle4 = GoogleFonts.inter(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );

  static TextStyle textstyle2B = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle textstyle2 = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle mainbuttonstyle = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    color: Colors.white,
  );
}
