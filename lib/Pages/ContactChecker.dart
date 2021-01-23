import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sandesh/Helper/ContactList.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/User.dart';

import 'ChatDetailsPage.dart';

class ContactCheckerPage extends StatefulWidget {
  @override
  _ContactCheckerPageState createState() => _ContactCheckerPageState();
}

class _ContactCheckerPageState extends State<ContactCheckerPage> {
  QuerySnapshot chatRoomSnapshot;

  @override
  Widget build(BuildContext context) {
    final ContactList contactList = Provider.of<ContactList>(context);
    final UserData user = Provider.of<UserData>(context);
    return Scaffold(
      body: contactList.isLoadFinished == false
          ? Container(
              child: Center(
                  child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgressIndicator(),
                Text("Checking for contacts",
                    style: GoogleFonts.montserrat(fontSize: 20.0)),
              ],
            )))
          : contactList.contactList.length != 0
              ? ListView.builder(
                  itemCount: contactList.contactList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        String user1Id =
                            user.phoneNo.toString().replaceAll("+91", '');
                        String user2Id = contactList.contactList[index]
                                ['phoneNo']
                            .toString()
                            .replaceAll("+91", "");
                        String chatRoomId;
                        if (int.parse(user1Id) > int.parse(user2Id)) {
                          chatRoomId = user2Id + "_" + user1Id;
                          print(chatRoomId);
                        } else {
                          chatRoomId = user1Id + "_" + user2Id;
                        }
                        await createFirebaseChatRooms(context,
                            userUid: user.uid,
                            roomUid: chatRoomId,
                            phoneNo: user.phoneNo.replaceAll("+91", ""),
                            phone2: user1Id == user.phoneNo.replaceAll("+91", "") ? user2Id : user1Id,
                            userData: user);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChatDetailsPage(
                                      name: contactList.contactList[index]
                                          ['name'],
                                      imgUrl: null,
                                      roomId: chatRoomId,
                                    )));
                      },
                      child: ContactCheckerTile(
                        name: contactList.contactList[index]['name'],
                        phoneNo: contactList.contactList[index]['phoneNo'],
                      ),
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: Text("No one from your contact is on Sandesh",
                        style: GoogleFonts.montserrat(fontSize: 20.0)),
                  ),
                ),
    );
  }

  createFirebaseChatRooms(BuildContext context,
      {@required String userUid,
      @required String roomUid,
      @required String phoneNo,
      // @required String name,
      @required String phone2,
      @required UserData userData}) async {
    // Checking if the room is already created or not
    bool isFound = false;
    List chatRoom = userData.chatRoomList;
    List<Map<String, dynamic>> myUsers = userData.myUsersList;
    if (chatRoom.length != 0) {
      for (int i = 0; i < chatRoom.length; i++) {
        if (roomUid == chatRoom[i]) {
          setState(() {
            isFound = true;
          });
          break;
        }
      }
    }
    // Sample test again
    // Was working slow
    // But now gained some speed
    // Terminating the test
    if (!isFound) {
      DatabaseMethods()
          .createChatRoom(roomId: roomUid, phone1: phoneNo, phone2: phone2);
      chatRoom.add(roomUid.toString());
      Provider.of<UserData>(context, listen: false)
          .setValue(chatRoomListData: chatRoom);
      // DatabaseMethods().storePersonalChatRooms(
      //     userUid: phoneNo, data: {"chatRoomList": chatRoom});
      print("new chatroom created");
    } else {
      print("ChatRoom already present");
    }
  }
}

class ContactCheckerTile extends StatelessWidget {
  final String name;
  final String phoneNo;

  const ContactCheckerTile({Key key, this.name, this.phoneNo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration:
              BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
        ),
        title: Text(name),
        subtitle: Text(phoneNo));
  }
}
