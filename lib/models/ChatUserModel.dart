class ChatUserModel {
  Data? data;
  String? message;
  bool? success;

  ChatUserModel({this.data, this.message, this.success});

  ChatUserModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['result'] != null ? new Data.fromJson(json['result']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['result'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  List<Result>? result;
  int? count;

  Data({this.result, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      result = <Result>[];
      json['data'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['data'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}


class Result {
  String? sId;
  String? title;
  String? profileImage;
  String? userId;
  String? type;
  String? date;
  String? time;
  bool? isGroup;
  String? createdAt;
  String? updatedAt;
  LastMessage? lastMessage;

  Result(
      {this.sId,
        this.title,
        this.profileImage,
        this.userId,
        this.type,
        this.date,
        this.time,
        this.isGroup,
        this.createdAt,
        this.updatedAt,
        this.lastMessage});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    profileImage = json['image'];
    userId = json['userId'];
    type = json['type'] != null ? json['type'] :"individual";
    date = json['date'];
    time = json['time'];
    isGroup = json['isGroup'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.profileImage;
    data['userId'] = this.userId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['isGroup'] = this.isGroup;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
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
