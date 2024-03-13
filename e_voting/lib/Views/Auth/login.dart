import 'package:e_voting/Views/Auth/forgotPass.dart';
import 'package:e_voting/Views/Auth/registerPage.dart';
import 'package:e_voting/Views/Widgets/Auth/textfield.dart';
import 'package:e_voting/Views/Widgets/Custom/appBar.dart';
import 'package:e_voting/Views/Widgets/Custom/myButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppBar(
          logoname: 'E-voting',
        ),
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2AAA8A)),
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

                        ////// Login Button ///////
                        Align(
                            alignment: Alignment.center,
                            child: MyButton(
                              text: 'Login',
                              width: 40.w,
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  print('Correct values');
                                }
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
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text('Sign up',
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
