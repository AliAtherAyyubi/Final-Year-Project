import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileAvatar extends StatelessWidget {
  // const MyProfileAvatar({super.key});

  final String image;
  final String? name;
  double radius;

  MyProfileAvatar({this.name, this.image = '', this.radius = 50, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(10),
      // color: Colors.amber,
      child: Column(
        children: [
          MyAvatar(radius: radius, image: image),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 100,
            child: Text(
              name!,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }
}
