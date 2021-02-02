import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sandesh/Helper/ContactList.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/ProvidersList.dart';
import 'package:sandesh/Helper/User.dart';
import 'package:sandesh/Pages/ChatDetailsPage.dart';
import 'package:sandesh/Pages/ContactChecker.dart';
import 'package:sandesh/Widgets/CustomAppBar.dart';
import 'package:sandesh/Widgets/UserDisplayTile.dart';

class MessagePage extends StatefulWidget {
  final String phoneNumber;

  const MessagePage({Key key, this.phoneNumber}) : super(key: key);
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  UserData user;
  List chatList = [];
  List<Map<String, dynamic>> newList = [];
  List<String> lastMessages = [];
  Stream<QuerySnapshot> lastMessageSnapshot;
  DocumentSnapshot imageSnapshot;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () => getMessageList());
    super.initState();
  }

  getMessageList() {
    // This function gets the messages list to display in the main chats page
    print("Get message list called");
    DatabaseMethods()
        .getLastMessage(phone: widget.phoneNumber.toString())
        .then((value) {
      context.read(snapshotProviders).lastMessageSnapshot = value;
      // setState(() {
      //   lastMessageSnapshot = value;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    user = context.read(userProvider);
    final ContactList contactList = context.read(contactListProvider);
    // newList = contactList.contactList;
    newList = contactList.contactList;
    // chatList = user.chatRoomList;
    chatList = user.chatRoomList;
    Size size = MediaQuery.of(context).size;

    bool isUserSent(String sentBy) {
      return sentBy == user.phoneNo ? true : false;
    }

    String getName(List phoneNo, String myNo) {
      if (newList.length != 0) {
        print("New List length " + newList.length.toString());
        for (int i = 0; i < newList.length; i++) {
          var no = phoneNo[0].toString() == myNo.replaceAll("+91", "")
              ? phoneNo[1]
              : phoneNo[0];
          if (newList[i]['phoneNo'].toString().replaceAll("+91", "") == no) {
            return newList[i]['name'];
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(
                  name: "Sandesh", icon1: Icons.search, icon2: Icons.more_vert),
              SizedBox(height: 20.0),
              Consumer(builder: (context, watch, child) {
                final lastMsgSnapshot =
                    watch(snapshotProviders).lastMessageSnapshot;
                return Expanded(
                  child: StreamBuilder(
                      stream: lastMsgSnapshot,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data.documents[index];
                                  String name =
                                      getName(data['users'], user.phoneNo);
                                  return GestureDetector(
                                    onTap: () {
                                      if (data['sentBy'] != user.phoneNo &&
                                          data['newMsgCount'] != 0) {
                                        DatabaseMethods().setNewMessages(
                                            roomId: data['name'], msg: []);
                                      }
                                      // Routing to mew page
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ChatDetailsPage(
                                                  name: name,
                                                  roomId: data['name']
                                                      .toString())));
                                    },
                                    child: name != null
                                        ? UserDisplayTile(
                                            name: name.toString(),
                                            msg: isUserSent(data['sentBy'])
                                                ? "You: " + data['lastMessage']
                                                : data['lastMessage'],
                                            // isUnread: data['sentBy'] !=
                                            //                                   user.phoneNo &&
                                            //                               data['newMsgCount'] != 0
                                            //                           ? true
                                            //                           : false,
                                            //                       unreadCount: data['sentBy'] !=
                                            //                                   user.phoneNo &&
                                            //                               data['newMsgCount'] != 0
                                            //                           ? data['newMsgCount']
                                            //                               .toString()
                                            //                           : 0,
                                            time: data['msgTime'].toString())
                                        : Container(
                                            child: CircularProgressIndicator(),
                                          ),
                                  );
                                },
                              )
                            : Container();
                      }),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Extras",
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        elevation: 5,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ContactCheckerPage()));
        },
      ),
    );
  }
}
