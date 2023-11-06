// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.result,
    this.message,
    this.success,
  });

  final LoginResult? result;
  final String? message;
  final bool? success;

  factory LoginResponse.fromJson(Map<dynamic, dynamic> json) => LoginResponse(
    result: LoginResult.fromJson(json["result"]),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result!.toJson(),
    "message": message,
    "success": success,
  };
}

class LoginResult {
  LoginResult({
    this.expiryTimeInSeconds,
    this.otpHash,
  });

  final int? expiryTimeInSeconds;
  final String? otpHash;

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
    expiryTimeInSeconds: json["expiryTimeInSeconds"],
    otpHash: json["otpHash"],
  );

  Map<String, dynamic> toJson() => {
    "expiryTimeInSeconds": expiryTimeInSeconds,
    "otpHash": otpHash,
  };
}
