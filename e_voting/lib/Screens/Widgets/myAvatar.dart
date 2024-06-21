import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAvatar extends StatelessWidget {
  final String? imageUrl;
  double? radius;
  double? elevation;
  MyAvatar({required this.imageUrl, required this.radius, this.elevation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
            color: Color.fromARGB(255, 14, 158, 19),
            blurRadius: 2,
            spreadRadius: 2)
      ]),
      child: CircularProfileAvatar(
        imageUrl ??
            "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
        radius: radius ?? 15.w,
        elevation: elevation ?? 0,
      ),
    );
  }
}
