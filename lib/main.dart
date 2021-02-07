import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sandesh/Controllers/AccountCreationController.dart';
import 'package:get/get.dart';
import 'package:sandesh/Views/AccountCreationPage.dart';
import 'package:sandesh/Views/Homepage.dart';

import 'Controllers/ContactListController.dart';
import 'Helper/HelperFunctions.dart';
import 'Utility/Router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn;
  @override
  void initState() {
    HelperFunction.getIsLoggedInState().then((value) {
      print("is Logged In Value " + value.toString());
      if (value == null || value == false) {
        setState(() {
          isLoggedIn = false;
        });
      } else {
        setState(() {
          isLoggedIn = true;
        });
      }
      print("isLogged In Value " + isLoggedIn.toString());
    });
    super.initState();
  }

  final accountController = Get.put(AccountController());
  final contactListController = Get.put(ContactListController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Sandesh",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orange),
      // initialRoute: "/homePage",
      home: isLoggedIn == null || isLoggedIn == false
          ? AccountCreationPage()
          : HomePage(),
      getPages: PageRouter.route,
    );
  }
}

// import 'package:firebase_core/firebase_core.dart';
// import "package:flutter/material.dart";
// import 'Helper/HelperFunctions.dart';
// import 'Pages/AccountCreation.dart';
// import 'Pages/HomePage.dart';
// import 'package:flutter_riverpod/all.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(ProviderScope(child: MyApp()));
// }

// class LoginState extends ChangeNotifier {
//   bool _isLoggedIn;

//   bool get isLoggedIn => _isLoggedIn;
//   set isLoggedIn(bool val) {
//     print("_isLoggedIn value  : " + _isLoggedIn.toString());
//     _isLoggedIn = val;
//     print("_isLoggedIn value  : " + _isLoggedIn.toString());
//     notifyListeners();
//   }
// }

// final loggedInProviders = ChangeNotifierProvider((ref) => LoginState());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     HelperFunction.getIsLoggedInState().then((value) {
//       print("Got value");
//       context.read(loggedInProviders).isLoggedIn = value;
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("From build Method -> Value of _isLoggedIn " +
//         context.read(loggedInProviders).isLoggedIn.toString());
//     return Consumer(builder: (context, watch, child) {
//       bool isLoggedInVal = watch(loggedInProviders).isLoggedIn;
//       return MaterialApp(
//           title: "Sandesh",
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(primaryColor: Color.fromRGBO(255, 145, 5, 1)),
//           home: isLoggedInVal != null && isLoggedInVal == true
//               ? HomePage()
//               : AccountCreation());
//     });
//   }
// }
