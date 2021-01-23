import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'Helper/ContactList.dart';
import 'Helper/HelperFunctions.dart';
import 'Helper/User.dart';
import 'Pages/AccountCreation.dart';
import 'Pages/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isLoggedIn;

  @override
  void initState() {
    HelperFunction.getIsLoggedInState().then((value) => {
      setState((){
        isLoggedIn = value;
      })
    });
    super.initState();
  }

  @override 
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserData(),),
        // ChangeNotifierProvider(create:(_) => ChatRoomList()),
        ChangeNotifierProvider(create: (_) => ContactList(),)
      ],
      child: MaterialApp(
      title:"Sandesh",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 145, 5, 1)
      ),
      home:isLoggedIn != null && isLoggedIn ? HomePage() : AccountCreation()
    ),
    );
  }
}