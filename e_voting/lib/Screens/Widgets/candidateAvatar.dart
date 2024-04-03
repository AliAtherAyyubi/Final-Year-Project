import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Screens/Widgets/myAvatar.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CandidateAvatar extends StatelessWidget {
  // const MyProfileAvatar({super.key});

  final String image;
  final double fontsize;
  final String? name;
  double radius;

  CandidateAvatar(
      {this.name,
      this.image = '',
      this.radius = 50,
      super.key,
      this.fontsize = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(10),
      // color: Colors.amber,
      child: Column(
        children: [
          MyAvatar(radius: radius, image: image),
          gap(
            Height: Applayout.getheight(10),
          ),
          Container(
            width: Applayout.getWidth(100),
            child: Text(
              name!,
              style: GoogleFonts.inter(
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
