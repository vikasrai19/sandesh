import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sandesh/Views/ChatPage.dart';
import 'package:sandesh/Views/ProfilePage.dart';
import 'package:sandesh/Views/StatusPage.dart';
import 'package:sandesh/helper/FirebaseDatabase.dart';

import 'UserController.dart';

class HomePageController extends GetxController {
  TextEditingController chatSearchController = new TextEditingController();
  int currentIndex = 0;
  QuerySnapshot chatList;

  @override
  void onInit() {
    getChats();
    super.onInit();
  }

  void getChats() async {
    UserController userController = Get.find();
    print("[PHONE NO]: " + userController.phoneNo.toString());
    if (userController.phoneNo != null &&
        userController.phoneNo.length == 10) {
      FirebaseDatabase()
          .getUserChatRooms(phoneNo: userController.phoneNo.toString()).then((value){
            print("[GETUSERCHATROOMS VALUE]: " + value.toString());
          });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        FirebaseDatabase()
            .getUserChatRooms(phoneNo: userController.phoneNo.toString()).then((value){
              print("[GETUSERCHATROOMS VALUE]: " + value.toString());
            });
      });
    }

    if(chatList != null){
      print("[CHATLIST]: " + chatList.toString());
    }
  }

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
