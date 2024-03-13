import 'package:e_voting/Views/Widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  TabController? controller;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130),
            child: AppBar(
              actions: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Color(0xff2AAA8A),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ]),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.user),
                    iconSize: 22,
                    splashRadius: 20,
                    color: Colors.white,
                  ),
                )
              ],
              bottom: TabBar(
                  // tabAlignment: TabAlignment.center,
                  indicatorSize: TabBarIndicatorSize.label,
                  // indicatorWeight: 10,
                  indicatorPadding: EdgeInsets.only(bottom: 2),
                  // indicatorColor: Color(0xff2AAA8A),
                  // unselectedLabelStyle: TextStyle(color: Colors.grey),
                  isScrollable: true,
                  labelColor: Color(0xff2AAA8A),
                  unselectedLabelColor: Colors.black45,
                  indicator: UnderlineTabIndicator(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 7, color: Color(0xff2AAA8A))),
                  tabs: [
                    Tab(
                      child: Text(
                        'ONGOING ELECTIONS',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'UPCOMING ELECTIONS',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ]),
              title: Text(
                'WeVote',
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                // textAlign: TextAlign.center,
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              'Vote for \n Student Representative',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  height: 1.3,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'April 10th to 11th - 8am to 10pm',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Student representative are knows as enrolled scholars at their instituion elected to lobby',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Center(child: Text('Upcoming ...')),
            ],
          )),
    );
  }
}
