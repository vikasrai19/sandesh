import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/MessageController.dart';
import '../Widgets/MessageTile.dart';
import '../Widgets/MessageTile.dart';

class ChatDetailsPage extends StatelessWidget {
  final MessageController msgController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(bottom: 55.0),
                  height: Get.height,
                  width: Get.width,
                  // color: Colors.red,
                  child: StreamBuilder(
                    stream: msgController.chatMessageSnapshot,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment:
                                      msgController.checkMessageAlignment(
                                          snapshot.data.documents[index]
                                              ['sender']),
                                  margin: EdgeInsets.only(bottom: 5.0),
                                  child: MessageTile(
                                      message: snapshot.data.documents[index]
                                          ['message'],
                                      sender: snapshot.data.documents[index]
                                          ['sender']),
                                );
                              },
                            )
                          : Container(
                              child: Text("No data"),
                            );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  height: 60.0,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_emotions, color: Colors.grey, size: 30),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: msgController.msgController,
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              hintText: "Type Here",
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 18.0)),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: null,
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.orange),
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
