import 'package:flutter/foundation.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';

class DatabaseHelper extends ChangeNotifier {
  String _message;
  String _sender;
  int _time;
  String _messageDate;
  String _messageTime;
  String _roomId;

  getUserId() {
    HelperFunction.getUserUid().then((value) => _sender = value);
  }

  set message(String val) => _message = val;
  set roomId(String val) => _roomId = val;

  List getDateAndTime() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var finalDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    var finalTime = "${dateParse.hour}-${dateParse.minute}";
    return [finalDate, finalTime];
  }

  // Sending text messages to database
  sendTextMessage() {
    List dateAndTime = getDateAndTime();
    String _messageDate = dateAndTime[0];
    String _messageTime = dateAndTime[1];
    DatabaseMethods().sendMessage(roomId: _roomId, data: {
      "message": _message,
      "sender": _sender,
      "time": DateTime.now().millisecondsSinceEpoch,
      "isLastMessage": false,
      "msgType": "text",
      "msgDate": _messageDate,
      "msgTime": _messageTime
    });
  }

  setLastTextMessage() {
    DatabaseMethods().setLastMessage(
        roomId: _roomId,
        msg: _message,
        msgDate: _messageDate,
        msgTime: _messageTime,
        phoneNo: _sender);
  }
}
