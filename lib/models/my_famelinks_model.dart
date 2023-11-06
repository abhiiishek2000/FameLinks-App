// To parse this JSON data, do
//
//     final myFamelinksResponse = myFamelinksResponseFromJson(jsonString);

import 'dart:convert';

MyFamelinksResponse myFamelinksResponseFromJson(String str) => MyFamelinksResponse.fromJson(json.decode(str));

String myFamelinksResponseToJson(MyFamelinksResponse data) => json.encode(data.toJson());

class MyFamelinksResponse {
  MyFamelinksResponse({
    this.result,
    this.message,
    this.success,
  });

  List<MyFameResult>? result;
  String? message;
  bool? success;

  factory MyFamelinksResponse.fromJson(Map<String, dynamic> json) => MyFamelinksResponse(
    result: json["result"] == null ? null : List<MyFameResult>.from(json["result"].map((x) => MyFameResult.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}

class MyFameResult {
  MyFameResult({
    this.id,
    this.maleSeen,
    this.femaleSeen,
    this.path,
    this.userId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.challengeId,
    this.likesCount,
  });

  String? id;
  int? maleSeen;
  int? femaleSeen;
  String? path;
  String? userId;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic challengeId;
  int? likesCount;

  factory MyFameResult.fromJson(Map<String, dynamic> json) => MyFameResult(
    id: json["_id"] == null ? null : json["_id"],
    maleSeen: json["maleSeen"] == null ? null : json["maleSeen"],
    femaleSeen: json["femaleSeen"] == null ? null : json["femaleSeen"],
    path: json["path"] == null ? null : json["path"],
    userId: json["userId"] == null ? null : json["userId"],
    type: json["type"] == null ? null : json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    challengeId: json["challengeId"],
    likesCount: json["likesCount"] == null ? null : json["likesCount"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "maleSeen": maleSeen == null ? null : maleSeen,
    "femaleSeen": femaleSeen == null ? null : femaleSeen,
    "path": path == null ? null : path,
    "userId": userId == null ? null : userId,
    "type": type == null ? null : type,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "challengeId": challengeId,
    "likesCount": likesCount == null ? null : likesCount,
  };
}
