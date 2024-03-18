import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class MyAvatar extends StatelessWidget {
  final String? image;
  double radius;
  MyAvatar({this.image, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(color: Colors.green, blurRadius: 2, spreadRadius: 2)
      ]),
      child: GFAvatar(
        radius: 90,
        backgroundImage: AssetImage('$image'),
      ),
    );
  }
}
