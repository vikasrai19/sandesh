import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/Views/DetailsPage.dart';
import 'package:sandesh/controllers/AccountCreationController.dart';
import 'package:sandesh/widgets/AccountCreationBackground.dart';

class OTPPage extends StatelessWidget {
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
              controller: accountController.otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter OTP",
                labelText: "OTP",
                hintStyle: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                accountController.manualSignIn();
              },
              child: Text("VERIFY OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
