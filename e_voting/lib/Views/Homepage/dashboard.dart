import 'package:e_voting/Views/Widgets/Custom/myButton.dart';
import 'package:e_voting/Views/Widgets/Custom/profileAvatart.dart';
import 'package:e_voting/Views/Widgets/homepage/Dashboard/card.dart';
import 'package:e_voting/Views/Widgets/homepage/tabBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:card_swiper/card_swiper.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  List<String> CandidateName = [
    'Harry Brook',
    'Alice Henry',
    'William Washington',
    'Sohaib Zafar',
    'Syed Ali Raza',
    'Asgar Zaidi'
  ];

  TabController? controller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: AppBar(
              actions: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Color(0xff2AAA8A),
                      // borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.shade500,
                            blurRadius: 5,
                            spreadRadius: 2)
                      ]),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.user),
                    iconSize: 22,
                    alignment: Alignment.center,
                    splashRadius: 20,
                    color: Colors.white,
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: MyTabBar(
                  text1: 'ONGOING ELECTIONS',
                  text2: 'UPCOMING ELECTIONS',
                  controller: controller,
                ),
              ),
              title: Text(
                'WeVote',
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                // textAlign: TextAlign.center,
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),

          ///////////////////////
          body: TabBarView(
            children: [
              /// Tab 1 //
              SingleChildScrollView(
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
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
              ),

              //    Tab No.2 ///
              Center(child: Text('Upcoming ...')),
            ],
          )),
    );
  }
}
