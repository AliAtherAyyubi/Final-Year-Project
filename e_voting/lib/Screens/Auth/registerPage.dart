import 'dart:convert';

import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Screens/Auth/authScreen.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/welcome.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Services/textControl.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  var Email = TextController().email;
  var password = TextController().password;
  // var confirmPassword = TextController().confirmPassword;
  String? role;

  Validation validate = Validation();
  UserController user = UserController();
  bool loading = false;

  //________________________________________________
  //najam code here __________________________
  // bool _isvalid = false;
  // String message = "";

  // bool isvalidemail(String email) {
  //   final emailRegex =
  //       RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  //   return emailRegex.hasMatch(email);
  // }

  // Future<bool> checkDomainexists(String email) async {
  //   final domain = email.split('@').last;

  //   final dns = DnsOverHttps.google();

  //   try {
  //     final result = await dns.lookup(domain);
  //     return result.isNotEmpty;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> validateemail(String email) async {
  //   final apikey = '46ec30f4b4bb4bc2a73610696adeaa37';
  //   final url =
  //       'https://api.zerobounce.net/v2/validate?api_key=$apikey&email=$Email';

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       return data['status'] == 'valid';
  //     } else {
  //       throw Exception('Failed to validate email');
  //     }
  //   } catch (e) {
  //     print('Error validating email: $e');
  //     return false;
  //   }
  // }

  // Future<void> Validate() async {
  //   final email = Email.text;

  //   if (!isvalidemail(email)) {
  //     setState(() {
  //       _isvalid = false;
  //       message = 'Invalid email syntax';
  //     });
  //     return;
  //   }
  //   final domainexists = await checkDomainexists(email);
  //   if (!domainexists) {
  //     setState(() {
  //       _isvalid = false;
  //       message = 'Email domain does not exist';
  //     });
  //     return;
  //   }
  //   final emailExists = await validateemail(email);

  //   if (!emailExists) {
  //     setState(() {
  //       _isvalid = false;
  //       message = 'Email does not exist';
  //     });
  //     return;
  //   }
  //   setState(() {
  //     _isvalid = true;
  //     message = 'Email is valid';
  //   });
  // }

  // User Register Method //
  void Register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await user.RegisterUser(
          username.text, cnic.text, role, email.text, password.text);
      String? res = await user.RegisterUser(
          username.text, cnic.text, role, Email.text, password.text);

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                            keyboardType: TextInputType.name,
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
                            inputFormat: validate.cnicFormatter,
                            validator: (value) => validate.isValidCnic(value),
                          ),
                          AuthTextField(
                            controller: Email,
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
                            validator: (value) =>
                                validate.isValidPassword(value),
                          ),
                          DropDownItems(
                            onRoleChanged: (value) {
                              setState(() {
                                role = value;
                              });
                            },
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
                                text: 'Register (Sign Up)',
                                width: 100.w,
                                loading: loading,
                                onPress: Register,
                              )),
                        ],
                      )),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
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
                          Get.off(LoginPage(),
                              transition: Transition.leftToRight,
                              duration: Duration(milliseconds: 600));
                        },
                        child: Text('Sign in',
                            style: GoogleFonts.poppins(
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
        ));
  }
}
