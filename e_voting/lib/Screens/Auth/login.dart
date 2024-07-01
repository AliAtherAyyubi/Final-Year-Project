import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Screens/Auth/authScreen.dart';
import 'package:e_voting/Screens/Auth/forgotPass.dart';
import 'package:e_voting/Screens/Auth/registerPage.dart';
import 'package:e_voting/Screens/Auth/welcome.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Owner/ownerPage.dart';
import 'package:e_voting/Screens/Owner/ownerScreen.dart';
import 'package:e_voting/Screens/Widgets/Components/authAppBar.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Services/regExp.dart';
import 'package:e_voting/Services/textControl.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingController cnic = TextEditingController();
  var email = TextController().email;
  var password = TextController().password;

  // Validation class //
  Validation valid = Validation();
  bool loading = false;
  // Sign in function from userController //
  void Signin() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setState(() {
        loading = true;
      });
      await UserController().Signin(email.text, password.text);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50), // Set the desired height here
              child: AuthAppBar(
                title: 'Log In',
                actionTxt: 'Sign Up',
                actionBtn: () =>
                    Get.to(RegisterPage(), transition: Transition.rightToLeft),
              )),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   margin: EdgeInsets.only(top: Applayout.getheight(20)),
                //   child: Text(
                //     ' Welcome to WeVote\n Login to your account ',
                //     style: GoogleFonts.poppins(
                //         fontSize: 25,
                //         fontWeight: FontWeight.bold,
                //         color: AppStyle.textClr),
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  width: 40.w,
                  child: Image.asset(
                    'assets/logo/logo.png',
                    color: AppStyle.iconClr,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                // User fields //
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                      key: _formKey,
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthTextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            labelText: 'Email',
                            icon: Icons.email,
                            validator: (value) {
                              return valid.isValidEmail(value);
                            },
                          ),
                          AuthTextField(
                            controller: password,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            labelText: 'Password',
                            icon: Icons.password,
                            maxline: 1,
                            hidebtn: Icons.visibility_off,
                            suffixicon: Icons.visibility_off,
                            validator: (value) {
                              if (value == null) return 'Enter your password!';
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ////// Login Button ///////
                          Align(
                              alignment: Alignment.center,
                              child: MyButton(
                                text: 'Login',
                                width: 100.w,
                                loading: loading,
                                onPress: Signin,
                              )),
                        ],
                      )),
                ),
                SizedBox(height: 40),

                /// forgot password //
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          loading = false;
                        });
                        Get.to(() => ForgotPasswordPage(),
                            transition: Transition.rightToLeft);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
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
                        setState(() {
                          loading = false;
                        });
                        Get.to(RegisterPage(),
                            duration: Duration(milliseconds: 500),
                            transition: Transition.rightToLeft);
                      },
                      child: Text('Sign up',
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              color: AppStyle.textClr,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
