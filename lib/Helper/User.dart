import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier{
  String uid;
  String userName = "Hackers Point";
  String phoneNo;
  List chatRoomList = [];
  List<Map<String, dynamic>> myUsersList = [];

  setValue({String userUid, String name, String phoneNumber, List chatRoomListData}){
    // print("Called Set Value function from user data");
    uid = userUid;
    userName = name;
    phoneNo = phoneNumber;
    chatRoomList = chatRoomListData;
    notifyListeners();
  }

  setMyUsersList({List<Map<String, dynamic>> myUsersListData}){
    myUsersList = myUsersListData;
    notifyListeners();
  }
}