// To parse this JSON data, do
//
//     final myNotificationResponse = myNotificationResponseFromJson(jsonString);

import 'dart:convert';

MyNotificationResponse myNotificationResponseFromJson(String str) => MyNotificationResponse.fromJson(json.decode(str));

String myNotificationResponseToJson(MyNotificationResponse data) => json.encode(data.toJson());

class MyNotificationResponse {
  MyNotificationResponse({
    this.result,
    this.message,
    this.success,
  });

  List<Result>? result;
  String? message;
  bool? success;

  factory MyNotificationResponse.fromJson(Map<dynamic, dynamic> json) => MyNotificationResponse(
    result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}

class Result {
  Result({
    this.id,
    this.type,
    this.postType,
    this.source,
    this.data,
    this.action,
    this.body,
    this.durationTime,
    this.createdAt,
    this.updatedAt,
    this.sourceId,
    this.targetMedia,
    this.sourceMedia,
    this.targetId,
    this.userId,
    this.sourceType,
  });

  String? id;
  String? type;
  String? postType;
  String? body;
  String? source;
  String? action;
  String? data;
  String? durationTime;
  String? createdAt;
  String? updatedAt;
  String? sourceId;
  String? targetMedia;
  String? sourceMedia;
  String? targetId;
  String? userId;
  String? sourceType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"] == null ? null : json["_id"],
    type: json["type"] == null ? null : json["type"],
    postType: json["postType"] == null ? null : json["postType"],
    body: json["body"] == null ? null : json["body"],
    source: json["source"] == null ? null : json["source"],
    data: json["data"] == null ? null : json["data"],
    action: json["action"] == null ? null : json["action"],
    createdAt: json["createdAt"] == null ? null : json["createdAt"],
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    durationTime: json["durationTime"] == null ? null : json["durationTime"],
    sourceId: json["sourceId"] == null ? null : json["sourceId"],
    targetMedia: json["targetMedia"] == null ? null : json["targetMedia"],
    sourceMedia: json["sourceMedia"] == null ? null : json["sourceMedia"],
    targetId: json["targetId"] == null ? null : json["targetId"],
    userId: json["userId"] == null ? null : json["userId"],
    sourceType: json["sourceType"] == null ? "individual" : json["sourceType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "type": type == null ? null : type,
    "postType": postType == null ? null : postType,
    "body": body == null ? null : body,
    "source": source == null ? null : source,
    "data": data == null ? null : data,
    "action": action == null ? null : action,
    "durationTime": durationTime == null ? null : durationTime,
    "createdAt": createdAt == null ? null : createdAt,
    "updatedAt": updatedAt == null ? null : updatedAt,
    "sourceId": sourceId == null ? null : sourceId,
    "targetMedia": targetMedia == null ? null : targetMedia,
    "sourceMedia": sourceMedia == null ? null : sourceMedia,
    "targetId": targetId == null ? null : targetId,
    "userId": userId == null ? null : userId,
    "sourceType": sourceType == null ? null : sourceType,
  };
}
