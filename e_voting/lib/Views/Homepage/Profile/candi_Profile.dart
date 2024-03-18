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
    var x = size.width;
    var y = size.height;
    var controlPoint1 = Offset(50, size.height - 100);
    var controlPoint2 = Offset(size.width - 50, size.height);
    var endPoint = Offset(x, y);

    Path path = Path();
    path.lineTo(0, 0);
    // path.lineTo(0, y);
    path.lineTo(0, size.height - 150);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    // path.lineTo(x, y + 150);
    path.lineTo(x, 0);

    // path.cubicTo(controlPoint2.dx, controlPoint2.dy, controlPoint1.dx,
    //     controlPoint1.dy, endPoint.dx, endPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
