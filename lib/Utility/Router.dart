import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sandesh/Views/AccountCreationPage.dart';
import 'package:sandesh/Views/ContactChecker.dart';
import 'package:sandesh/Views/DetailsPage.dart';
import 'package:sandesh/Views/Homepage.dart';
import 'package:sandesh/Views/OtpPage.dart';

class PageRouter {
  static final route = [
    GetPage(name: '/accountCreation', page: () => AccountCreationPage()),
    GetPage(name: '/otpPage', page: () => OTPPage()),
    GetPage(name: '/detailsPage', page: () => DetailsPage()),
    GetPage(name: '/homePage', page: () => HomePage()),
    GetPage(name: '/contactChecker', page: () => ContactChecker())
  ];
}
