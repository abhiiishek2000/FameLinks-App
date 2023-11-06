import 'package:intl/intl.dart';

class ChatMessageModel {
  Result? result;
  String? message;
  bool? success;

  ChatMessageModel({this.result, this.message, this.success});

  ChatMessageModel.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}
class Result {
  List<ChatMessageResult>? messages;
  List<String>? readBy;

  Result({this.messages, this.readBy});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <ChatMessageResult>[];
      json['messages'].forEach((v) {
        messages!.add(new ChatMessageResult.fromJson(v));
      });
    }
    readBy = json['readBy'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['readBy'] = this.readBy;
    return data;
  }
}

class ChatMessageResult {
  String? sId;
  String? senderId;
  String? body;
  String? type;
  String? chatId;
  String? createdAt;
  String? updatedAt;
  User? user;

  String get date {
    String dateTime = DateFormat("EEE dd MMM yy").format(DateTime.parse(updatedAt!));
    String today = DateFormat("EEE dd MMM yy").format(DateTime.now());
    return dateTime == today ?"Today":dateTime;
  }

  ChatMessageResult(
      {this.sId,
        this.senderId,
        this.body,
        this.type,
        this.chatId,
        this.createdAt,
        this.updatedAt,
        this.user});


  ChatMessageResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'];
    body = json['body'];
    type = json['type'];
    chatId = json['chatId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['senderId'] = this.senderId;
    data['body'] = this.body;
    data['type'] = this.type;
    data['chatId'] = this.chatId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;

  User({this.sId, this.name});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
