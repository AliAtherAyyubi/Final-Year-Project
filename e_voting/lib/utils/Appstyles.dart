import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primary = Color(0xFF36bb75);

class AppStyle {
  static const Color primaryColor = primary;
  static const Color textClr = Color(0xff228B22);
  static const Color cardClr = Color(0xffA4FBBE);
  static const Color darkGreen = Color(0xff488f3c);
  static const Color iconClr = textClr;

  TextStyle h1 = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: textClr,
  );

  TextStyle h2 = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: textClr,
  );

  TextStyle h3 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textClr,
  );

  TextStyle txt1 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  TextStyle txt2 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  TextStyle txt3 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  TextStyle txt4 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w100,
    color: Colors.black,
  );

  static TextStyle headstyle = GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle textStyle1 = GoogleFonts.inter(
    fontSize: 18,
    color: textClr,
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
    fontWeight: FontWeight.w500,
  );

  static TextStyle textstyle2B = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black,
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
}
