import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/ContactController.dart';
import 'package:sandesh/controllers/UserController.dart';

import 'ContactCheckerPage.dart';

class ChatPage extends StatelessWidget {
  final ContactController contactController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GetBuilder<UserController>(
            builder: (controller) {
              print("[USERUID]" + controller.userUid.toString());
              return controller.userUid == null ||
                      controller.userUid.length == 0
                  ? CircularProgressIndicator()
                  : Text(
                      "hello " + controller.userUid.toString(),
                    );
            },
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.065),
        child: FloatingActionButton(
          onPressed: () {
            contactController.getContacts();
            Get.to(ContactCheckerPage());
          },
          child: Icon(Icons.add),
          tooltip: "Check Contacts",
        ),
      ),
    );
  }
}
