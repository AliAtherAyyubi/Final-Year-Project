import 'package:e_voting/utils/Applayout.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UpcomingElection extends StatefulWidget {
  const UpcomingElection({super.key});

  @override
  State<UpcomingElection> createState() => _UpcomingElectionState();
}

class _UpcomingElectionState extends State<UpcomingElection> {
  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.vertical, children: [
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: Applayout.getheight(20)),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            //        2nd Section     //
            Container(
                // width: 75.w,
                width: Applayout.getWidth(300),
                height: Applayout.getheight(110),
                // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        left: BorderSide(
                            color: AppStyle.primaryColor, width: 15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      'Vote for University Counsil',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  subtitle: Text(
                    'June 17th - 8am to 10pm',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    // textAlign: TextAlign.center,
                  ),
                  trailing: PopupMenuButton(
                      offset: Offset(5, 0),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(child: Text('item1')),
                          PopupMenuItem(child: Text('item2')),
                        ];
                      }),
                )),

            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    ]);
  }
}
