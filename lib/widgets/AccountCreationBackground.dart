import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountCreationBackground extends StatelessWidget {
  final Widget child;
  const AccountCreationBackground({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          //  Bottom Container with gradient background
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: Get.width,
              height: Get.height * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepOrange,
                    Colors.orange,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sandesh",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      "India's Native Chat App",
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //  Creating a upper layer
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 48.0,
              ),
              width: Get.width,
              height: Get.height * 0.55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: this.child,
            ),
          ),
        ],
      ),
    );
  }
}
