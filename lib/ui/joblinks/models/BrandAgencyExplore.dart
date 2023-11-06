// To parse this JSON data, do
//
//     final brandAgencyModel = brandAgencyModelFromJson(jsonString);

import 'dart:convert';

BrandAgencyModel brandAgencyModelFromJson(String str) => BrandAgencyModel.fromJson(json.decode(str));

String brandAgencyModelToJson(BrandAgencyModel data) => json.encode(data.toJson());

class BrandAgencyModel {
    BrandAgencyModel({
        this.result,
        this.message,
        this.success,
    });

    Result? result;
    String? message;
    bool? success;

    factory BrandAgencyModel.fromJson(Map<dynamic, dynamic> json) => BrandAgencyModel(
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
        this.profiles,
        this.savedTalents,
    });

    List<Profile>? profiles;
    List<SavedTalent>? savedTalents;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        profiles: List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
        savedTalents: List<SavedTalent>.from(json["savedTalents"].map((x) => SavedTalent.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "profiles": List<dynamic>.from(profiles!.map((x) => x.toJson())),
        "savedTalents": List<dynamic>.from(savedTalents!.map((x) => x.toJson())),
    };
}

class Profile {
    Profile({
        this.id,
        this.name,
        this.profileImage,
        this.profileImageType,
        this.achievements,
        this.invitation,
    });

    String? id;
    String? name;
    dynamic profileImage;
    String? profileImageType;
    String? achievements;
    bool? invitation;

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["_id"],
        name: json["name"],
        profileImage: json["profileImage"],
        profileImageType: json["profileImageType"],
        achievements: json["achievements"],
        invitation: json["invitation"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profileImage": profileImage,
        "profileImageType": profileImageType,
        "achievements": achievements,
        "invitation": invitation,
    };
}

class SavedTalent {
    SavedTalent({
        this.id,
        this.name,
        this.profileImage,
        this.profileImageType,
        this.masterProfile,
    });

    String? id;
    String? name;
    dynamic profileImage;
    String? profileImageType;
    MasterProfile? masterProfile;

    factory SavedTalent.fromJson(Map<String, dynamic> json) => SavedTalent(
        id: json["_id"],
        name: json["name"],
        profileImage: json["profileImage"],
        profileImageType: json["profileImageType"],
        masterProfile: MasterProfile.fromJson(json["masterProfile"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profileImage": profileImage,
        "profileImageType": profileImageType,
        "masterProfile": masterProfile!.toJson(),
    };
}

class MasterProfile {
    MasterProfile({
        this.id,
        this.profileImage,
        this.profileImageType,
        this.followersCount,
        this.username,
        this.achievements,
        this.age,
    });

    String? id;
    String? profileImage;
    String? profileImageType;
    int? followersCount;
    String? username;
    String? achievements;
    int? age;

    factory MasterProfile.fromJson(Map<String, dynamic> json) => MasterProfile(
        id: json["_id"],
        profileImage: json["profileImage"],
        profileImageType: json["profileImageType"],
        followersCount: json["followersCount"],
        username: json["username"],
        achievements: json["achievements"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "profileImage": profileImage,
        "profileImageType": profileImageType,
        "followersCount": followersCount,
        "username": username,
        "achievements": achievements,
        "age": age,
    };
}
