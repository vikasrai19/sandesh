import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/Controllers/HomePageController.dart';
import 'package:sandesh/Controllers/MessageController.dart';
import 'package:sandesh/Widgets/UserDisplayTile.dart';

class MessageCheckerPage extends StatelessWidget {
  final messageController = Get.put(MessageController());
  @override
  Widget build(BuildContext context) {
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
                          ? UserDisplayTile(
                              name: name, msg: "Hello There", time: "2.15")
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
