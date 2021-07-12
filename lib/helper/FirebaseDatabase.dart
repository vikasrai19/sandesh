import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sandesh/controllers/MessagController.dart';
import 'package:sandesh/models/MessageModel.dart';
import 'package:sandesh/models/UserModel.dart';

class FirebaseDatabase {
  //  Adding the users data
  addUsers({UserModel user}) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.userUid)
        .set({
          "userUid": user.userUid,
          "name": user.name,
          "phoneNo": user.phoneNo,
          "dob": user.dob,
          "profileImg": user.profileImg,
        })
        .then((value) => print("user data successfully added"))
        .catchError((e) {
          print("[ERROR] " + e.toString());
        });
  }

  // TODO: Getting the list of all the users registered in SANDESH
  getUsers() async {
    return FirebaseFirestore.instance.collection('Users').get();
  }

  // creating a chat room
  createChatRoom({String phone1, String phone2}) {
    if (phone1.length == 12) {
      phone1 = phone1.replaceAll("+91", "");
      print("[PHONE1] : " + phone1);
    }
    if (phone2.length == 12) {
      phone2 = phone2.replaceAll("+91", "");
      print("[PHONE2] : " + phone2);
    }
    String roomId;
    if (int.parse(phone1) > int.parse(phone2)) {
      roomId = phone2.toString() + "_" + phone1.toString();
    } else {
      roomId = phone1.toString() + "_" + phone2.toString();
    }

    var val = getChatRoom(roomId: roomId);
    if (val.length == 0) {
      FirebaseFirestore.instance.collection("ChatRoom").doc(roomId).set({
        "users": [phone1.toString(), phone2.toString()],
        "roomId": roomId.toString(),
      });
    } else {
      print("Chat room is already present");
    }
  }

  // Getting chatrooms using its roomId
  getChatRoom({String roomId}) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("roomId", isEqualTo: roomId)
        .get();
  }

  // Getting current user chatroom list
  getUserChatRooms({String phoneNo}) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: phoneNo)
        .get();
  }

  // Adding messages into the Firebase Firestore chat room
  addMessages({MessageModel msg, String roomId}) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .collection("message")
        .add({
      "sender": msg.sender,
      "msg": msg.msg,
      "msgType": msg.msgType,
      "isMessageDel": msg.isMessageDel,
      "isMessageRead": msg.isMessageRead,
      "messageSentTime": msg.messageSentTime,
      "messageDelTime": msg.messageDelTime,
      "messageReadTime": msg.messageReadTime,
      "time": msg.time,
    });
  }

  // Getting messages from the Firebase Firestore chat room
  getMessages({String roomId}) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(roomId)
        .collection("message")
        .snapshots();
    // .then((QuerySnapshot snapshot){
    //   snapshot.docs.forEach((e) => msgController.messageList.add({
    //     "sender": e.get('sender'),
    //     "msg": e.get("msg"),
    //     "msgType":
    //   }));
    // });
  }
}
