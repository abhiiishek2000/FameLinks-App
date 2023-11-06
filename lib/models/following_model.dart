// To parse this JSON data, do
//
//     final myFollowingResponse = myFollowingResponseFromJson(jsonString);

import 'dart:convert';

MyFollowingResponse myFollowingResponseFromJson(String str) => MyFollowingResponse.fromJson(json.decode(str));

String myFollowingResponseToJson(MyFollowingResponse data) => json.encode(data.toJson());

class MyFollowingResponse {
  MyFollowingResponse({
    this.result,
    this.message,
    this.success,
  });

  List<dynamic>? result;
  String? message;
  bool? success;

  factory MyFollowingResponse.fromJson(Map<String, dynamic> json) => MyFollowingResponse(
    result: json["result"] == null ? null : List<dynamic>.from(json["result"].map((x) => x)),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result!.map((x) => x)),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}


