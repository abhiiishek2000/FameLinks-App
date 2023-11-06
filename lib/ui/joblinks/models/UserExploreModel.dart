// To parse this JSON data, do
//
//     final userExploreModel = userExploreModelFromJson(jsonString);

import 'dart:convert';

import 'package:famelink/ui/joblinks/models/FameJobsModel.dart';

UserExploreModel userExploreModelFromJson(String str) => UserExploreModel.fromJson(json.decode(str));

String userExploreModelToJson(UserExploreModel data) => json.encode(data.toJson());

class UserExploreModel {
    UserExploreModel({
        this.result,
        this.message,
        this.success,
    });

    List<UserExplore>? result;
    String? message;
    bool? success;

    factory UserExploreModel.fromJson(Map<dynamic, dynamic> json) => UserExploreModel(
        result: List<UserExplore>.from(json["result"].map((x) => UserExplore.fromJson(x))),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
        "success": success,
    };
}

class UserExplore {
    UserExplore({
        this.applied,
        this.hired,
        this.shortlisted,
        this.savedJobs,
    });

    List<Applied>? applied;
    List<Hired>? hired;
    List<Hired>? shortlisted;
    List<Applied>? savedJobs;

    factory UserExplore.fromJson(Map<String, dynamic> json) => UserExplore(
        applied: List<Applied>.from(json["applied"].map((x) => Applied.fromJson(x))),
        hired: List<Hired>.from(json["hired"].map((x) => Hired.fromJson(x))),
        shortlisted: List<Hired>.from(json["shortlisted"].map((x) => Hired.fromJson(x))),
        savedJobs: List<Applied>.from(json["savedJobs"].map((x) => Applied.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "applied": List<dynamic>.from(applied!.map((x) => x.toJson())),
        "hired": List<dynamic>.from(hired!.map((x) => x.toJson())),
        "shortlisted": List<dynamic>.from(shortlisted!.map((x) => x.toJson())),
        "savedJobs": List<dynamic>.from(savedJobs!.map((x) => x.toJson())),
    };
}

class Applied {
    Applied({
        this.id,
        this.jobType,
        this.title,
        this.jobLocation,
        this.description,
        this.experienceLevel,
        this.startDate,
        this.endDate,
        this.deadline,
        this.height,
        this.createdAt,
        this.jobDetails,
        this.chatId,
        this.ageGroup,
        this.gender,
        this.createdBy,
        this.appliedOn,
    });

    String? id;
    String? jobType;
    String? title;
    JobLocation? jobLocation;
    String? description;
    String? experienceLevel;
    DateTime? startDate;
    DateTime? endDate;
    DateTime? deadline;
    Height? height;
    DateTime? createdAt;
    List<JobDetail>? jobDetails;
    dynamic chatId;
    String? ageGroup;
    String? gender;
    List<CreatedBy>? createdBy;
    DateTime? appliedOn;

    factory Applied.fromJson(Map<String, dynamic> json) => Applied(
        id: json["_id"],
        jobType: json["jobType"],
        title: json["title"],
        jobLocation: JobLocation.fromJson(json["jobLocation"]),
        description: json["description"],
        experienceLevel: json["experienceLevel"] == null ? null : json["experienceLevel"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        deadline: DateTime.parse(json["deadline"]),
        height: Height.fromJson(json["height"]),
        createdAt: DateTime.parse(json["createdAt"]),
        jobDetails: List<JobDetail>.from(json["jobDetails"].map((x) => JobDetail.fromJson(x))),
        chatId: json["chatId"],
        ageGroup: json["ageGroup"] == null ? null : json["ageGroup"],
        gender: json["gender"] == null ? null : json["gender"],
        createdBy: List<CreatedBy>.from(json["createdBy"].map((x) => CreatedBy.fromJson(x))),
        appliedOn: json["appliedOn"] == null ? null : DateTime.parse(json["appliedOn"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "jobType": jobType,
        "title": title,
        "jobLocation": jobLocation!.toJson(),
        "description": description,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "deadline": deadline!.toIso8601String(),
        "height": height!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "jobDetails": List<dynamic>.from(jobDetails!.map((x) => x.toJson())),
        "chatId": chatId,
        "experienceLevel": experienceLevel == null ? null : experienceLevel,
        "ageGroup": ageGroup == null ? null : ageGroup,
        "gender": gender == null ? null : gender,
        "createdBy": List<dynamic>.from(createdBy!.map((x) => x.toJson())),
        "appliedOn": appliedOn == null ? null : appliedOn!.toIso8601String(),
    };
}

// class Height {
//     Height({
//         this.foot,
//         this.inch,
//     });

//     int foot;
//     int inch;

//     factory Height.fromJson(Map<String, dynamic> json) => Height(
//         foot: json["foot"],
//         inch: json["inch"],
//     );

//     Map<String, dynamic> toJson() => {
//         "foot": foot,
//         "inch": inch,
//     };
// }

// class JobDetail {
//     JobDetail({
//         this.jobName,
//         this.jobCategory,
//     });

//     String jobName;
//     String jobCategory;

//     factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
//         jobName: json["jobName"],
//         jobCategory: json["jobCategory"] == null ? null : json["jobCategory"],
//     );

//     Map<String, dynamic> toJson() => {
//         "jobName": jobName,
//         "jobCategory": jobCategory == null ? null : jobCategory,
//     };
// }

// class JobLocation {
//     JobLocation({
//         this.district,
//         this.state,
//         this.country,
//     });

//     String district;
//     String state;
//     String country;

//     factory JobLocation.fromJson(Map<String, dynamic> json) => JobLocation(
//         district: json["district"],
//         state: json["state"],
//         country: json["country"],
//     );

//     Map<String, dynamic> toJson() => {
//         "district": district,
//         "state": state,
//         "country": country,
//     };
// }

class Hired {
    Hired({
        this.id,
        this.jobType,
        this.title,
        this.jobLocation,
        this.description,
        this.startDate,
        this.endDate,
        this.deadline,
        this.ageGroup,
        this.height,
        this.gender,
        this.jobDetails,
        this.chatId,
        this.experienceLevel,
        this.createdAt,
        this.appliedOn,
        this.createdBy,
    });

    String? id;
    String? jobType;
    String? title;
    JobLocation? jobLocation;
    String? description;
    DateTime? startDate;
    DateTime? endDate;
    DateTime? deadline;
    String? ageGroup;
    Height? height;
    String? gender;
    List<JobDetail>? jobDetails;
    dynamic chatId;
    String? experienceLevel;
    DateTime? createdAt;
    DateTime? appliedOn;
    List<CreatedBy>? createdBy;

    factory Hired.fromJson(Map<String, dynamic> json) => Hired(
        id: json["_id"],
        jobType: json["jobType"],
        title: json["title"],
        jobLocation: JobLocation.fromJson(json["jobLocation"]),
        description: json["description"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        deadline: DateTime.parse(json["deadline"]),
        ageGroup: json["ageGroup"] == null ? null : json["ageGroup"],
        gender: json["gender"] == null ? null : json["gender"],
        height: Height.fromJson(json["height"]),
        jobDetails: List<JobDetail>.from(json["jobDetails"].map((x) => JobDetail.fromJson(x))),
        chatId: json["chatId"],
        experienceLevel: json["experienceLevel"] == null ? null : json["experienceLevel"],
        createdAt: DateTime.parse(json["createdAt"]),
        appliedOn: json["appliedOn"] != null ? DateTime.parse(json["appliedOn"]) : null,
        createdBy: List<CreatedBy>.from(json["createdBy"].map((x) => CreatedBy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "jobType": jobType,
        "title": title,
        "jobLocation": jobLocation!.toJson(),
        "description": description,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "deadline": deadline!.toIso8601String(),
        "height": height!.toJson(),
        "jobDetails": List<dynamic>.from(jobDetails!.map((x) => x.toJson())),
        "chatId": chatId,
        "experienceLevel": experienceLevel == null ? null : experienceLevel,
        "ageGroup": ageGroup == null ? null : ageGroup,
        "gender": gender == null ? null : gender,
        "createdAt": createdAt!.toIso8601String(),
        "appliedOn": appliedOn!.toIso8601String(),
        "createdBy": List<dynamic>.from(createdBy!.map((x) => x.toJson())),
    };
}
