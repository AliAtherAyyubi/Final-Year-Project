import 'package:e_voting/Screens/Widgets/Voting/voteLabel.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Applayout.getWidth(20),
            vertical: Applayout.getheight(10)),
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              VoteLabel(
                voteName: "Receipt",
                alignment: Alignment.center,
              ),
              Positioned(
                top: 10.0,
                child: Container(
                  height: Applayout.getheight(500),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 19,
                          spreadRadius: 7,
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
