import 'package:e_voting/Screens/Homepage/dashboard.dart';
import 'package:e_voting/Screens/Owner/ownerPage.dart';
import 'package:e_voting/Screens/Profile/userProfile.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OwnerMainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<OwnerMainScreen> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [OwnerMainPage(), Dashboard(), UserProfilePage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      MyNavBarItem(iconData: Icons.home_filled, title: 'Home'),
      MyNavBarItem(iconData: Icons.how_to_vote_sharp, title: 'Voting'),
      MyNavBarItem(iconData: Icons.person, title: 'Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move the nav bar up when the keyboard appears.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'true' to hide the nav bar when the keyboard appears.
          // navBarHeight: 70,
          decoration: const NavBarDecoration(
            // borderRadius: BorderRadius.circular(10.0),
            border: Border(
              top: BorderSide(
                color: Colors.grey, // Change this to your desired color
                width: 1, // Change this to your desired width
              ),
            ),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style13, // Choose the nav bar style with this property.
        ),
      ),
    );
  }
}

PersistentBottomNavBarItem MyNavBarItem({
  required IconData iconData,
  required String title,
}) {
  return PersistentBottomNavBarItem(
    icon: Icon(
      iconData,
    ),
    iconSize: 35,
    title: title,
    textStyle: AppStyle().h3,
    activeColorPrimary: Colors.green,
    inactiveColorPrimary: Colors.grey,
  );
}
