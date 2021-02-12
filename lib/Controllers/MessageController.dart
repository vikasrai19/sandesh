import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sandesh/Controllers/ContactListController.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';
import 'package:sandesh/Models/User.dart';

import 'HomePageController.dart';

class MessageController extends GetxController {
  // final HomePageController homePageController = Get.find();
  List newList = Get.find<ContactListController>().contactList;
  final userModel = UserModel();
  final TextEditingController msgController = TextEditingController();
  Stream<QuerySnapshot> lastMessageSnapshot;
  Stream<QuerySnapshot> chatMessageSnapshot;
  String phoneNo;
  ScrollController msgScrollController = new ScrollController();

  @override
  void onInit() {
    scrollControllerListener();
    fetchLastMessages();
    super.onInit();
  }

  // Listen for scroll controller
  scrollControllerListener() {
    msgScrollController.addListener(() {
      print(msgScrollController.offset.toString());
    });
  }

  // move to end of the list
  scrollToEnd() {
    msgScrollController.animateTo(msgScrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  fetchLastMessages() {
    // print("User phone no in usee model ${userModel.phoneNo}");
    String phoneNo;
    HelperFunction.getUserPhoneNumber().then((value) {
      phoneNo = value;
      DatabaseMethods().getLastMessage(phone: phoneNo).then((value) {
        lastMessageSnapshot = value;
        print("Last Message snapshot value " + lastMessageSnapshot.toString());
        update();
      });
    });
  }

  String getName(List phoneNo, String myNo) {
    final HomePageController homePageController = Get.find();
    print(
        "The value of phone no from user model is  ${homePageController.phoneNo}");
    if (newList.length != 0) {
      print("New List length " + newList.length.toString());
      for (int i = 0; i < newList.length; i++) {
        var no = phoneNo[0].toString() == myNo.replaceAll("+91", "")
            ? phoneNo[1]
            : phoneNo[0];
        if (newList[i]['phoneNo'].toString().replaceAll("+91", "") == no) {
          return newList[i]['name'];
        }
      }
    }
  }

  sendMessage() {}

  getChatMessages(String roomId) {
    DatabaseMethods().getMessage(roomId: roomId).then((value) {
      chatMessageSnapshot = value;
      print("Message snapshot value $chatMessageSnapshot");
      update();
    });
  }

  checkMessageAlignment(String sender) {
    final HomePageController homePageController = Get.find();
    if (sender == homePageController.phoneNo) {
      return Alignment.centerRight;
    } else {
      return Alignment.centerLeft;
    }
  }
}
