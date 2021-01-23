import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {

  static String isLoggedInKey = "ISLOGGEDIN";
  static String userUidKey = "USERUID";
  static String userNameKey = "USERNAME";
  static String userProfileImageKey = "USERPROFILEIMAGEKEY";
  static String userPhoneKey = "USERPHONENUMBER";

  // Storing value in shared preferences
  static Future<bool> saveIsLoggedInState(bool isLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool> saveUserUid(String userUid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userUidKey, userUid);
  }

  static Future<bool> saveUserName(String username) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, username);
  }

  static Future<bool> saveUserProfile(String profileUrl) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfileImageKey, profileUrl);
  }

  static Future<bool> saveUserPhoneNumber({String phoneNumber}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userPhoneKey, phoneNumber);
  }
  

  // Getting value from shared preferences
  static Future<bool> getIsLoggedInState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey);
  }

  static Future<String> getUserUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userUidKey);
  }

  static Future<String> getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<String> getUserProfile() async{
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfileImageKey);
  }

  static Future<String> getUserPhoneNumber()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoneKey);
  }
}