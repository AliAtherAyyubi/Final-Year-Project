import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/welcome.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Services/textControl.dart';
import 'package:e_voting/Services/validation.dart';
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

  // TextController fields = TextController();
  var cnic = TextController().cnic;
  var username = TextController().name;
  var email = TextController().email;
  var password = TextController().password;
  // var confirmPassword = TextController().confirmPassword;

  Validation validate = Validation();
  UserController user = UserController();

  bool loading = false;
  void Register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      String? res = await user.RegisterUser(
          context, username.text, cnic.text, email.text, password.text);

      if (res == null) {
        MyAlert.Alert('Account', 'Your account is created successfully!');
        Future.delayed(
            const Duration(
              seconds: 3,
            ), () {
          Get.off(() => WelcomePage(),
              opaque: true, transition: Transition.rightToLeft);
        });
      } else {
        MyAlert.Alert('Error', res.toString());
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: ScreenTitle(
            title: 'Create Account',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 20.w,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                        controller: username,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        labelText: 'Name',
                        hintText: 'Ali Hamza',
                        maxlength: 13,
                        icon: Icons.alternate_email,
                        validator: (value) => validate.isValidName(value),
                      ),
                      AuthTextField(
                        controller: cnic,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        labelText: 'CNIC',
                        hintText: '35201-4565326-2',
                        maxlength: 15,
                        icon: Icons.badge,
                        validator: (value) => validate.isValidCnic(value),
                      ),
                      AuthTextField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        labelText: 'Email',
                        icon: Icons.email,
                        validator: (value) => validate.isValidEmail(value),
                      ),
                      AuthTextField(
                        controller: password,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        labelText: 'Password',
                        icon: Icons.password,
                        hidebtn: Icons.visibility_off,
                        validator: (value) => validate.isValidPassword(value),
                      ),
                      // AuthTextField(
                      //   controller: confirmPassword,
                      //   keyboardType: TextInputType.emailAddress,
                      //   obscureText: true,
                      //   labelText: 'Confirm Password',
                      //   icon: Icons.lock_reset,
                      //   hidebtn: Icons.visibility_off,
                      //   validator: (value) {
                      //     if (password.text != confirmPassword.text) {
                      //       return 'Password don\'t match';
                      //     }
                      //     return null;
                      //   },
                      // ),

                      const SizedBox(
                        height: 20,
                      ),
                      ////// Register Button ///////
                      Align(
                          alignment: Alignment.center,
                          child: MyButton(
                            text: 'Register',
                            width: 100.w,
                            loading: loading,
                            onPress: Register,
                          )),
                    ],
                  )),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'By signing up, you agree to our Terms of Service and Privacy Policy',
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                  textAlign: TextAlign.left,
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
      ),
    );
  }
}
