import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Profile/userProfile.dart';
import 'package:e_voting/Screens/Voting/Reports.dart';
import 'package:e_voting/Screens/Widgets/Components/navBar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      Dashboard(),
      ElectionResultPage(),
      UserProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      MyNavBarItem(iconData: Icons.how_to_vote_sharp, title: 'Dashboard'),
      MyNavBarItem(iconData: Icons.bar_chart, title: 'Reports'),
      MyNavBarItem(iconData: Icons.person, title: 'Profile'),
    ];
  }
}
