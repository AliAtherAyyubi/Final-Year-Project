import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CandidateCard extends StatelessWidget {
  // const CandidateCard({super.key});

  final String name;
  final String description;

  CandidateCard({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return //// Candidate Card Section ///
        ///
        Container(
      margin: EdgeInsets.only(bottom: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 10),
                color: Color.fromARGB(255, 110, 215, 166))
          ]),

      /// GF card //
      child: GFCard(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color.fromARGB(255, 170, 251, 213),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.only(bottom: 15),
        title: GFListTile(
          //// Avatar ///
          avatar: Container(
            margin: EdgeInsets.only(right: 20),
            decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(color: Colors.green, blurRadius: 2, spreadRadius: 2)
            ]),
            child: const GFAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpg'),
              radius: 50,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              name,
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          subTitle: Text(
            description,
            style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        ),

        // Buttons
        buttonBar: GFButtonBar(
          //  padding: EdgeInsets.only(bottom: 10),
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Container(
              height: 55,
              width: 40.w,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => page));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  'VIEW PROFILE',
                  style: GoogleFonts.inter(
                      color: Color(0xff2AAA8A),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 55,
              width: 30.w,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => page));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2AAA8A),
                  shadowColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  'VOTE',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
