import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Owner/ownerPage.dart';
import 'package:e_voting/Screens/Profile/userProfile.dart';
import 'package:e_voting/Screens/Voting/Reports.dart';
import 'package:e_voting/Screens/Widgets/Components/navBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OwnerMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomNavBar(
        screens: _buildScreens(),
        items: _navBarsItems(),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      OwnerMainPage(),
      Dashboard(),
      ElectionResultPage(),
      UserProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      MyNavBarItem(iconData: Icons.home_filled, title: 'Home'),
      MyNavBarItem(iconData: Icons.how_to_vote_sharp, title: 'Vote'),
      MyNavBarItem(iconData: Icons.bar_chart, title: 'Reports'),
      MyNavBarItem(iconData: Icons.person, title: 'Profile'),
    ];
  }
}
