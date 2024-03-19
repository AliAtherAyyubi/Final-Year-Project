import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              progressbarpart(
                txt1: "Face",
                txt2: "Recognition",
              ),
              SizedBox(
                width: 20,
              ),
              progressbarpart(
                txt1: "ID",
                txt2: "Verification",
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class progressbarpart extends StatelessWidget {
  final String txt1, txt2;
  const progressbarpart({
    super.key,
    required this.txt1,
    required this.txt2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.deepPurple,
          ),
          child: Center(
              child: Text(
            "1",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
        ),
        Text(txt1),
        Text(txt2),
      ],
    );
  }
}
