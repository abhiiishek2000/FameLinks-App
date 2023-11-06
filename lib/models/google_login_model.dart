// To parse this JSON data, do
//
//     final googleLoginResponse = googleLoginResponseFromJson(jsonString);

import 'dart:convert';

GoogleLoginResponse googleLoginResponseFromJson(String str) => GoogleLoginResponse.fromJson(json.decode(str));

String googleLoginResponseToJson(GoogleLoginResponse data) => json.encode(data.toJson());

class GoogleLoginResponse {
  GoogleLoginResponse({
    this.result,
    this.message,
    this.success,
  });

  Result? result;
  String? message;
  bool? success;

  factory GoogleLoginResponse.fromJson(Map<dynamic, dynamic> json) => GoogleLoginResponse(
    result: Result.fromJson(json["result"]),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result!.toJson(),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };

}
class Result {
  Result({
    this.token,
    this.id,
  });

  final String? token;
  final String? id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    token: json["token"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "_id": id,
  };
}
