import 'package:e_voting/Views/Widgets/Auth/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_rounded,
        ),
        title: Text(
          'Create Account',
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 20.h,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 50,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthTextField(
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        labelText: 'CNIC',
                        icon: Icons.badge_outlined)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
