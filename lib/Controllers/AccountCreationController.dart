import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';

class AccountController extends GetxController {
  final TextEditingController numberController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  Icon suffixIcon;
  String _verificationId;
  String userUid;

  suffixIconChecker() {
    if (numberController.text.length == 0 || numberController.text == null) {
      suffixIcon = Icon(Icons.close_rounded, color: Colors.transparent);
      update();
    } else if (numberController.text.length != 0 &&
        numberController.text.length == 10) {
      suffixIcon = Icon(Icons.check_circle, color: Colors.green);
      update();
    } else {
      suffixIcon = Icon(Icons.close_rounded, color: Colors.red);
      update();
    }
  }

  // Creating new account and signing the user in
  createUserAccount() async {
    print("createUserAccount called");
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+91" + numberController.text.toString(),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                print("Logged In Successfully");
                await HelperFunction.saveUserUid(value.user.uid);
                HelperFunction.saveIsLoggedInState(true);
                HelperFunction.saveUserPhoneNumber(
                    phoneNumber: "+91" + numberController.text.toString());
                Get.toNamed('/detailsPage');
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
          },
          codeSent: (String verificationId, int forceResendToken) {
            verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            _verificationId = verificationId;
          },
          timeout: Duration(seconds: 60));
    } catch (e) {}
  }

  // Check and sign the user in
  checkAndSignIn() async {
    print("This is from check and sigin function");
    print(otpController.text);
    print(_verificationId);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationId,
              smsCode: otpController.text.toString()))
          .then((val) {
        if (val.user != null) {
          print("Account created Successfully");
          userUid = val.user.uid;
          print("User uid is ${val.user.uid}");
          HelperFunction.saveUserUid(val.user.uid);
          HelperFunction.saveUserPhoneNumber(
              phoneNumber: "+91" + numberController.text.toString());
          HelperFunction.saveIsLoggedInState(true);
          // Create a route to details page
          Get.toNamed('/detailsPage');
        }
      });
    } catch (e) {}
  }

  // creating and adding new user info into database
  createAndUploadInfo() {
    if (nameController.text.length != 0) {
      HelperFunction.saveUserName(nameController.text.toString());
      Map<String, dynamic> userMap = {
        "userUid": userUid,
        "name": nameController.text,
        "phoneNo": numberController.text,
        "chatRoomList": []
      };

      DatabaseMethods()
          .getUserInfo(phoneNumber: numberController.text)
          .then((value) {
        if (value == null) {
          DatabaseMethods().uploadUserInfo(
              userMap: userMap,
              userUid: userUid,
              phoneNo: numberController.text);
        } else {
          DatabaseMethods().updateUserInfo(
              updateMap: {"name": nameController.text},
              userUid: userUid,
              phoneNumber: numberController.text.toString());
        }
      });
      // create a route to homePaged
      Get.offAllNamed("/homePage");
    }
  }
}
