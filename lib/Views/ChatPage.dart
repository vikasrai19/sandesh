import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/UserController.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GetBuilder<UserController>(
            builder: (controller) {
              return controller.userUid == null ||
                      controller.userUid.length == 0
                  ? CircularProgressIndicator()
                  : Text("hello " + controller.userUid.toString());
            },
          ),
        ),
      ),
    );
  }
}
