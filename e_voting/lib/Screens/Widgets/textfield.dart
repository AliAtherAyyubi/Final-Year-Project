import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType keyboardType;
  bool obscureText;
  final String labelText;
  final String? hintText;
  final IconData? icon;
  IconData? hidebtn;
  final int? maxlength;
  final TextEditingController? controller;
  final FormFieldValidator? validator;

  AuthTextField(
      {this.controller,
      this.validator,
      required this.keyboardType,
      required this.obscureText,
      this.maxlength,
      required this.labelText,
      this.hintText,
      // required this.fontSize,
      // required this.fontWeight,
      // this.letterSpacing,
      this.hidebtn,
      this.icon});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  // FocusScopeNode _focusNode = FocusScope.of(context);

  // bool isEmailValid(String email) {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        // focusNode: _focusNode,
        validator: widget.validator,
        controller: widget.controller,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'a-z'))],
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        textAlignVertical: TextAlignVertical.center,

        cursorColor: Colors.black,
        cursorWidth: 1,
        maxLength: widget.maxlength,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          // letterSpacing: letterSpacing,
        ),

        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            hoverColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(15),
            alignLabelWithHint: true,
            hintStyle: GoogleFonts.inter(
                color: Colors.black54, fontWeight: FontWeight.w400),
            labelStyle: GoogleFonts.inter(
                color: Colors.black54, fontWeight: FontWeight.w400),
            errorStyle: GoogleFonts.inter(
              color: Colors.red,
              fontSize: 13,
            ),
            ///////// icons //////////
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

/////  Profile and Voting Text Fields ///
///
///
class VoteTextField extends StatefulWidget {
  // const VoteTextField({super.key});
  final TextInputType keyboardType;
  // bool obscureText;
  final String labelText;
  // final IconData? icon;
  // IconData? hidebtn;
  final int? maxlength;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final int? maxline;
  VoteTextField(
      {this.controller,
      this.validator,
      required this.keyboardType,
      required this.labelText,
      this.maxlength,
      this.maxline});

  @override
  State<VoteTextField> createState() => _VoteTextFieldState();
}

class _VoteTextFieldState extends State<VoteTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        // focusNode: _focusNode,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: false,
        maxLength: widget.maxlength,
        // textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          // letterSpacing: letterSpacing,
        ),
        cursorColor: Colors.black,
        cursorWidth: 1,
        maxLines: widget.maxline,
        keyboardAppearance: ThemeData.estimateBrightnessForColor(Colors.white),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          hintText: widget.labelText,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          labelText: widget.labelText,
          labelStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          hoverColor: Colors.grey[200],
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          filled: false,
          // fillColor: Colors.grey[200],
          floatingLabelBehavior: FloatingLabelBehavior.never,

          // hintStyle: GoogleFonts.poppins(fontSize: 15, letterSpacing: 1),
        ),
      ),
    );
  }
}
