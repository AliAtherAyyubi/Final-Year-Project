import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  get iscolor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Applayout.getWidth(360.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                progressbarpart(
                  con_num: 1,
                  txt1: "Choose",
                  txt2: "Condidate",
                ),
                Expanded(
                    child: Stack(children: [
                  SizedBox(
                    height: Applayout.getheight(30),
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(
                              (constraints.constrainWidth() / 7).floor(),
                              (index) => Text(
                                    "-",
                                    style: TextStyle(color: Colors.red),
                                  )),
                        );
                      },
                    ),
                  ),
                ])),
                progressbarpart(
                  con_num: 2,
                  txt1: "ID",
                  txt2: "Verification",
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class progressbarpart extends StatelessWidget {
  final String txt1, txt2;
  final int con_num;
  const progressbarpart({
    super.key,
    required this.txt1,
    required this.txt2,
    required this.con_num,
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
            color: Colors.red,
          ),
          child: Center(
              child: Text(
            con_num.toString(),
            style: GoogleFonts.poppins(
              fontSize: 10,
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
