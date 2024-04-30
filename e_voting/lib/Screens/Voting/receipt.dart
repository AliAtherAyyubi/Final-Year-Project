import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dotted_line/dotted_line.dart';

class ReceiptScreen extends StatelessWidget {
  // const ReceiptScreen({super.key});

  String election = '2024 University UIX Elections';
  String address = 'Model Town, Lahore';
  String date = DateTime.now().toString();
  String student = 'Ali Ather';
  String ID = '123456';
  String voteName = 'Student Representative';
  String reference = 'A23BEDD2';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: ScreenTitle(
              title: 'Receipt',
            )),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: Applayout.getWidth(20),
            //   ),
            //   child: VoteLabel(
            //     voteName: 'Receipt',
            //     alignment: Alignment.center,
            //   ),
            // ),
            SizedBox(
              height: 4.h,
            ),

            /// card Receipt //
            Expanded(
              // flex: 13,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 20,
                    child: Container(
                      width: 85.w,
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 10,
                              spreadRadius: 5,
                              // offset: Offset(5, 10)
                            )
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            election,
                            style: AppStyle.textStyleB4.copyWith(
                              fontSize: 18.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            address,
                            style: AppStyle.textStyleB4
                                .copyWith(fontSize: 17.sp, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: 80.w,
                            lineThickness: 2,
                            dashLength: 10,
                            dashColor: AppStyle.primaryColor,
                            dashGapLength: 15.0,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          receiptDetails(label: 'Date', data: date),
                          receiptDetails(label: 'Student', data: student),
                          receiptDetails(label: 'ID', data: ID),
                          receiptDetails(label: 'Voted For', data: voteName),
                          receiptDetails(
                              label: 'Reference Number', data: reference),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      // alignment: Alignment.center,
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppStyle.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.shade100,
                              blurRadius: 5,
                              spreadRadius: 5,
                            ),
                          ]),
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: Colors.white,
                        size: 4.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MyButton(
              text: 'BACK TO HOME SCREEN',
              width: 90.w,
              elevation: 10,
              onPress: () {
                Get.to(() => Dashboard(),
                    transition: Transition.leftToRightWithFade);
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class receiptDetails extends StatelessWidget {
  // const receiptDetails({super.key});
  String label;
  String data;
  receiptDetails({required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Text(
            label,
            style: AppStyle.textStyleB4
                .copyWith(fontSize: 16.sp, color: Colors.grey),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.topRight,
            child: Text(
              data,
              style: AppStyle.textStyleB4.copyWith(
                fontSize: 16.sp,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
