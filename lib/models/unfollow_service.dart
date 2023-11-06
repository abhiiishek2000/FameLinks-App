// To parse this JSON data, do
//
//     final unfollowResponse = unfollowResponseFromJson(jsonString);

import 'dart:convert';

UnfollowResponse unfollowResponseFromJson(String str) => UnfollowResponse.fromJson(json.decode(str));

String unfollowResponseToJson(UnfollowResponse data) => json.encode(data.toJson());

class UnfollowResponse {
  UnfollowResponse({
    this.message,
    this.success,
  });

  String? message;
  bool? success;

  factory UnfollowResponse.fromJson(Map<String, dynamic> json) => UnfollowResponse(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}
