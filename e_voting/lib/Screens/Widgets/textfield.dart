import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatefulWidget {
  final TextInputType? keyboardType;
  bool? obscureText;
  final String? labelText;
  final String? hintText;
  final int? maxline;
  final IconData? icon;
  IconData? hidebtn;
  IconData? suffixicon;
  final int? maxlength;
  final bool? readOnly;
  final bool? border;
  Color? fillColor;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final MaskTextInputFormatter? inputFormat;
  final Function(String value)? onChange;
  final Function()? onTap;
  AuthTextField(
      {this.controller,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.maxlength,
      this.maxline,
      this.readOnly = false,
      this.border = false,
      this.fillColor,
      this.suffixicon,
      this.labelText,
      this.hintText,
      this.onChange,
      this.onTap,
      this.inputFormat,
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
        readOnly: widget.readOnly!,
        inputFormatters:
            widget.inputFormat != null ? [widget.inputFormat!] : null,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText!,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.black,
        cursorWidth: 1,
        maxLength: widget.maxlength,
        maxLines: widget.maxline ?? 1,
        // styles //
        style: AppStyle.textStyle4,
        onChanged: widget.onChange,
        onTap: widget.onTap,
        // Style //
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            hoverColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderSide: widget.border!
                  ? BorderSide(color: Colors.black, style: BorderStyle.solid)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: widget.fillColor ?? Colors.grey.shade200,
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.all(15),
            alignLabelWithHint: true,
            hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w400),
            labelStyle: GoogleFonts.inter(
                fontWeight: FontWeight.w500, color: Colors.grey),
            errorStyle: GoogleFonts.inter(
              color: Colors.red,
              fontSize: 13,
            ),
            ///////// icons //////////
            prefixIcon: widget.icon == null
                ? null
                : IconButton(
                    onPressed: () {},
                    icon: Icon(widget.icon),
                    iconSize: 20,
                    splashRadius: 20,
                    padding: EdgeInsets.only(right: 15, left: 15),
                    color: AppStyle.primaryColor),
            suffixIcon: widget.suffixicon == null
                ? null
                : IconButton(
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

// DropDown button //

class DropDownItems extends StatefulWidget {
  String? selectedValue;

  final ValueChanged<String?>? onRoleChanged;

  DropDownItems({super.key, this.onRoleChanged});
  @override
  State<DropDownItems> createState() => _DropDownItemsState();
}

class _DropDownItemsState extends State<DropDownItems> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        style: AppStyle.textStyle4,
        borderRadius: BorderRadius.circular(10),
        isExpanded: true,
        decoration: InputDecoration(
          enabled: true,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          // contentPadding: EdgeInsets.all(15),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   borderRadius: BorderRadius.circular(10),
          // ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),

          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: 'Choose your role',

          errorStyle: GoogleFonts.inter(
            color: Colors.red,
            fontSize: 13,
          ),
        ),
        validator: (value) => value == null ? "Please choose your role!" : null,
        dropdownColor: Colors.grey.shade100,
        value: widget.selectedValue,
        onChanged: (newValue) {
          setState(() {
            widget.selectedValue = newValue;
          });
          widget.onRoleChanged?.call(newValue);
        },
        items: const [
          DropdownMenuItem(
            child: Text('Owner'),
            value: 'Owner',
          ),
          DropdownMenuItem(
            child: Text('Candidate'),
            value: 'Candidate',
          ),
          DropdownMenuItem(
            child: Text('Voter'),
            value: 'Voter',
          ),
        ]);
  }
}

/////  Profile and Voting Text Fields ///
///
///
class FlatTextField extends StatefulWidget {
  // const VoteTextField({super.key});
  final TextInputType? keyboardType;
  // bool obscureText;
  final String? labelText;
  // final IconData? icon;
  // IconData? hidebtn;
  final bool readOnly;
  final int? maxlength;
  final MaskTextInputFormatter? inputFormatter;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final int? maxline;
  FlatTextField(
      {this.controller,
      this.validator,
      required this.keyboardType,
      required this.labelText,
      this.inputFormatter,
      this.readOnly = false,
      this.maxlength,
      this.maxline});

  @override
  State<FlatTextField> createState() => _VoteTextFieldState();
}

class _VoteTextFieldState extends State<FlatTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        // focusNode: _focusNode,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters:
            widget.inputFormatter != null ? [widget.inputFormatter!] : null,
        obscureText: false,
        readOnly: widget.readOnly,
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
