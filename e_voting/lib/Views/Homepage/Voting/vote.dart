import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:e_voting/Views/Widgets/Custom/profileAvatart.dart';
import 'package:e_voting/Views/Widgets/homepage/Voting/Stepper.dart';
import 'package:e_voting/Views/Homepage/Voting/onGoing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VotingPage extends StatefulWidget {
  VotingPage({super.key});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  OnGoingElectionPage vote = OnGoingElectionPage();

  String voteName = 'Vote for Student Representatives';

  // List<Step> steps = [
  //   Step(title: Text(''), content: Text('')),
  //   Step(title: Text(''), content: Text('')),
  //   Step(title: Text(''), content: Text('')),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, weight: 20),
                    iconSize: 22,
                    splashRadius: 20,
                    color: Color(0xff2AAA8A),
                  ),
                  Text(
                    voteName,
                    style: GoogleFonts.inter(
                        color: Color(0xff2AAA8A),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // My Stepper //

              const VoteStepper(),

              const SizedBox(
                height: 10,
              ),
              Text(
                'Choose your preferred candidate',
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),

              //// Candidate Card Section ///
              ///
              Container(
                  width: double.infinity,
                  child: Container(
                    height: 400,
                    width: 90.w,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.green,
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ]),
                                  child: CircularProfileAvatar(
                                    'assets/images/profile.jpg',
                                    radius: 40,
                                    imageFit: BoxFit.cover,
                                    cacheImage: true,
                                    errorWidget: (context, url, error) =>
                                        Text('No Image'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ali Ather',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        // textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'I\'ll let your voice be heard and work towards the fulfillment of your needs.',
                                        style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                        // textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
