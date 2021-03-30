import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sandesh/Views/ChatPage.dart';
import 'package:sandesh/Views/ProfilePage.dart';
import 'package:sandesh/Views/StatusPage.dart';

class HomePageController extends GetxController {
  int currentIndex = 0;

  List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
        icon: new Icon(Icons.home), tooltip: "Home", label: "Home"),
    BottomNavigationBarItem(
      icon: new Icon(Icons.camera),
      tooltip: "Status",
      label: "Status",
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.person),
      tooltip: "Profile",
      label: "Profile",
    ),
  ];

  final List<Widget> children = [
    ChatPage(),
    StatusPage(),
    ProfilePage(),
  ];

  void onTabTapped(int index) {
    currentIndex = index;
    update();
  }
}
