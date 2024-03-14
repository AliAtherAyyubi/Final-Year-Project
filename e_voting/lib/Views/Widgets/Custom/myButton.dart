import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyButton extends StatelessWidget {
  // const MyButton({super.key});

  final String text;
  double? width;
  // Widget? page = Container();
  // void trigger(){}

  MyButton({required this.text, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(top: 10),
        width: width,
        height: 50,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.greenAccent,
        //           blurRadius: 10,
        //           spreadRadius: 4,
        //           offset: Offset(0, 5))
        //     ]),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => page));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff2AAA8A),
            elevation: 10,
            shadowColor: Colors.greenAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
                fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
        ));
  }
}
