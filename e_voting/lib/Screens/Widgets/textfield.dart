import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType keyboardType;
  bool obscureText;
  final String labelText;
  // final double fontSize;
  // final FontWeight fontWeight;
  // final double? letterSpacing;
  final IconData? icon;
  IconData? hidebtn;
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
      // this.letterSpacing,
      this.hidebtn,
      this.icon});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  // bool isEmailValid(String email) {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          // letterSpacing: letterSpacing,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hoverColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(widget.icon),
                iconSize: 20,
                splashRadius: 20,
                padding: EdgeInsets.only(right: 15, left: 15),
                color: AppStyle.primaryColor),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  if (widget.hidebtn == Icons.visibility_off) {
                    widget.hidebtn = Icons.visibility;
                    widget.obscureText = false;
                  } else {
                    widget.hidebtn = Icons.visibility_off;
                    widget.obscureText = true;
                  }
                });
              },
              icon: Icon(widget.hidebtn),
              iconSize: 20,
              splashRadius: 20,
              padding: EdgeInsets.only(right: 10),
              color: Colors.grey,
            )
            // hintStyle: GoogleFonts.poppins(fontSize: 15, letterSpacing: 1),
            ),
      ),
    );
  }
}
