// To parse this JSON data, do
//
//     final fameJobsModel = fameJobsModelFromJson(jsonString);

import 'dart:convert';

FameJobsModel fameJobsModelFromJson(String str) => FameJobsModel.fromJson(json.decode(str));

String fameJobsModelToJson(FameJobsModel data) => json.encode(data.toJson());

class FameJobsModel {
    FameJobsModel({
        this.result,
        this.message,
        this.success,
    });

    List<jobs>? result;
    String? message;
    bool? success;

    factory FameJobsModel.fromJson(Map<String, dynamic> json) => FameJobsModel(
        result: List<jobs>.from(json["result"].map((x) => jobs.fromJson(x))),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
        "success": success,
    };
}

class jobs {
    jobs({
        this.id,
        this.createdBy,
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
        this.savedStatus,
        this.ageGroup,
        this.gender,
        this.applicationsStatus,
    });

    String? id;
    List<CreatedBy>? createdBy;
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
    bool? savedStatus;
    String? ageGroup;
    String? gender;
    String? applicationsStatus;
    bool? isSwipe = true;

    factory jobs.fromJson(Map<String, dynamic> json) => jobs(
        id: json["_id"],
        createdBy: json["createdBy"] == null ? null :List<CreatedBy>.from(json["createdBy"].map((x) => CreatedBy.fromJson(x))),
        jobType: json["jobType"],
        title: json["title"],
        jobLocation: JobLocation.fromJson(json["jobLocation"]),
        description: json["description"],
        experienceLevel: json["experienceLevel"] == null ? null : json["experienceLevel"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        deadline: DateTime.parse(json["deadline"]),
        height: Height.fromJson(json["height"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        jobDetails: List<JobDetail>.from(json["jobDetails"].map((x) => JobDetail.fromJson(x))),
        savedStatus: json["savedStatus"],
        ageGroup: json["ageGroup"] == null ? null : json["ageGroup"],
        gender: json["gender"] == null ? null : json["gender"],
        applicationsStatus: json["applicationsStatus"] == null ? null : json["applicationsStatus"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy == null ? null : List<dynamic>.from(createdBy!.map((x) => x.toJson())),
        "jobType": jobType,
        "title": title,
        "jobLocation": jobLocation!.toJson(),
        "description": description,
        "experienceLevel": experienceLevel == null ? null : experienceLevel,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "deadline": deadline!.toIso8601String(),
        "height": height!.toJson(),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "jobDetails": List<dynamic>.from(jobDetails!.map((x) => x.toJson())),
        "savedStatus": savedStatus,
        "ageGroup": ageGroup == null ? null : ageGroup,
        "gender": gender == null ? null : gender,
        "applicationsStatus": applicationsStatus == null ? null : applicationsStatus
    };
}

class CreatedBy {
    CreatedBy({
        this.id,
        this.name,
        this.profileImage,
        this.profileImageType,
    });

    String? id;
    String? name;
    String? profileImage;
    String ?profileImageType;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"],
        profileImage: json["profileImage"] == null ? null : json["profileImage"],
        profileImageType: json["profileImageType"] == null ? null : json["profileImageType"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name,
        "profileImage": profileImage == null ? null : profileImage,
        "profileImageType": profileImageType == null ? null : profileImageType
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

class JobDetail {
    JobDetail({
        this.jobName,
        this.jobType,
        this.jobCategory,
    });

    String? jobName;
    String? jobType;
    String? jobCategory;

    factory JobDetail.fromJson(Map<String, dynamic> json) => JobDetail(
        jobName: json["jobName"],
        jobType: json["jobType"],
        jobCategory: json["jobCategory"] == null ? null : json["jobCategory"],
    );

    Map<String, dynamic> toJson() => {
        "jobName": jobName,
        "jobType": jobType,
        "jobCategory": jobCategory == null ? null : jobCategory,
    };
}

class JobLocation {
    JobLocation({
        this.district,
        this.state,
        this.country,
    });

    String? district;
    String? state;
    String? country;

    factory JobLocation.fromJson(Map<String, dynamic> json) => JobLocation(
        district: json["district"],
        state: json["state"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "district": district,
        "state": state,
        "country": country,
    };
}
