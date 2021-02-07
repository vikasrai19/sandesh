import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandesh/Controllers/AccountCreationController.dart';

class DetailsPage extends StatelessWidget {
  AccountController accountController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: Get.height,
            width: Get.width,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 32.0),
                      height: Get.height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: Icon(Icons.notifications,
                                    color: Colors.black),
                              )),
                          SizedBox(height: 80),
                          Text(
                            "Sandesh",
                            style: GoogleFonts.montserrat(
                                fontSize: 32.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30.0),
                          Text(
                            "Welcome to the new native \nmessenger app of India",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: Get.height * 0.6,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Details",
                            style: GoogleFonts.montserrat(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Enter Your Name",
                              style: GoogleFonts.montserrat(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 50.0),
                          Container(
                            height: 50,
                            width: Get.width * 0.7,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: TextFormField(
                              controller: accountController.nameController,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20.0, color: Colors.black),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.person,
                                      color: Theme.of(context).primaryColor),
                                  hintText: "Name",
                                  hintStyle: GoogleFonts.montserrat(
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(0.5))),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: () {
                              accountController.createAndUploadInfo();
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0))),
                                child: Text("Continue",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400))),
                          )
                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
