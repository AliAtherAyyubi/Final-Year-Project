import 'package:e_voting/Views/Widgets/Auth/textfield.dart';
import 'package:e_voting/Views/Widgets/Custom/myButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  )),
              SizedBox(height: 20),
              Text(
                'Forgot Password?',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 150,
                child: Image.asset(
                  'assets/images/forgotpassword.png',
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'To reset your password, please enter your email address below. We will send you a link to reset your password.',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          labelText: 'Enter Your Email',
                          icon: Icons.alternate_email),
                      SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        text: 'Send',
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
