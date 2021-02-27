import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/Controllers/MessageController.dart';
import 'package:sandesh/Widgets/UserDisplayTile.dart';

import 'ChatDetailsPage.dart';

class MessageCheckerPage extends StatelessWidget {
  final MessageController messageController = Get.find();
  @override
  Widget build(BuildContext context) {
    messageController.fetchLastMessages();
    return Scaffold(
      body: GetBuilder<MessageController>(
        builder: (controller) => StreamBuilder(
          stream: controller.lastMessageSnapshot,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      String name = messageController.getName(
                          snapshot.data.documents[index]['users'],
                          "+919448046877");
                      return name != null
                          ? GestureDetector(
                              onTap: () {
                                controller.getChatMessages(
                                    snapshot.data.documents[index]['name']);
                                Get.to(ChatDetailsPage(name: name));
                              },
                              child: UserDisplayTile(
                                  name: name,
                                  msg: snapshot
                                      .data.documents[index]['lastMessage']
                                      .toString(),
                                  time: "2.15"),
                            )
                          : Container();
                    },
                  )
                : Container(child: Center(child: Text("No Values")));
          },
        ),
      ),
    );
  }
}
