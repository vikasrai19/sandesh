import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/AccountCreationController.dart';
import 'package:sandesh/widgets/AccountCreationBackground.dart';

import 'OTPPage.dart';

class AccountCreationPage extends StatelessWidget {
  AccountCreationController accountController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccountCreationBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: accountController.phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Mobile Number",
                labelText: "Mobile Number",
                hintStyle: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                if (accountController.phoneController.text.length == 10) {
                  accountController.verifyPhoneNumber();
                  Get.to(OTPPage());
                } else {
                  print("Please enter a proper phone number");
                }
              },
              child: Text("SEND OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
