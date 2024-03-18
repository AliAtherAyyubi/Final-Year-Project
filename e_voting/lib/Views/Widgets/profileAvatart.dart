import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileAvatar extends StatelessWidget {
  // const MyProfileAvatar({super.key});

  final String? name;
  final String image;
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
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(color: Colors.green, blurRadius: 5, spreadRadius: 2)
            ]),
            child: CircularProfileAvatar(
              image,
              radius: radius,
              imageFit: BoxFit.cover,
              cacheImage: true,
              errorWidget: (context, url, error) => Text('No Image'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          name != Null
              ? Container(
                  width: 100,
                  child: Text(
                    name!,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox(
                  height: 1,
                ),
        ],
      ),
    );
  }
}
