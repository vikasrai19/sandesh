import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'Helper/HelperFunctions.dart';
import 'Pages/AccountCreation.dart';
import 'Pages/HomePage.dart';
import 'package:flutter_riverpod/all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class LoginState extends ChangeNotifier {
  bool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool val) {
    print("_isLoggedIn value  : " + _isLoggedIn.toString());
    _isLoggedIn = val;
    print("_isLoggedIn value  : " + _isLoggedIn.toString());
    notifyListeners();
  }
}

final loggedInProviders = ChangeNotifierProvider((ref) => LoginState());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    HelperFunction.getIsLoggedInState().then((value) {
      print("Got value");
      context.read(loggedInProviders).isLoggedIn = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("From build Method -> Value of _isLoggedIn " +
        context.read(loggedInProviders).isLoggedIn.toString());
    return Consumer(builder: (context, watch, child) {
      bool isLoggedInVal = watch(loggedInProviders).isLoggedIn;
      return MaterialApp(
          title: "Sandesh",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Color.fromRGBO(255, 145, 5, 1)),
          home: isLoggedInVal != null && isLoggedInVal == true
              ? HomePage()
              : AccountCreation());
    });
  }
}
