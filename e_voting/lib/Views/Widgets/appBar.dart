import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppBar extends StatelessWidget {
  final String logoname;

  MyAppBar({required this.logoname});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(
        Icons.arrow_back_rounded,
        color: Colors.white,
      ),
      title: Text(
        logoname,
        style: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        // textAlign: TextAlign.center,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xff2AAA8A),
    );
  }
}
