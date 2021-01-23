import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/User.dart';
import 'package:sandesh/Widgets/ChatUserHeader.dart';
import 'package:sandesh/Widgets/MessageTile.dart';

class ChatDetailsPage extends StatefulWidget {
  final String name;
  final String imgUrl;
  final String roomId;
  ChatDetailsPage({Key key, this.name, this.imgUrl, this.roomId})
      : super(key: key);

  @override
  _ChatDetailsPageState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  TextEditingController chatController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();
  ScrollPhysics physics = BouncingScrollPhysics();
  Size size;

  Stream<QuerySnapshot> messageSnapshot;
  QuerySnapshot newMessageSnapshot;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () {
      getMessageFromFirebase();
    });
    // scrollToEnd();
    super.initState();
  }

  scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent >= size.height) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      }
    });
  }

  getMessageFromFirebase() {
    DatabaseMethods().getMessage(roomId: widget.roomId).then((value) {
      print("Room id inside get message function" + widget.roomId);
      setState(() {
        messageSnapshot = value;
      });
      if (messageSnapshot != null) {
        Future.delayed(Duration(milliseconds: 200), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn);
          }
        });
      }
    });
  }

  List getDateAndTime() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var finalDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var finalTime = "${dateParse.hour}-${dateParse.minute}";
    return [finalDate, finalTime];
  }

  @override
  Widget build(BuildContext context) {
    UserData user = Provider.of<UserData>(context, listen: false);
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 75),
            child: StreamBuilder(
              stream: messageSnapshot,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        physics: physics,
                        controller: _scrollController,
                        itemCount: snapshot.data.documents.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? ChatUserHeader(name: widget.name, imgUrl: null)
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  alignment: snapshot.data.documents[index - 1]
                                              ['sender'] ==
                                          user.phoneNo
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: MessageTile(
                                    message: snapshot.data.documents[index - 1]
                                        ['message'],
                                    sender: snapshot.data.documents[index - 1]
                                        ['sender'],
                                    user: user,
                                  ),
                                );
                        },
                      )
                    : Container(
                        child: Center(child: CircularProgressIndicator()));
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: EdgeInsets.only(right: 4.0, left: 16.0),
              alignment: Alignment.center,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController,
                      maxLines: 100,
                      style: GoogleFonts.montserrat(
                          fontSize: 18.0, color: Colors.black),
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Type Here",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    child: IconButton(
                        icon: Icon(Icons.send,
                            size: 30.0,
                            color: chatController.text.length == 0
                                ? Colors.white.withOpacity(0.8)
                                : Colors.white),
                        onPressed: () {
                          print("Send Button Pressed");
                          var newMsgList = [];
                          print("Final date " + getDateAndTime()[0].toString());
                          List dateAndTime = getDateAndTime();
                          String finalDate = dateAndTime[0];
                          String finalTime = dateAndTime[1];
                          if (chatController.text.length != 0) {
                            Map<String, dynamic> data = {
                              "message": chatController.text,
                              "sender": user.phoneNo,
                              "time": DateTime.now().millisecondsSinceEpoch,
                              "isLastMessage": false,
                              "msgType": "text",
                              "msgDate": finalDate,
                              "msgTime": finalTime
                            };
                            DatabaseMethods().sendMessage(
                                roomId: this.widget.roomId, data: data);
                            DatabaseMethods().setLastMessage(
                                roomId: this.widget.roomId,
                                msgDate: finalDate,
                                msgTime: finalTime,
                                phoneNo: user.phoneNo,
                                msg: chatController.text);
                            DatabaseMethods()
                                .getNewMessageData(
                                    phone: user.phoneNo, roomId: widget.roomId)
                                .then((value) {
                              setState(() {
                                newMessageSnapshot = value;
                              });
                              var data = newMessageSnapshot.docs[0];
                              if (data.get('sentBy') == user.phoneNo) {
                                newMsgList = data.get('newMessages');
                              }
                            });
                            newMsgList.add(chatController.text);
                            DatabaseMethods().setNewMessages(
                                roomId: widget.roomId, msg: newMsgList);
                            chatController.text = "";
                            Future.delayed(Duration(milliseconds: 100), () {
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent +
                                      50,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeInOut);
                            });
                          } else {
                            print("No text to send");
                          }
                        }),
                  ),
                ],
              ),
            ),
          ) // Text box container
        ],
      ),
    ));
  }
}