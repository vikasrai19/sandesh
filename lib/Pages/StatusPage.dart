import 'package:flutter/material.dart';
import 'package:sandesh/Widgets/CustomAppBar.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
          children: [
            CustomAppBar(name:"Status", icon1:Icons.search, icon2: Icons.more_vert),
          ],
        ),
      ),
    ));
  }
}