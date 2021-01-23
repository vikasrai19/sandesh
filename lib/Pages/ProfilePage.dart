import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';
import 'package:sandesh/Helper/User.dart';
import 'package:provider/provider.dart';
import 'package:sandesh/Pages/AccountCreation.dart';
import 'package:sandesh/Widgets/CustomAppBar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserData>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            CustomAppBar(
                name: "Profile", icon1: Icons.search, icon2: Icons.more_vert),
            Container(
                child: Text(
              "${user.uid.toString()}",
            )),
            Container(
              child: Center(
                child: RaisedButton(
                  child: Text("LogOut"),
                  onPressed: () {
                    HelperFunction.saveUserName(null);
                    HelperFunction.saveUserPhoneNumber(phoneNumber: null);
                    HelperFunction.saveIsLoggedInState(false);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => AccountCreation()),
                        (route) => false);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
