import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandesh/Pages/OTPPage.dart';

class AccountCreation extends StatefulWidget {
  @override
  _AccountCreationState createState() => _AccountCreationState();
}

class _AccountCreationState extends State<AccountCreation> {
  bool isCorrect = false;
  TextEditingController numberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
                    height: size.height * 0.6,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Enter Your Mobile Number",
                            style: GoogleFonts.montserrat(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 50.0,
                                width: 60.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Text("+91",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w400))),
                            SizedBox(width: 5.0),
                            Container(
                              width: size.width * 0.65,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: TextFormField(
                                controller: numberController,
                                onChanged: (value) {
                                  if (numberController.text.length != 0 &&
                                      value.length != 10) {
                                    setState(() {
                                      isCorrect = false;
                                    });
                                  } else {
                                    setState(() {
                                      isCorrect = true;
                                    });
                                  }
                                },
                                style: GoogleFonts.montserrat(fontSize: 18.0),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Number",
                                    hintStyle: GoogleFonts.montserrat(
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    prefixIcon: Icon(Icons.mobile_friendly),
                                    suffixIcon: Icon(
                                        isCorrect
                                            ? Icons.check_circle
                                            : Icons.close_rounded,
                                        color: numberController.text.length == 0
                                            ? Colors.transparent
                                            : isCorrect
                                                ? Colors.green
                                                : Colors.red)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => OTPPage(phoneNumber: "+91" + numberController.text,)));
                          },
                          child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0))),
                              child: Text("Send OTP",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500))),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
