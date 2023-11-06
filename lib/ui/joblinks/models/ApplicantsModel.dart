// To parse this JSON data, do
//
//     final applicantsModel = applicantsModelFromJson(jsonString);

import 'dart:convert';

ApplicantsModel applicantsModelFromJson(String str) => ApplicantsModel.fromJson(json.decode(str));

String applicantsModelToJson(ApplicantsModel data) => json.encode(data.toJson());

class ApplicantsModel {
    ApplicantsModel({
        this.result,
        this.message,
        this.success,
    });

    List<Applicants>? result;
    String? message;
    bool? success;

    factory ApplicantsModel.fromJson(Map<dynamic, dynamic> json) => ApplicantsModel(
        result: List<Applicants>.from(json["result"].map((x) => Applicants.fromJson(x))),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
        "success": success,
    };
}

class Applicants {
    Applicants({
        this.id,
        this.applicants,
        this.hired,
        this.totalApplicants,
        this.newApplicants
    });

    String? id;
    List<Applicant>? applicants;
    int? hired;
    int? totalApplicants;
    int? newApplicants;

    factory Applicants.fromJson(Map<String, dynamic> json) => Applicants(
        id: json["_id"],
        applicants: List<Applicant>.from(json["applicants"].map((x) => Applicant.fromJson(x))),
        hired: json["Hired"],
        totalApplicants: json["totalApplicants"],
        newApplicants: json["newApplicants"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "applicants": List<dynamic>.from(applicants!.map((x) => x.toJson())),
        "Hired": hired,
        "totalApplicants": totalApplicants,
        "newApplicants": newApplicants,
    };
}

class Applicant {
    Applicant({
        this.id,
        this.name,
        this.status,
        this.updatedAt,
        this.profileImage,
        this.profileImageType,
        this.greetVideo,
        this.hiringProfile,
        this.masterProfile,
        this.posts,
        this.chatId,
    });

    String? id;
    String? name;
    String? status;
    DateTime? updatedAt;
    dynamic profileImage;
    String? profileImageType;
    String? greetVideo;
    HiringProfile? hiringProfile;
    MasterProfile? masterProfile;
    List<Post>? posts;
    dynamic chatId;
    bool? isShortlisted;
    bool? isHired;
    bool? isSwipe = true;
    bool? isPlaying = false;

    factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        profileImage: json["profileImage"],
        profileImageType: json["profileImageType"],
        greetVideo: json["greetVideo"],
        hiringProfile: HiringProfile.fromJson(json["hiringProfile"]),
        masterProfile: MasterProfile.fromJson(json["masterProfile"]),
        posts: json["posts"] == null ? null : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        chatId: json["chatId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "status": status,
        "updatedAt": updatedAt!.toIso8601String(),
        "profileImage": profileImage,
        "profileImageType": profileImageType,
        "greetVideo": greetVideo,
        "hiringProfile": hiringProfile!.toJson(),
        "masterProfile": masterProfile!.toJson(),
        "posts": List<dynamic>.from(posts!.map((x) => x.toJson())),
        "chatId": chatId,
    };
}

class HiringProfile {
    HiringProfile({
        this.height,
        this.weight,
        this.bust,
        this.waist,
        this.hip,
        this.eyeColor,
        this.complexion,
        this.workExperience,
        this.experienceLevel,
        this.achievements,
    });

    Height? height;
    int? weight;
    int? bust;
    int? waist;
    int? hip;
    String? eyeColor;
    String? complexion;
    String? experienceLevel;
    String? workExperience;
    String? achievements;

    factory HiringProfile.fromJson(Map<String, dynamic> json) => HiringProfile(
        height: json["height"] == null ? null : Height.fromJson(json["height"]),
        weight: json["weight"] == null ? null : json["weight"],
        bust: json["bust"] == null ? null : json["bust"],
        waist: json["waist"] == null ? null : json["waist"],
        hip: json["hip"] == null ? null : json["hip"],
        eyeColor: json["eyeColor"] == null ? null : json["eyeColor"],
        complexion: json["complexion"] == null ? null : json["complexion"],
        experienceLevel: json["experienceLevel"] == null ? null : json["experienceLevel"],
        workExperience: json["workExperience"] == null ? null : json["workExperience"],
        achievements: json["achievements"] == null ? null : json["achievements"],
    );

    Map<String, dynamic> toJson() => {
        "height": height!.toJson(),
        "weight": weight,
        "bust": bust,
        "waist": waist,
        "hip": hip,
        "eyeColor": eyeColor,
        "complexion": complexion,
        "experienceLevel": experienceLevel,
        "workExperience": workExperience,
        "achievements": achievements
    };
}

class Height {
    Height({
        this.foot,
        this.inch,
    });

    int? foot;
    int? inch;

    factory Height.fromJson(Map<String, dynamic> json) => Height(
        foot: json["foot"],
        inch: json["inch"],
    );

    Map<String, dynamic> toJson() => {
        "foot": foot,
        "inch": inch,
    };
}

class MasterProfile {
    MasterProfile({
        this.id,
        this.profileImage,
        this.followersCount,
        this.username,
        this.profileImageType,
        this.achievements,
        this.age,
    });

    String? id;
    String? profileImage;
    int? followersCount;
    String? username;
    String? profileImageType;
    String? achievements;
    int? age;

    factory MasterProfile.fromJson(Map<String, dynamic> json) => MasterProfile(
        id: json["_id"],
        profileImage: json["profileImage"],
        followersCount: json["followersCount"],
        username: json["username"],
        profileImageType: json["profileImageType"],
        achievements: json["achievements"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "profileImage": profileImage,
        "followersCount": followersCount,
        "username": username,
        "profileImageType": profileImageType,
        "achievements": achievements,
        "age": age,
    };
}

class Post {
    Post({
        this.id,
        this.closeUp,
        this.medium,
        this.long,
        this.pose1,
        this.pose2,
        this.additional,
        this.video,
    });

    String? id;
    dynamic closeUp;
    dynamic medium;
    dynamic long;
    String? pose1;
    dynamic pose2;
    dynamic additional;
    dynamic video;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        closeUp: json["closeUp"],
        medium: json["medium"],
        long: json["long"],
        pose1: json["pose1"],
        pose2: json["pose2"],
        additional: json["additional"],
        video: json["video"],
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
    };
}
