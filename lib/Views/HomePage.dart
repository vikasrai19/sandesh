import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/AccountCreationController.dart';
import 'package:sandesh/controllers/HomePageController.dart';
import 'package:sandesh/controllers/LocalDatabaseController.dart';
import 'package:sandesh/controllers/UserController.dart';

class HomePage extends StatelessWidget {
  final LocalDatabaseController controller = Get.find();
  final AccountCreationController accountController = Get.find();
  final homePageController = Get.put(HomePageController());
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                height: Get.height * 0.20,
                width: Get.width,
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sandesh",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.search, color: Colors.white, size: 28),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          fillColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: Get.height * 0.18,
              child: GetBuilder<HomePageController>(builder: (controller) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Container(
                    height: Get.height * 0.83,
                    width: Get.width,
                    child: controller.children[controller.currentIndex],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          GetBuilder<HomePageController>(builder: (controller) {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex,
          items: controller.navItems,
          onTap: controller.onTabTapped,
          elevation: 5,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey[300],
        );
      }),
    );
  }
}
