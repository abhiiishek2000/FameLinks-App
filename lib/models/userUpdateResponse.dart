// To parse this JSON data, do
//
//     final userUpdatedResponse = userUpdatedResponseFromJson(jsonString);

import 'dart:convert';

UserUpdatedResponse userUpdatedResponseFromJson(String str) => UserUpdatedResponse.fromJson(json.decode(str));

String userUpdatedResponseToJson(UserUpdatedResponse data) => json.encode(data.toJson());

class UserUpdatedResponse {
  UserUpdatedResponse({
    this.message,
    this.success,
  });

  String? message;
  bool? success;

  factory UserUpdatedResponse.fromJson(Map<dynamic, dynamic> json) => UserUpdatedResponse(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}
