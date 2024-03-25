import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/elogo.png'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF36bb75).withOpacity(0.5),
                Color(0xFF29a0b0)..withOpacity(0.5)
              ],
              begin: Alignment.topLeft, // Where the gradient starts
              end: Alignment.bottomRight, // Where the gradient ends
            ),
          ),
        ),
      ),
    );
  }
}
