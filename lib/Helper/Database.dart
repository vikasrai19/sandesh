import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  // Creating a new user info
  uploadUserInfo({userMap, String userUid, String phoneNo}) {
    FirebaseFirestore.instance.collection("Users").doc(phoneNo).set(userMap);
  }

  // Getting the user info from Firestore
  getUserInfo({String phoneNumber}) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .where("phoneNo", isEqualTo: phoneNumber)
        .get();
  }

  // Updating user info into firestore
  updateUserInfo({updateMap, String userUid, String phoneNumber}) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(phoneNumber)
        .update(updateMap);
  }

  // Getting all registered users
  getUsersList() async {
    return await FirebaseFirestore.instance.collection("Users").get();
  }

  // Creating a chat room using some chat room id
  createChatRoom(
      {String userId,
      @required String roomId,
      @required String phone1,
      @required String phone2}) {
    FirebaseFirestore.instance.collection("ChatRoom").doc(roomId).set({
      "name": roomId,
      "users": [phone1, phone2],
      "lastMessage": null,
      "time": null,
      "msgType": null,
      "isLastMessage": null,
      "msgTime": null,
      "msgDate": null
    });
  }

  // create personal chat rooms in firebase
  createPersonalChatRoom(
      {@required String phoneNo, @required Map<String, dynamic> data}) {
    FirebaseFirestore.instance
        .collection("ChatRooms" + phoneNo.toString())
        .doc(phoneNo)
        .set(data);
  }

  // Store values in personal chat rooms
  storePersonalChatRooms(
      {@required String userUid, @required Map<String, dynamic> data}) {
    FirebaseFirestore.instance.collection("Users").doc(userUid).update(data);
  }

  // Get all chat rooms from firebase
  getChatRooms({@required String phoneNo}) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where('users', arrayContains: phoneNo)
        .get();
  }

  // Send message
  sendMessage({@required String roomId, @required Map<String, dynamic> data}) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .collection("Chats")
        .doc()
        .set(data);
  }

  // Get Message
  getMessage({@required String roomId}) async {
    return FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(roomId)
        .collection('Chats')
        .where("message", isNotEqualTo: null)
        .orderBy("time", descending: false)
        .snapshots();
  }

  // Set last message
  setLastMessage(
      {@required String roomId,
      @required String phoneNo,
      @required String msg,
      @required String msgTime,
      @required String msgDate,
      String msgType = "text"}) {
    FirebaseFirestore.instance.collection("ChatRoom").doc(roomId).update({
      "lastMessage": msg,
      "isLastMessage": true,
      "msgType": msgType,
      "time": DateTime.now().millisecondsSinceEpoch,
      "msgDate": msgDate,
      "msgTime": msgTime,
      "sentBy": phoneNo,
    });
  }

  // set New Messages
  setNewMessages({@required String roomId, @required List msg}) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .update({"newMessages": msg, "newMsgCount": msg.length});
  }

  // get new message data
  getNewMessageData({@required String phone, @required String roomId}) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("name", isEqualTo: roomId)
        .snapshots();
  }

  // Get last message
  getLastMessage({@required String phone}) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: phone.replaceAll("+91", ""))
        .where("lastMessage", isNotEqualTo: null)
        .orderBy("time", descending: true)
        .snapshots();
  }

  // Get profile image
  getProfileImage({@required String roomId}) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(roomId)
        .get();
  }
}
