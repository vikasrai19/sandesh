import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  String _uid;
  String _userName = "Hackers Point";
  String _phoneNo;
  List _chatRoomList = [];
  List<Map<String, dynamic>> _myUsersList = [];

  String get uid => _uid;
  String get userName => _userName;
  String get phoneNo => _phoneNo;
  List get chatRoomList => _chatRoomList;
  List<Map<String, dynamic>> get myUsersList => _myUsersList;

  set uid(String val) {
    this._uid = val;
    notifyListeners();
  }

  set userName(String val) {
    this._userName = val;
    notifyListeners();
  }

  set phoneNo(String val) {
    this._phoneNo = val;
    notifyListeners();
  }

  set chatRoomList(List val) {
    this._chatRoomList = val;
    notifyListeners();
  }

  set myUsersList(List<Map<String, dynamic>> val) {
    this._myUsersList = val;
    notifyListeners();
  }

  setValue(
      {String userUid,
      String name,
      String phoneNumber,
      List chatRoomListData}) {
    // print("Called Set Value function from user data");
    _uid = userUid;
    _userName = name;
    _phoneNo = phoneNumber;
    _chatRoomList = chatRoomListData;
    notifyListeners();
  }

  setMyUsersList({List<Map<String, dynamic>> myUsersListData}) {
    _myUsersList = myUsersListData;
    notifyListeners();
  }
}
