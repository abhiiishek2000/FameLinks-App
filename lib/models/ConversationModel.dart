class ConversationModel {
  List<Chat>? result;
  String? message;
  bool? success;

  ConversationModel({this.result, this.message, this.success});

  ConversationModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <Chat>[];
      json['result'].forEach((v) {
        result!.add(new Chat.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Chat {
  String? sId;
  String? title;
  bool? isGroup;
  String? date;
  String? time;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<String>? readBy;
  LastMessage? lastMessage;
  String? image;
  String? userId;

  Chat(
      {this.sId,
        this.title,
        this.isGroup,
        this.readBy,
        this.createdAt,
        this.updatedAt,
        this.date,
        this.time,
        this.type,
        this.lastMessage,
        this.image,
        this.userId});

  Chat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    isGroup = json['isGroup'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    readBy = json['readBy'].cast<String>();
    date = json['date'];
    time = json['time'];
    type = json['type'] != null ? json['type'] :"individual";
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    image = json['image'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['isGroup'] = this.isGroup;
    data['readBy'] = this.readBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['date'] = this.date;
    data['time'] = this.time;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['image'] = this.image;
    data['userId'] = this.userId;
    return data;
  }
}

class LastMessage {
  String? sId;
  String? senderId;
  String? body;
  Null? quote;
  String? type;
  String? chatId;
  String? createdAt;
  String? updatedAt;

  LastMessage(
      {this.sId,
        this.senderId,
        this.body,
        this.quote,
        this.type,
        this.chatId,
        this.createdAt,
        this.updatedAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'];
    body = json['body'];
    quote = json['quote'];
    type = json['type'];
    chatId = json['chatId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['senderId'] = this.senderId;
    data['body'] = this.body;
    data['quote'] = this.quote;
    data['type'] = this.type;
    data['chatId'] = this.chatId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
