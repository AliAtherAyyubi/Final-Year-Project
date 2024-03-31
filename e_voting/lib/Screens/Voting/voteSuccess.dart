import 'package:e_voting/Screens/Voting/receipt.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoteSuccess extends StatelessWidget {
  const VoteSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Applayout.getWidth(10),
                vertical: Applayout.getheight(10)),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    gap(
                      Height: Applayout.getheight(70),
                    ),
                    Textwidget(
                      text: "Thank You",
                    ),
                    Textwidget(text: "Your Vote has"),
                    Textwidget(text: "Submittted"),
                    Textwidget(text: "Successfully."),
                    gap(
                      Height: Applayout.getheight(30),
                    ),
                    Image(image: AssetImage("assets/images/tic2.png")),
                    gap(
                      Height: Applayout.getheight(36),
                    ),
                    Text(
                      "The receipt is send to your",
                      style: AppStyle.textStyle4,
                    ),
                    Text(
                      "email address",
                      style: AppStyle.textStyle4,
                    ),
                    gap(
                      Height: Applayout.getheight(45),
                    ),
                    MyButton(text: "BACK YO HOME SCREEN"),
                    gap(
                      Height: Applayout.getheight(15),
                    ),
                    MyButton(
                      onPress: () {
                        Get.to(() => ReceiptScreen());
                      },
                      text: "RECEIPT",
                      width: 250,
                      textClr: AppStyle.primaryColor,
                      backClr: Colors.white,
                    ),
                  ],
                ),
              ),
            )));
  }
}

class Textwidget extends StatelessWidget {
  final String text;
  const Textwidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyle.textStyle2,
    );
  }
}
