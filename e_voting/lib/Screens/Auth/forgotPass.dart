import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/resetPassword.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: ScreenTitle(title: '')),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Applayout.getheight(16),
              horizontal: Applayout.getWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                          icon: Icons.email,
                          validator: (value) =>
                              Validation().isValidEmail(value),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyButton(
                          text: 'Send',
                          width: 100.w,
                          loading: loading,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              await UserController()
                                  .sendPasswordResetEmail(email.text);

                              setState(() {
                                loading = false;
                              });
                              // Get.back();
                            }
                          },
                        )
                      ],
                    )),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
