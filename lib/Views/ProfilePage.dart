import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/AccountCreationController.dart';

class ProfilePage extends StatelessWidget {
  final AccountCreationController accountController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () => accountController.signOut(),
            child: Text("Sign Out"),
          ),
        ),
      ),
    );
  }
}
