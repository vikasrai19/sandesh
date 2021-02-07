import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/Controllers/BottomNavigationController.dart';
import 'package:sandesh/Controllers/HomePageController.dart';

class HomePage extends StatelessWidget {
  final bottomNavController = Get.put(BottomNavigationController());
  final homePageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomNavigationController>(
        builder: (controller) {
          return controller.bottomNavigationWidgtes[controller.currentIndex];
        },
      ),
      bottomNavigationBar:
          GetBuilder<BottomNavigationController>(builder: (controller) {
        return BottomNavigationBar(
          elevation: 20,
          items: bottomNavController.bottomNavigationItems,
          onTap: (int index) => bottomNavController.setCurrentIndex(index),
          currentIndex: bottomNavController.currentIndex,
          showUnselectedLabels: false,
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/contactChecker"),
        child: Icon(Icons.add, size: 30),
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: "Check Contacts",
      ),
    );
  }
}
