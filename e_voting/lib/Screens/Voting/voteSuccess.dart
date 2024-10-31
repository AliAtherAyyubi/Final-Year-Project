import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Homepage/mainDasboard.dart';
import 'package:e_voting/Screens/Admin/AdminNavbar.dart';
import 'package:e_voting/Screens/Voting/receipt.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:e_voting/utils/Gap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VoteSuccess extends StatelessWidget {
  const VoteSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                gap(
                  Height: Applayout.getheight(70),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: Image.asset(
                //     "assets/images/paper.jpg",
                //   ),
                // ),
                SizedBox(
                  width: 60.w,
                  child: Text(
                    'Thank you!\n Your vote has submitted successfully.',
                    style: AppStyle.textStyle2.copyWith(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: Image.asset(
                  "assets/images/tic2.png",
                )),
                // SizedBox(
                //   width: 60.w,
                //   child: Text(
                //     "The receipt is send to your email address.",
                //     style: AppStyle.textStyle4
                //         .copyWith(fontWeight: FontWeight.w500),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                gap(
                  Height: Applayout.getheight(45),
                ),
                MyButton(
                  text: "RECEIPT",
                  width: 90.w,
                  onPress: () {
                    Get.to(() => ReceiptScreen());
                  },
                ),
                gap(
                  Height: Applayout.getheight(10),
                ),
                MyTextButton(
                  onPress: () async {
                    bool isOwner = await UserLocalData().isOwner();
                    Get.to(
                        () => isOwner ? OwnerMainScreen() : DashboardScreen(),
                        transition: Transition.rightToLeft);
                  },
                  text: "BACK TO HOME SCREEN",
                  textClr: AppStyle.textClr,
                  elevation: 0,
                  border: false,
                ),
              ],
            ),
          )),
    );
  }
}
