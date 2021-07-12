import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/ContactController.dart';

class ContactCheckerPage extends StatelessWidget {
  final ContactController contactController = Get.find();
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
                      GetX<ContactController>(builder: (controller) {
                        return TextField(
                          controller: controller.contactSearchController,
                          onChanged: (val) => controller.searchContacts(val),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 28,
                            ),
                            suffixIcon: controller.contactSearchController.text.length == 0
                                ? Container()
                                : GestureDetector(
                                    onTap: controller.clearSearch(),
                                    child: Icon(Icons.border_clear_outlined),
                                  ),
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
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: Get.height * 0.18,
              child: GetBuilder<ContactController>(builder: (controller) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  // TODO: Add a list to display all contacts that are registered in SANDESH
                  child: GetX<ContactController>(
                    builder: (controller) {
                      return controller.searchChild();
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
