import 'package:e_voting/Views/Widgets/homepage/Voting/voteLabel.dart';
import 'package:flutter/material.dart';

class FaceRecognition1 extends StatefulWidget {
  const FaceRecognition1({super.key});

  @override
  State<FaceRecognition1> createState() => FaceRecognition1State();
}

class FaceRecognition1State extends State<FaceRecognition1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 23),
        child: Column(
          children: [
            Row(
              children: [
                VoteLabel(
                  voteName: "Vote for student representative",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
