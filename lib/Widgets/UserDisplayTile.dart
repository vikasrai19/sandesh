import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDisplayTile extends StatefulWidget {
  final String name;
  final String msg;
  final String time;
  final bool isUnread;
  final int unreadCount;

  const UserDisplayTile({Key key, this.name, this.msg, this.time, this.isUnread = false, this.unreadCount = 0})
      : super(key: key);
  @override
  _UserDisplayTileState createState() => _UserDisplayTileState();
}

class _UserDisplayTileState extends State<UserDisplayTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 65.0,
      width: size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 55.0,
            width: 55.0,
            decoration:
                BoxDecoration(color: Colors.blue.withOpacity(0.5), shape: BoxShape.circle),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.msg,
                    maxLines: 1,
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0, color: Colors.black.withOpacity(0.8)),
                  )
                ],
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: 65,
              height: 55,
              child: Column(
                mainAxisAlignment: widget.isUnread ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                children: [
                  widget.isUnread ? Container(
                    alignment: Alignment.center,
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:Theme.of(context).primaryColor,
                    ),
                    child:Text(widget.unreadCount.toString(), style:GoogleFonts.montserrat(fontSize: 10.0, color:Colors.white) ,),
                  ) :Container(),
                  Text(widget.time,
                      style: GoogleFonts.montserrat(
                          fontSize: 12.0, color: Colors.black.withOpacity(0.7))),
                ],
              )),
        ],
      ),
    );
  }
}
