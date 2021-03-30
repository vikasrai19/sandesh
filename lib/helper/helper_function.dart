import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String userUidKey = "USERUID";
  static String nameKey = "USERNAME";
  static String phoneNokey = "USERPHONENO";
  static String dobKey = "USERDOB";
  static String profileImageKey = "USERPROFILEIMG";
  static String isUserSignedInKey = "ISUSERSIGNEDINKEY";

  // Saving data in shared preference
  static Future<bool> storeUserSignedInState(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(isUserSignedInKey, val);
  }

  // Getting value from shared preferences
  static Future<bool> getUserSignedInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(isUserSignedInKey);
  }
}
