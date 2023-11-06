// To parse this JSON data, do
//
//     final jobCategoriesModel = jobCategoriesModelFromJson(jsonString);

import 'dart:convert';

JobCategoriesModel jobCategoriesModelFromJson(String str) => JobCategoriesModel.fromJson(json.decode(str));

String jobCategoriesModelToJson(JobCategoriesModel data) => json.encode(data.toJson());

class JobCategoriesModel {
    JobCategoriesModel({
        this.result,
        this.message,
        this.success,
    });

    List<JobCategories>? result;
    String? message;
    bool? success;

    factory JobCategoriesModel.fromJson(Map<String, dynamic> json) => JobCategoriesModel(
        result: List<JobCategories>.from(json["result"].map((x) => JobCategories.fromJson(x))),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message,
        "success": success,
    };
}

class JobCategories {
    JobCategories({
        this.id,
        this.jobName,
        this.jobType,
        this.userType,
        this.jobCategory,
    });

    String? id;
    String? jobName;
    String? jobType;
    List<String>? userType;
    dynamic jobCategory;
    bool? isSelected;

    factory JobCategories.fromJson(Map<String, dynamic> json) => JobCategories(
        id: json["_id"],
        jobName: json["jobName"],
        jobType: json["jobType"],
        userType: List<String>.from(json["userType"].map((x) => x)),
        jobCategory: json["jobCategory"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "jobName": jobName,
        "jobType": jobType,
        "userType": List<dynamic>.from(userType!.map((x) => x)),
        "jobCategory": jobCategory,
    };
}
