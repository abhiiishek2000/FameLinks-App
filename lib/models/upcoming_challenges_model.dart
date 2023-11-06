// To parse this JSON data, do
//
//     final upcomingChallengesResponse = upcomingChallengesResponseFromJson(jsonString);

import 'dart:convert';

UpcomingChallengesResponse upcomingChallengesResponseFromJson(String str) => UpcomingChallengesResponse.fromJson(json.decode(str));

String upcomingChallengesResponseToJson(UpcomingChallengesResponse data) => json.encode(data.toJson());

class UpcomingChallengesResponse {
  UpcomingChallengesResponse({
    this.result,
    this.message,
    this.success,
  });

  List<UpcomingChallengesResult>? result;
  String? message;
  bool? success;

  factory UpcomingChallengesResponse.fromJson(Map<dynamic, dynamic> json) => UpcomingChallengesResponse(
    result: json["result"] == null ? null : List<UpcomingChallengesResult>.from(json["result"].map((x) => UpcomingChallengesResult.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}

class UpcomingChallengesResult {
  UpcomingChallengesResult({
    this.id,
    this.images,
    this.users,
    this.hashTag,
    this.sponsor,
    this.description,
    this.reward,
    this.startDate,
    this.endDate,
    this.type,
  });

  String? id;
  List<String>? images;
  List<Users>? users;
  String? hashTag;
  List<Sponsor>? sponsor;
  String? description;
  String? reward;
  String? startDate;
  String? endDate;
  String? type;

  factory UpcomingChallengesResult.fromJson(Map<String, dynamic> json) => UpcomingChallengesResult(
    id: json["_id"] == null ? null : json["_id"],
    hashTag: json["hashTag"] == null ? null : json["hashTag"],
    images: json["images"] == null ? null : json['images'].cast<String>(),
    users : json["users"] == null ? [] : List<Users>.from(json["users"].map((x) => Users.fromJson(x))),
    sponsor : json["sponsor"] == null ? [] : List<Sponsor>.from(json["sponsor"].map((x) => Sponsor.fromJson(x))),
    description: json["description"] == null ? null : json["description"],
    reward: json["reward"] == null ? null : json["reward"],
    startDate: json["startDate"] == null ? null : json["startDate"],
    endDate: json["endDate"] == null ? null : json["endDate"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": hashTag == null ? null : hashTag,
    "images": images == null ? null : images,
    "users": users == null ? null : users,
    "sponsor": sponsor == null ? null : sponsor,
    "description": description == null ? null : description,
    "reward": reward == null ? null : reward,
    "startDate": startDate == null ? null : startDate,
    "endDate": endDate == null ? null : endDate,
    "type": type == null ? null : type,
  };
}
class Sponsor {
  String? name;
  String? profileImage;
  String? profileImageType;

  Sponsor({this.name, this.profileImage, this.profileImageType});

  Sponsor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}
class Users {
  String? sId;
  String? name;
  String? type;

  Users({this.sId, this.name, this.type});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}