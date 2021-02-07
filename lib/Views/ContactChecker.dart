import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandesh/Controllers/ContactListController.dart';
import 'package:sandesh/Widgets/ContactCheckerTile.dart';

class ContactChecker extends StatelessWidget {
  final ContactListController contactController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Contacts", style: GoogleFonts.montserrat(fontSize: 30)),
              SizedBox(height: 20.0),
              Expanded(
                child: GetBuilder<ContactListController>(
                  builder: (controller) {
                    return ListView.builder(
                      itemCount: controller.contactList.length,
                      itemBuilder: (context, index) {
                        return controller.isContactLoaded == false
                            ? Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : controller.contactList.length != 0
                                ? Container(
                                    child: ContactCheckerTile(
                                        name: controller.contactList[index]
                                            ['name'],
                                        phoneNo: controller.contactList[index]
                                            ['phoneNo']),
                                  )
                                : Container(
                                    child: Center(
                                        child: Text("No Contacts in sandesh")),
                                  );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
