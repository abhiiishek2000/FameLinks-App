// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.message,
    this.success,
  });

  final String? message;
  final bool? success;

  factory RegisterResponse.fromJson(Map<dynamic, dynamic> json) => RegisterResponse(
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
  };
}
