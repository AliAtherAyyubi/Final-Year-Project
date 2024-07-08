import 'dart:convert';

import 'package:e_voting/Controllers/userController.dart';
import 'package:e_voting/Screens/Auth/authScreen.dart';
import 'package:e_voting/Screens/Auth/login.dart';
import 'package:e_voting/Screens/Auth/welcome.dart';
import 'package:e_voting/Screens/Widgets/Components/authAppBar.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/logo.dart';
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
  // var cnic = TextController().cnic;
  var username = TextController().name;
  var Email = TextController().email;
  var password = TextController().password;
  // var confirmPassword = TextController().confirmPassword;
  late String role;

  Validation validate = Validation();
  UserController user = UserController();
  bool loading = false;

  // User Register Method //
  void Register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await user.RegisterUser(username.text, role, Email.text, password.text);

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
                preferredSize: Size.fromHeight(50),
                child: AuthAppBar(
                  title: 'Sign Up',
                  actionTxt: 'Log In',
                  actionBtn: () =>
                      Get.to(LoginPage(), transition: Transition.leftToRight),
                )),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    MyLogo(
                      logoClr: AppStyle.iconClr,
                      height: 120,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 10,
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
                              hintText: 'Full Name',
                              maxlength: 13,
                              icon: Icons.alternate_email,
                              validator: (value) => validate.isValidName(value),
                            ),
                            // AuthTextField(
                            //   controller: cnic,
                            //   keyboardType: TextInputType.number,
                            //   obscureText: false,
                            //   labelText: 'CNIC',
                            //   hintText: '35201-4565326-2',
                            //   maxlength: 15,
                            //   icon: Icons.badge,
                            //   inputFormat: validate.cnicFormatter,
                            //   validator: (value) => validate.isValidCnic(value),
                            // ),
                            AuthTextField(
                              controller: Email,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              labelText: 'Email',
                              hintText: 'john123@gmail.com',
                              icon: Icons.email,
                              validator: (value) =>
                                  validate.isValidEmail(value),
                            ),
                            AuthTextField(
                              controller: password,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: true,
                              labelText: 'Password',
                              hintText: 'Password',
                              icon: Icons.password,
                              hidebtn: Icons.visibility_off,
                              validator: (value) =>
                                  validate.isValidPassword(value),
                            ),
                            DropDown(
                              prefixIcon: Icons.person_2_rounded,
                              onRoleChanged: (value) {
                                setState(() {
                                  role = value.toString();
                                });
                              },
                              DropDownItems: const [
                                DropdownMenuItem(
                                  child: Text('Owner'),
                                  value: 'Owner',
                                ),
                                DropdownMenuItem(
                                  child: Text('Voter'),
                                  value: 'Voter',
                                ),
                              ],
                              labelText: 'Choose your role',
                              validator: (value) {
                                if (value == null) return 'choose your role!';
                                return null;
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
                              height: 30,
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
                    Center(
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
                            Get.off(
                              LoginPage(),
                              transition: Transition.leftToRight,
                            );
                          },
                          child: Text('Sign in',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: AppStyle.textClr,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
