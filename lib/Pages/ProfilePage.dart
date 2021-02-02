import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';
import 'package:sandesh/Helper/ProvidersList.dart';
import 'package:sandesh/Pages/AccountCreation.dart';
import 'package:sandesh/Widgets/CustomAppBar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.read(userProvider);
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
                child: ElevatedButton(
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
