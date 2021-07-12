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
    Future.delayed(Duration(seconds: 2), () {
      print("[USER CONTROLLER INITIALIZED]");
      setUserValue();
    });
    super.onInit();
  }

  // Setting users value on the app startup
  void setUserValue() {
    LocalDatabaseController controller = Get.find();
    Future.delayed(Duration(seconds: 1), () {
      print("[FROM SET USER FUNCTION INSIDE THE USER CONTROLLER");
      // controller.getUserData();
      controller.getUserData().then((value) {
        print(value.length.toString());
        print("[VALUE] : " + value.toString());
        if (value != null) {
          print("VALUE NOT NULL");
          print(value.length.toString());
          if (value.length != 0) {
            print("[NAME}: " + value[0]['name'].toString());
            name = value[0]['name'].toString();
            userUid = value[0]['userUid'].toString();
            phoneNo = value[0]['phoneNo'].toString();
            dob = value[0]['dob'].toString();
            profileImg = value[0]['profileImg'].toString();
            update();
          }
        } else {
          print("[USER DATA NOT FOUND IN LOCAL DATABASE]");
        }
      });
    });
  }
}
