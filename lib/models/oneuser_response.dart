// To parse this JSON data, do
//
//     final oneUserResponse = oneUserResponseFromJson(jsonString);

import 'dart:convert';

OneUserResponse oneUserResponseFromJson(String str) => OneUserResponse.fromJson(json.decode(str));

String oneUserResponseToJson(OneUserResponse data) => json.encode(data.toJson());

class OneUserResponse {
  OneUserResponse({
    this.result,
    this.message,
    this.success,
  });

  List<Result>? result;
  String? message;
  bool? success;

  factory OneUserResponse.fromJson(Map<String, dynamic> json) => OneUserResponse(
    result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message == null ? null : message,
    "success": success == null ? null : success,
  };
}

class Result {
  Result({
    this.id,
    this.mobileNumber,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.gender,
    this.type,
    this.bio,
    this.profession,
    this.district,
    this.state,
    this.country,
    this.email,
    this.contest,
    this.isRegistered,
    this.followingCount,
    this.followersCount,
    this.likesCount,
    this.funlinks,
  });

  String? id;
  String? mobileNumber;
  DateTime? createdAt;
  int? updatedAt;
  String? name;
  String? gender;
  String? type;
  String? bio;
  String? profession;
  String? district;
  String? state;
  String? country;
  String? email;
  Contest? contest;
  bool? isRegistered;
  int? followingCount;
  int? followersCount;
  int? likesCount;
  List<Funlink>? funlinks;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"] == null ? null : json["_id"],
    mobileNumber: json["mobileNumber"] == null ? null : json["mobileNumber"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    name: json["name"] == null ? null : json["name"],
    gender: json["gender"] == null ? null : json["gender"],
    type: json["type"] == null ? null : json["type"],
    bio: json["bio"] == null ? null : json["bio"],
    profession: json["profession"] == null ? null : json["profession"],
    district: json["district"] == null ? null : json["district"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"] == null ? null : json["country"],
    email: json["email"] == null ? null : json["email"],
    contest: json["contest"] == null ? null : Contest.fromJson(json["contest"]),
    isRegistered: json["isRegistered"] == null ? null : json["isRegistered"],
    followingCount: json["followingCount"] == null ? null : json["followingCount"],
    followersCount: json["followersCount"] == null ? null : json["followersCount"],
    likesCount: json["likesCount"] == null ? null : json["likesCount"],
    funlinks: json["funlinks"] == null ? null : List<Funlink>.from(json["funlinks"].map((x) => Funlink.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "mobileNumber": mobileNumber == null ? null : mobileNumber,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt,
    "name": name == null ? null : name,
    "gender": gender == null ? null : gender,
    "type": type == null ? null : type,
    "bio": bio == null ? null : bio,
    "profession": profession == null ? null : profession,
    "district": district == null ? null : district,
    "state": state == null ? null : state,
    "country": country == null ? null : country,
    "email": email == null ? null : email,
    "contest": contest == null ? null : contest!.toJson(),
    "isRegistered": isRegistered == null ? null : isRegistered,
    "followingCount": followingCount == null ? null : followingCount,
    "followersCount": followersCount == null ? null : followersCount,
    "likesCount": likesCount == null ? null : likesCount,
    "funlinks": funlinks == null ? null : List<dynamic>.from(funlinks!.map((x) => x.toJson())),
  };
}

class Contest {
  Contest({
    this.challengeId,
    this.screenName,
    this.ethnicBackground,
    this.height,
    this.eyeColor,
    this.skinColor,
    this.vitals,
    this.closeUp,
    this.medium,
    this.long,
    this.pose1,
    this.pose2,
    this.additional,
    this.video,
    this.isRegistered,
  });

  String? challengeId;
  String? screenName;
  String? ethnicBackground;
  String? height;
  String? eyeColor;
  String? skinColor;
  String? vitals;
  Funlink? closeUp;
  Funlink? medium;
  Funlink? long;
  Funlink? pose1;
  Funlink? pose2;
  Funlink? additional;
  Funlink? video;
  bool? isRegistered;

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
    challengeId: json["challengeId"] == null ? null : json["challengeId"],
    screenName: json["screenName"] == null ? null : json["screenName"],
    ethnicBackground: json["ethnicBackground"] == null ? null : json["ethnicBackground"],
    height: json["height"] == null ? null : json["height"],
    eyeColor: json["eyeColor"] == null ? null : json["eyeColor"],
    skinColor: json["skinColor"] == null ? null : json["skinColor"],
    vitals: json["vitals"] == null ? null : json["vitals"],
    closeUp: json["closeUp"] == null ? null : Funlink.fromJson(json["closeUp"]),
    medium: json["medium"] == null ? null : Funlink.fromJson(json["medium"]),
    long: json["long"] == null ? null : Funlink.fromJson(json["long"]),
    pose1: json["pose1"] == null ? null : Funlink.fromJson(json["pose1"]),
    pose2: json["pose2"] == null ? null : Funlink.fromJson(json["pose2"]),
    additional: json["additional"] == null ? null : Funlink.fromJson(json["additional"]),
    video: json["video"] == null ? null : Funlink.fromJson(json["video"]),
    isRegistered: json["isRegistered"] == null ? null : json["isRegistered"],
  );

  Map<String, dynamic> toJson() => {
    "challengeId": challengeId == null ? null : challengeId,
    "screenName": screenName == null ? null : screenName,
    "ethnicBackground": ethnicBackground == null ? null : ethnicBackground,
    "height": height == null ? null : height,
    "eyeColor": eyeColor == null ? null : eyeColor,
    "skinColor": skinColor == null ? null : skinColor,
    "vitals": vitals == null ? null : vitals,
    "closeUp": closeUp == null ? null : closeUp!.toJson(),
    "medium": medium == null ? null : medium!.toJson(),
    "long": long == null ? null : long!.toJson(),
    "pose1": pose1 == null ? null : pose1!.toJson(),
    "pose2": pose2 == null ? null : pose2!.toJson(),
    "additional": additional == null ? null : additional!.toJson(),
    "video": video == null ? null : video!.toJson(),
    "isRegistered": isRegistered == null ? null : isRegistered,
  };
}

class Funlink {
  Funlink({
    this.id,
    this.maleSeen,
    this.femaleSeen,
    this.path,
    this.userId,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  int? maleSeen;
  int? femaleSeen;
  String? path;
  String? userId;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Funlink.fromJson(Map<String, dynamic> json) => Funlink(
    id: json["_id"] == null ? null : json["_id"],
    maleSeen: json["maleSeen"] == null ? null : json["maleSeen"],
    femaleSeen: json["femaleSeen"] == null ? null : json["femaleSeen"],
    path: json["path"] == null ? null : json["path"],
    userId: json["userId"] == null ? null : json["userId"],
    type: json["type"] == null ? null : json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "maleSeen": maleSeen == null ? null : maleSeen,
    "femaleSeen": femaleSeen == null ? null : femaleSeen,
    "path": path == null ? null : path,
    "userId": userId == null ? null : userId,
    "type": type == null ? null : type,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
