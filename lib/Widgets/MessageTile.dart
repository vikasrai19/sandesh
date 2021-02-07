import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandesh/Helper/User.dart';

import '../Controllers/HomePageController.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  // final UserData user;

  MessageTile({Key key, this.message, this.sender}) : super(key: key);

  HomePageController homePageController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.6,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        // width: size.width * 0.8,
        decoration: BoxDecoration(
            color: homePageController.phoneNo == sender
                ? Theme.of(context).primaryColor
                : Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Text(
          this.message,
          style: GoogleFonts.montserrat(
              fontSize: 18,
              color: this.sender == homePageController.phoneNo
                  ? Colors.white
                  : Colors.black),
        ));
  }
}
