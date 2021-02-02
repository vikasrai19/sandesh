import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/foundation.dart';

class ContactList extends ChangeNotifier {
  List<Map<String, dynamic>> _contactList = [];
  bool _isLoadFinished = false;
  Iterable<Contact> _contacts;

  List<Map<String, dynamic>> get contactList => _contactList;
  bool get isLoadFinished => _isLoadFinished;
  Iterable<Contact> get contacts => _contacts;

  set contacts(Iterable<Contact> val) {
    this._contacts = val;
    print("Successfully got contact values");
    print(val.toString());
    notifyListeners();
  }

  setValue({List<Map<String, dynamic>> phoneList, bool isLoaded}) {
    // print("set value function called from Contact List");
    _contactList = phoneList;
    _isLoadFinished = isLoaded;
    print("Value of contactList " + _contactList.toString());
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
