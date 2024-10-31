import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:e_voting/utils/Appstyles.dart';

class CustomNavBar extends StatefulWidget {
  final List<Widget> screens;
  final List<PersistentBottomNavBarItem> items;
  final int initialIndex;

  CustomNavBar({
    required this.screens,
    required this.items,
    this.initialIndex = 0,
  });

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: widget.screens,
      items: widget.items,
      confineInSafeArea: true,
      navBarHeight: 60,
      backgroundColor: Colors.black,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        // border: Border(
        //   top: BorderSide(
        //     color: Colors.grey,
        //     width: 1,
        //   ),
        // ),
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
      navBarStyle: NavBarStyle.style6,
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
    iconSize: 30,
    title: title,
    textStyle: GoogleFonts.inter(fontSize: 10),
    activeColorPrimary: Colors.white,
    inactiveColorPrimary: Colors.grey,
  );
}
