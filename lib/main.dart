import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/LocalDatabaseController.dart';

import 'Views/AccountCreationPage.dart';
import 'Views/HomePage.dart';
import 'controllers/AccountCreationController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final localDatabaseController = Get.put(LocalDatabaseController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final accountController = Get.put(AccountCreationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountCreationController>(builder: (accountController) {
      return GetMaterialApp(
        title: "Sandesh",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepOrange,
          primarySwatch: Colors.deepOrange,
        ),
        home: accountController.isUserSignedIn != null &&
                accountController.isUserSignedIn == true
            ? HomePage()
            : AccountCreationPage(),
      );
    });
  }
}
