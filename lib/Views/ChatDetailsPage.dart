import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailsPage extends StatelessWidget {
  final String chatRoomId;
  final String name;
  final String profileImg;

  const ChatDetailsPage({Key key, this.chatRoomId, this.name, this.profileImg})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.red,
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.1,
              width: Get.width,
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: this.profileImg == null ||
                                  this.profileImg.length == 0
                              ? Colors.grey
                              : Colors.white,
                        ),
                        child: this.profileImg == null ||
                                this.profileImg.length == 0
                            ? Center(child: Icon(Icons.person))
                            : Image.network(this.profileImg),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        this.name.toString(),
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
