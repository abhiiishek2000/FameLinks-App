import 'dart:convert';

class Message {
  String? senderName;
  String? senderId;
  String? messageId;
  String? content;
  String? date;
  String? timeStamp;
  bool? isHeader = false;
  bool? isChatting = false;

  Message(this.senderName,this.senderId,this.messageId, this.content, this.date);

  bool isUserMessage(String senderId) => this.senderId == senderId;

   toJson() => {
        'userId': senderId,
        'body': content,
      };

  static Message fromJson(Map<String, dynamic> data) {
    return Message(
      "",
      data['senderId'],
      data['chatId'],
      data['body'],
      data['updatedAt'],
    );
  }

  @override
  bool operator ==(Object other) {
    if(other is Message){
      return other.messageId == messageId;
    }else{
      return false;
    }
  }

}
