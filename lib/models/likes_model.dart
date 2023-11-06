// To parse this JSON data, do
//
//     final likesResponse = likesResponseFromJson(jsonString);

import 'dart:convert';

LikesResponse likesResponseFromJson(String str) => LikesResponse.fromJson(json.decode(str));

String likesResponseToJson(LikesResponse data) => json.encode(data.toJson());

class LikesResponse {
    LikesResponse({
        this.result,
        this.message,
        this.success,
    });

    LikesResponseResult? result;
    String? message;
    bool? success;

    factory LikesResponse.fromJson(Map<dynamic, dynamic> json) => LikesResponse(
        result: LikesResponseResult.fromJson(json["result"]),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "message": message,
        "success": success,
    };
}

class LikesResponseResult {
    LikesResponseResult({
        this.id,
        this.closeUp,
        this.medium,
        this.long,
        this.pose1,
        this.pose2,
        this.additional,
        this.video,
        this.challengeId,
        this.description,
        this.district,
        this.state,
        this.country,
        this.userId,
        this.maleSeen,
        this.femaleSeen,
        this.likesCount,
        this.likes0Count,
        this.likes1Count,
        this.likes2Count,
        this.commentsCount,
        this.isBlocked,
        this.isDeleted,
        this.isSafe,
        this.ambassadorTrendz,
        this.famelinksContest,
        this.createdAt,
        this.updatedAt,
    });

    String? id;
    dynamic closeUp;
    dynamic medium;
    dynamic long;
    dynamic pose1;
    String?pose2;
    dynamic additional;
    dynamic video;
    List<String>? challengeId;
    String? description;
    String? district;
    String? state;
    String? country;
    String? userId;
    int? maleSeen;
    int? femaleSeen;
    int? likesCount;
    int? likes0Count;
    int? likes1Count;
    int? likes2Count;
    int? commentsCount;
    bool? isBlocked;
    bool? isDeleted;
    bool? isSafe;
    bool? ambassadorTrendz;
    bool? famelinksContest;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory LikesResponseResult.fromJson(Map<String, dynamic> json) => LikesResponseResult(
        id: json["_id"],
        closeUp: json["closeUp"],
        medium: json["medium"],
        long: json["long"],
        pose1: json["pose1"],
        pose2: json["pose2"],
        additional: json["additional"],
        video: json["video"],
        challengeId: List<String>.from(json["challengeId"].map((x) => x)),
        description: json["description"],
        district: json["district"],
        state: json["state"],
        country: json["country"],
        userId: json["userId"],
        maleSeen: json["maleSeen"],
        femaleSeen: json["femaleSeen"],
        likesCount : json["likesCount"],
        likes0Count: json["likes0Count"],
        likes1Count: json["likes1Count"],
        likes2Count: json["likes2Count"],
        commentsCount: json["commentsCount"],
        isBlocked: json["isBlocked"],
        isDeleted: json["isDeleted"],
        isSafe: json["isSafe"],
        ambassadorTrendz: json["ambassadorTrendz"],
        famelinksContest: json["famelinksContest"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "closeUp": closeUp,
        "medium": medium,
        "long": long,
        "pose1": pose1,
        "pose2": pose2,
        "additional": additional,
        "video": video,
        "challengeId": List<dynamic>.from(challengeId!.map((x) => x)),
        "description": description,
        "district": district,
        "state": state,
        "country": country,
        "userId": userId,
        "maleSeen": maleSeen,
        "femaleSeen": femaleSeen,
        "likesCount" : likesCount,
        "likes0Count": likes0Count,
        "likes1Count": likes1Count,
        "likes2Count": likes2Count,
        "commentsCount": commentsCount,
        "isBlocked": isBlocked,
        "isDeleted": isDeleted,
        "isSafe": isSafe,
        "ambassadorTrendz": ambassadorTrendz,
        "famelinksContest": famelinksContest,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
    };
}
