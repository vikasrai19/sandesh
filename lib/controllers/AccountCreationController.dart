import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/Views/AccountCreationPage.dart';
import 'package:sandesh/Views/DetailsPage.dart';
import 'package:sandesh/Views/HomePage.dart';
import 'package:sandesh/controllers/LocalDatabaseController.dart';
import 'package:sandesh/helper/FirebaseDatabase.dart';
import 'package:sandesh/helper/helper_function.dart';
import 'package:sandesh/models/UserModel.dart';

import 'HomePageController.dart';

class AccountCreationController extends GetxController {
  TextEditingController phoneController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  String smsCode = "";
  String verificationID;
  String uid;
  bool isUserSignedIn;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    checkIsUserSignedIn();
    super.onInit();
  }

  // verify user and sign in
  Future<void> verifyPhoneNumber() async {
    print("Verifying PhoneNumber");
    await auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print("Signed In successfully");
        Get.to(DetailsPage());
      },
      verificationFailed: (FirebaseAuthException e) {
        print("[EXCEPTION] " + e.toString());
      },
      codeSent: (verificationId, [resendToken]) async {
        print("Sending verification code");
        // Waiting for the user to enter the otp
        if (otpController.text.length != 0) {
          smsCode = otpController.text.toString();
        }
        verificationID = verificationId;
        // Creating a PhoneAuthCredentials with the code

        try {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign in the user with the credential
          await auth.signInWithCredential(phoneAuthCredential);
          print("[SMS CODE] " + smsCode);
          uid = getUserUid();
        } catch (e) {
          print("[THIS EXCEPTION IS FROM AUTO MATIC SIGNIN BY FIREBASE]");
          print("[EXCEPTION] " + e.toString());
        }
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        smsCode = verificationId;
        print("Time out");
      },
    );
  }

  // Manually signing in the user
  manualSignIn() async {
    try {
      if (accountController.otpController.text.length == 6 &&
          accountController.smsCode != null &&
          verificationID != null) {
        print("[THIS IS FROM OTP PAGE]");
        print("[VERIFICATION ID] " + accountController.verificationID);
        PhoneAuthCredential authCredential = await PhoneAuthProvider.credential(
            verificationId: accountController.verificationID,
            smsCode: accountController.otpController.text.toString());
        await accountController.auth.signInWithCredential(authCredential).catchError((error) {
          print("[ERROR]" + error.toString());
          print("Login Successful");
          Get.to(DetailsPage());
        });
      }
      Get.to(DetailsPage());
    } catch (e) {
      print("Please enter a proper otp");
      print("[EXCEPTION] " + e.toString());
      Get.snackbar("Error", "Please enter your OTP correctly");
    }
  }

  String getUserUid() {
    final User user = auth.currentUser;
    return user.uid.toString();
  }

  // Storing user Data in firebase firestore
  void addUserToFirebase() {
    if (nameController.text.length != 0 && phoneController.text.length == 10) {
      print("will be done soon");
    }
  }

  // Displaying calendar to pick date
  Future<void> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
      dobController.text = currentDate.toLocal().toString().split(" ")[0];
      print("[CURRENT DATE] " + currentDate.toString());
    }
  }

  // Store user data into database
  storeUser() {
    LocalDatabaseController databaseController = Get.find();
    String userUid = getUserUid();
    final user = new UserModel(
      userUid: userUid.toString(),
      name: nameController.text.toString(),
      phoneNo: phoneController.text.toString(),
      dob: dobController.text.toString(),
      profileImg: "",
    );

    // adding user data into local database
    var result = databaseController.addUserData(user);
    print("[DATABASE RESULT] : " + result.toString());

    //Adding user data into firebase firestore
    FirebaseDatabase().addUsers(user: user);
    HelperFunction.storeUserSignedInState(true);
    Get.offAll(HomePage());
  }

  // Checking if the user is already signed in
  checkIsUserSignedIn() async {
    isUserSignedIn = await HelperFunction.getUserSignedInState();
    print("[ISUSERSIGNEDIN] " + isUserSignedIn.toString());
    update();
  }

  // Signing out the user
  signOut() {
    final HomePageController homePageController = Get.find();
    HelperFunction.storeUserSignedInState(false);
    LocalDatabaseController controller = Get.find();
    var sample = getUserUid();
    controller.deleteUserData(userUid: getUserUid().toString());
    controller.deleteContactsFromDB();
    print(controller.getUserData().toString());
    auth.signOut();
    homePageController.currentIndex = 0;
    Get.offAll(AccountCreationPage());
  }
}
