import 'package:e_voting/Views/Widgets/Auth/textfield.dart';
import 'package:e_voting/Views/Widgets/myButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back_ios,
                        size: 20, color: Colors.black),
                  )),
              SizedBox(height: 20),
              Text(
                'Create New Password',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 50.h,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/reset.jpg',
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(height: 40),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        labelText: 'New Password',
                        icon: Icons.password,
                        hidebtn: Icons.visibility_off,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AuthTextField(
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        labelText: 'Confirm New Password',
                        icon: Icons.lock_reset,
                        hidebtn: Icons.visibility_off,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        text: 'Submit',
                        width: 40.w,
                      )
                    ],
                  )),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
