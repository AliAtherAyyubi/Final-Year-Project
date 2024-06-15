import 'dart:math';

import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  //
  final Color? logoClr;
  final double? height;
  final double? width;
  MyLogo({this.logoClr = Colors.white, this.height = 180, this.width = 300});

  //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        child: Image.asset(
          'assets/logo/logo.png',
          filterQuality: FilterQuality.high,
          color: logoClr,
        ),
      ),
    );
  }
}
