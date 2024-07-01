import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:e_voting/utils/Appstyles.dart';

class CustomNavBar extends StatefulWidget {
  final List<Widget> screens;
  final List<PersistentBottomNavBarItem> items;
  final int initialIndex;
  final Color backgroundColor;
  final bool handleAndroidBackButtonPress;
  final bool resizeToAvoidBottomInset;
  final bool stateManagement;
  final bool hideNavigationBarWhenKeyboardShows;
  final NavBarStyle navBarStyle;

  CustomNavBar({
    required this.screens,
    required this.items,
    this.initialIndex = 0,
    this.backgroundColor = Colors.white,
    this.handleAndroidBackButtonPress = true,
    this.resizeToAvoidBottomInset = true,
    this.stateManagement = true,
    this.hideNavigationBarWhenKeyboardShows = true,
    this.navBarStyle = NavBarStyle.style13,
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
      backgroundColor: widget.backgroundColor,
      handleAndroidBackButtonPress: widget.handleAndroidBackButtonPress,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      stateManagement: widget.stateManagement,
      hideNavigationBarWhenKeyboardShows:
          widget.hideNavigationBarWhenKeyboardShows,
      decoration: const NavBarDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 1,
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
      navBarStyle: widget.navBarStyle,
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
