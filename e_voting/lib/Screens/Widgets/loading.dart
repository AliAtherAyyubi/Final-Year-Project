import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final Color? color;
  Loading({this.color = Colors.white});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
