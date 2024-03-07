import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  // final double fontSize;
  // final FontWeight fontWeight;
  final double? letterSpacing;
  final IconData icon;
  final TextEditingController? controller;
  final FormFieldValidator? validator;

  AuthTextField(
      {this.controller,
      this.validator,
      required this.keyboardType,
      required this.obscureText,
      required this.labelText,
      // required this.fontSize,
      // required this.fontWeight,
      this.letterSpacing,
      required this.icon});

  // bool isEmailValid(String email) {
  //   String pattern =
  //       '^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\$';
  //   RegExp regex = new RegExp(pattern);
  //   return regex.hasMatch(email);
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: letterSpacing,
      ),
      decoration: InputDecoration(
        labelText: labelText, alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(10),
        prefixIcon: Icon(
          icon,
          size: 20,
          // color: Colors.blue,
        ),
        // hintStyle: GoogleFonts.poppins(fontSize: 15, letterSpacing: 1),
      ),
    );
  }
}
