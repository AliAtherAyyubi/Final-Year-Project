import 'package:e_voting/Views/Widgets/Custom/myButton.dart';
import 'package:e_voting/Views/Widgets/Custom/profileAvatart.dart';
import 'package:e_voting/Views/Widgets/homepage/Dashboard/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnGoingElectionPage extends StatelessWidget {
  OnGoingElectionPage({super.key});
  List<String> CandidateName = [
    'Harry Brook',
    'Alice Henry',
    'William Washington',
    'Sohaib Zafar',
    'Syed Ali Raza',
    'Asgar Zaidi'
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            // Card Section //
            Container(
              height: 250,
              // padding: EdgeInsets.all(20),
              // color: Colors.amber,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return VoteCard(
                      title: 'Student Representative',
                      time: 'April 10th to 11th - 8am to 10pm',
                      description:
                          'Student representatives are known as enrolled scholars at their instituion elected to lobby for student\'s rights and represent the point of view of their peers.');
                },
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            /// Candidates Section //

            Text(
              '6 Candidates',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            // Candidates List>>>>>>
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: 400,
              height: 180,
              child: ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MyProfileAvatar(
                      name: CandidateName[index],
                      image: 'assets/images/profile.jpg',
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: MyButton(
                text: 'VOTE NOW',
                width: 100.w,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
