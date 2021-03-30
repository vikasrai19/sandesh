import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sandesh/controllers/LocalDatabaseController.dart';

class UserController extends GetxController {
  String name;
  String phoneNo;
  String dob;
  String profileImg;
  String userUid;

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 1), () {
      setUserValue();
    });
    super.onInit();
  }

  // Setting users value on the app startup
  void setUserValue() {
    LocalDatabaseController controller = Get.find();
    controller.getUserData().then((value) {
      name = value[0]['name'];
      phoneNo = value[0]['phoneNo'];
      dob = value[0]['dob'];
      profileImg = value[0]['profileImg'];
      userUid = value[0]['userUid'];
      update();
    });
  }
}
