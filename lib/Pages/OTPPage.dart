import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';
import 'package:sandesh/Pages/DetailsPage.dart';

class OTPPage extends StatefulWidget {
  final String phoneNumber;
  OTPPage({this.phoneNumber});
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _verificationId;
  String phoneNumber;
  String smsCode;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      new GlobalKey<ScaffoldMessengerState>();

  TextEditingController otpController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    verifyPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Enter OTP",
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          SizedBox(height: 80.0),
                          Container(
                            height: 50,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: TextFormField(
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.montserrat(fontSize: 20.0),
                              maxLines: 1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "OTP",
                                  hintStyle: GoogleFonts.montserrat(
                                      fontSize: 18.0,
                                      color: Colors.black.withOpacity(0.5)),
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.black)),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () async {
                                print("Verify button pressed");
                                try {
                                  await auth
                                      .signInWithCredential(
                                          PhoneAuthProvider.credential(
                                              verificationId: _verificationId,
                                              smsCode: otpController.text))
                                      .then((value) {
                                    if (value.user != null) {
                                      print("Account created Successfully");
                                      print("User uid is ${value.user.uid}");
                                      HelperFunction.saveUserUid(
                                          value.user.uid);
                                      HelperFunction.saveUserPhoneNumber(
                                          phoneNumber: widget.phoneNumber);
                                      HelperFunction.saveIsLoggedInState(true);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                    phoneNumber:
                                                        widget.phoneNumber,
                                                    userUid: value.user.uid,
                                                  )));
                                    }
                                  });
                                } catch (e) {
                                  FocusScope.of(context).unfocus();
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text("Invalid OTP"),
                                  ));
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 50.0,
                                  width: size.width * 0.35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  child: Text("Verify",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400))))
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  // Authentication
  void verifyPhoneNumber() async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: widget.phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential).then((value) async {
              if (value.user != null) {
                print("Logged In Successfully");
                await HelperFunction.saveUserUid(value.user.uid);
                HelperFunction.saveIsLoggedInState(true);
                HelperFunction.saveUserPhoneNumber(
                    phoneNumber: widget.phoneNumber);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              phoneNumber: widget.phoneNumber,
                              userUid: value.user.uid,
                            )));
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
          },
          codeSent: (String verificationId, int forceResendToken) {
            _verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            _verificationId = verificationId;
          },
          timeout: Duration(seconds: 60));
    } catch (e) {}
  }
}
