import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primary = Color(0xFF36bb75);

class styles {
  static Color greencolor = primary;
  static Color bluecolor = Color(0xFF29a0b0);
  static const Color orangeColor = Color(0xfffb9736);
  static const Color darkblueColor = Color(0xff25b9ff);
  static const Color lightGrayColor = Color(0xff25b9ff);

  static LinearGradient Gradientcolor = LinearGradient(
    colors: [Color(0xFF36bb75), Color(0xFF29a0b0)],
    begin: Alignment.topLeft, // Where the gradient starts
    end: Alignment.bottomRight, // Where the gradient ends
  );

  static Color textcolor = Color.fromARGB(255, 40, 40, 40);

  static TextStyle textStyle1 = TextStyle(
    fontSize: 40,
    color: primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle2 =
      TextStyle(fontSize: 20, color: primary, fontWeight: FontWeight.bold);

  static TextStyle textStyle3 =
      TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold);

  static TextStyle headlinestyle3 = TextStyle(
      fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.w500);

  static TextStyle textStyleB4 = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textStyle4 = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
}
