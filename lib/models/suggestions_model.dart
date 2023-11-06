// To parse this JSON data, do
//
//     final mySuggestionsResponse = mySuggestionsResponseFromJson(jsonString);

import 'dart:convert';

MySuggestionsResponse mySuggestionsResponseFromJson(String str) => MySuggestionsResponse.fromJson(json.decode(str));

String mySuggestionsResponseToJson(MySuggestionsResponse data) => json.encode(data.toJson());

class MySuggestionsResponse {
  MySuggestionsResponse({
    this.result,
    this.message,
    this.success,
  });

  List<dynamic>? result;
  String? message;
  bool? success;

  factory MySuggestionsResponse.fromJson(Map<String, dynamic> json) => MySuggestionsResponse(
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
