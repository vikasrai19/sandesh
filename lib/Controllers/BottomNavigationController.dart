import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sandesh/Views/MessageCheckerPage.dart';
import 'package:sandesh/Views/ProfilePage.dart';
import 'package:sandesh/Views/StatusPage.dart';

class BottomNavigationController extends GetxController {
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Status"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  List<Widget> bottomNavigationWidgtes = [
    MessageCheckerPage(),
    StatusPage(),
    ProfilePage()
  ];

  setCurrentIndex(int val) {
    currentIndex = val;
    update();
  }
}
