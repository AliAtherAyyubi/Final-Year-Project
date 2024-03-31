import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary = Color(0xFF36bb75);

class AppStyle {
  static const Color primaryColor = primary;
  static const Color textClr = Color(0xff00A36C);
  static const Color darkGreen = Color(0xff228B22);
  static const Color bluecolor = Color(0xFF29a0b0);
  static const Color orangeColor = Color(0xfffb9736);
  static const Color darkblueColor = Color(0xff25b9ff);
  static const Color lightGrayColor = Color(0xff25b9ff);

  static LinearGradient Gradientcolor2 = const LinearGradient(
    colors: [Color(0xfffb9736), Color(0xFF29a0b0)],
    begin: Alignment.topLeft, // Where the gradient starts
    end: Alignment.bottomRight, // Where the gradient ends
  );

  static LinearGradient Gradientcolor = const LinearGradient(
    colors: [Color(0xFF36bb75), Color(0xFF29a0b0)],
    begin: Alignment.topLeft, // Where the gradient starts
    end: Alignment.bottomRight, // Where the gradient ends
  );

  static LinearGradient Gradientcolor1 = const LinearGradient(
    colors: [Color(0xFF36bb75), Color.fromARGB(255, 223, 223, 223)],
    begin: Alignment.topLeft, // Where the gradient starts
    end: Alignment.bottomRight, // Where the gradient ends
  );

  static Color textcolor = Color.fromARGB(255, 40, 40, 40);

  static TextStyle headstyle = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle textStyle1 = GoogleFonts.inter(
    fontSize: 18,
    color: primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle2 = GoogleFonts.inter(
    fontSize: 20,
    color: textClr,
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
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textstyle2B = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle mainbuttonstyle = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    color: Colors.white,
  );
}
