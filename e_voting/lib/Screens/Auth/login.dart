import 'package:e_voting/Screens/Auth/forgotPass.dart';
import 'package:e_voting/Screens/Auth/registerPage.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/appBar.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController cnic = TextEditingController();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  // TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Applayout.getWidth(13.0)),
                bottomRight: Radius.circular(Applayout.getWidth(13.0))),
            gradient: AppStyle.Gradientcolor,
          ),
        ),
        title: Text(
          "E-Voting",
          style: AppStyle.headstyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Welcome to E-voting\n Login to your account ',
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppStyle.primaryColor),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 20.w,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          labelText: 'Email',
                          icon: Icons.alternate_email,
                        ),
                        AuthTextField(
                          controller: password,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          labelText: 'Password',
                          icon: Icons.password,
                          hidebtn: Icons.visibility_off,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ////// Login Button ///////
                        Align(
                            alignment: Alignment.center,
                            child: MyButton(
                              text: 'Login',
                              width: 100.w,
                              onPress: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard()));
                              },
                            )),
                      ],
                    )),
              ),
              SizedBox(height: 10),

              /// forgot password //
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ForgotPasswordPage(),
                              type: PageTransitionType.fade));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              //            Last Line of Login Page //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',
                      style: GoogleFonts.poppins(fontSize: 15)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: RegisterPage(),
                              type: PageTransitionType.rightToLeft));
                    },
                    child: Text('Sign up',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: AppStyle.primaryColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
