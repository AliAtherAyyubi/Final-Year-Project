import 'package:e_voting/Views/Widgets/homepage/Voting/voteLabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:getwidget/getwidget.dart';

class CandidateProfile extends StatelessWidget {
  const CandidateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //      Clipper ///
                ClipPath(
                  clipper: BottomOvalArcClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 172, 246, 212),
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.black)
                        ]),
                    height: 280,
                    width: double.infinity,
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 20,
                  child: VoteLabel(
                    voteName: 'Vote for Student Representatives',
                  ),
                ),

                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 160),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.green,
                              blurRadius: 2,
                              spreadRadius: 2)
                        ]),
                    child: const GFAvatar(
                      radius: 90,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BottomOvalArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final arcHeight = size.height * 0.25; // Adjust arc height as needed
    final path = Path();
    path.moveTo(0.0, size.height);
    path.lineTo(0.0, arcHeight);
    path.quadraticBezierTo(size.width / 2, arcHeight, size.width, arcHeight);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
