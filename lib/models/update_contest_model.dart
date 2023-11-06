// To parse this JSON data, do
//
//     final updateContestResponse = updateContestResponseFromJson(jsonString);

import 'dart:convert';

UpdateContestResponse updateContestResponseFromJson(String str) => UpdateContestResponse.fromJson(json.decode(str));

String updateContestResponseToJson(UpdateContestResponse data) => json.encode(data.toJson());

class UpdateContestResponse {
  UpdateContestResponse({
    this.message,
    this.success,
  });

  String? message;
  bool? success;

  factory UpdateContestResponse.fromJson(Map<String, dynamic> json) => UpdateContestResponse(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}
