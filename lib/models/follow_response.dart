// To parse this JSON data, do
//
//     final followResponse = followResponseFromJson(jsonString);

import 'dart:convert';

FollowResponse followResponseFromJson(String str) => FollowResponse.fromJson(json.decode(str));

String followResponseToJson(FollowResponse data) => json.encode(data.toJson());

class FollowResponse {
  FollowResponse({
    this.message,
    this.success,
  });

  String? message;
  bool? success;

  factory FollowResponse.fromJson(Map<dynamic, dynamic> json) => FollowResponse(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}
