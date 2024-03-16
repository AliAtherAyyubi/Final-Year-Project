import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  // const BackButton({super.key});

  final IconData? icon;
  BackButton({this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(icon),
              iconSize: 20,
            )));
  }
}
