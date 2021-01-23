import 'package:flutter/foundation.dart';

class ContactList extends ChangeNotifier{

  List<Map<String, dynamic>> contactList = [];
  bool isLoadFinished = false;

  setValue({List<Map<String, dynamic>> phoneList, bool isLoaded}){
    // print("set value function called from Contact List");
    contactList = phoneList;
    isLoadFinished = isLoaded;
    notifyListeners();
  }
}

// class ChatRoomList extends ChangeNotifier{
//   QuerySnapshot chatRoomSnap;

//   setChatRoomList({QuerySnapshot chatRoomSnapshot}){
//     print("Called set value function from chat room list");
//     chatRoomSnap = chatRoomSnapshot;
//     notifyListeners();
//   }
// }