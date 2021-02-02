import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SnapshotProviders extends ChangeNotifier {
  QuerySnapshot _userSnapshot;
  QuerySnapshot _chatRoomSnapshot;
  Stream<QuerySnapshot> _lastMessageSnapshot;

  // getter fields
  QuerySnapshot get userSnapshot => _userSnapshot;
  QuerySnapshot get charRoomSnapshot => _chatRoomSnapshot;
  Stream<QuerySnapshot> get lastMessageSnapshot => _lastMessageSnapshot;

  // Setter Fields
  set lastMessageSnapshot(Stream<QuerySnapshot> val) {
    _lastMessageSnapshot = val;
    print("_lastMessageSnapshot value " + _lastMessageSnapshot.toString());
    notifyListeners();
  }
}
