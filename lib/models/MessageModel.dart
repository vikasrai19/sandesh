class MessageModel {
  final String sender;
  final String msg;
  final String msgType;
  final int isMessageDel;
  final int isMessageRead;
  final String messageSentTime;
  final String messageDelTime;
  final String messageReadTime;
  final String time;

  MessageModel({
    this.sender,
    this.msg,
    this.msgType,
    this.isMessageDel,
    this.isMessageRead,
    this.messageSentTime,
    this.messageDelTime,
    this.messageReadTime,
    this.time,
  });

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'msg': msg,
        'msgType': msgType,
        'isMessageDel': isMessageDel,
        'isMessageRead': isMessageRead,
        'messageSentTime': messageSentTime,
        'messageDelTime': messageDelTime,
        'messageReadTime': messageReadTime,
        'time': time,
      };

  factory MessageModel.fromJson(Map<String, dynamic> data) => new MessageModel(
        sender: data['sender'],
        msg: data['msg'],
        msgType: data['msgType'],
        isMessageDel: data['isMessageDel'],
        isMessageRead: data['isMessageRead'],
        messageSentTime: data['messageSentTime'],
        messageDelTime: data['messageDelTime'],
        messageReadTime: data['messageReadTime'],
        time: data['time'],
      );
}
