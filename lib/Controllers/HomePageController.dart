import 'package:get/get.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';
import 'package:sandesh/Models/User.dart';

class HomePageController extends GetxController {
  String name;
  String phoneNo;
  String uid;
  String imgUrl;
  @override
  void onInit() {
    storeValues();
    super.onInit();
  }

  storeValues() {
    HelperFunction.getUserName().then((value) => name = value);
    HelperFunction.getUserPhoneNumber().then((value) => phoneNo = value);
    HelperFunction.getUserProfile().then((value) => imgUrl = value);
    HelperFunction.getUserUid().then((value) => uid = value);
  }
}
