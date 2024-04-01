import 'package:e_voting/Screens/Auth/firstscreen.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/welcome.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cnic = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: FirstScreen()));
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          title: Text('Create Account',
              style: AppStyle.textStyle1.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
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
                        controller: cnic,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        labelText: 'CNIC',
                        icon: Icons.badge,
                      ),
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
                      AuthTextField(
                        controller: confirmPassword,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        labelText: 'Confirm Password',
                        icon: Icons.lock_reset,
                        hidebtn: Icons.visibility_off,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      ////// Register Button ///////
                      Align(
                          alignment: Alignment.center,
                          child: MyButton(
                            text: 'Register',
                            width: 100.w,
                            onPress: () {
                              Get.off(() => WelcomePage(),
                                  transition: Transition.fade);
                            },
                          )),
                    ],
                  )),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'By signing up, you agree to our Terms of Service and Privacy Policy',
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(height: 10),
            //            Last Line of Login Page //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: LoginPage()));
                  },
                  child: Text('Sign in',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Color(0xff2AAA8A),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
