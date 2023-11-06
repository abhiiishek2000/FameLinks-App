// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);


import 'dart:convert';

OtpResponse otpResponseFromJson(String str) => OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  OtpResponse({
    this.result,
    this.message,
    this.success,
  });

  final Result? result;
  final String? message;
  final bool? success;

  factory OtpResponse.fromJson(Map<dynamic, dynamic> json) => OtpResponse(
    result: Result.fromJson(json["result"]),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result!.toJson(),
    "message": message,
    "success": success,
  };
}

class Result {
  Result({
    this.token,
    this.id,this.accountRecoveryOption
  });

  final String? token;
  final String? id;
  final bool? accountRecoveryOption;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    token: json["token"],
    id: json["_id"],
    accountRecoveryOption: json["accountRecoveryOption"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "_id": id,
  };
}
