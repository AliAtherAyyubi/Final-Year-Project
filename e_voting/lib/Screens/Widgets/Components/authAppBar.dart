import 'package:e_voting/Screens/Auth/registerPage.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthAppBar extends StatelessWidget {
  String title;
  String actionTxt;
  Function()? actionBtn;
  //
  AuthAppBar(
      {super.key,
      required this.title,
      required this.actionTxt,
      this.actionBtn});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      // leading: GestureDetector(
      //   onTap: () {
      //     Get.back();
      //   },
      //   child: const Icon(
      //     Icons.arrow_back_ios,
      //     color: AppStyle.textClr,
      //     size: 25,
      //   ),
      // ),
      title: Text(
        title,
        style: GoogleFonts.inter(
            fontSize: 28, fontWeight: FontWeight.w600, color: AppStyle.textClr),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.0), // Add padding for spacing
          child: GestureDetector(
            onTap: actionBtn,
            child: Center(
              child: Text(
                actionTxt,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppStyle.textClr),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
