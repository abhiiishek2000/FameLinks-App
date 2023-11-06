class JobInvitesResult {
  List<JobInvitesModel>? result;
  String? message;
  bool? success;

  JobInvitesResult({this.result, this.message, this.success});

  JobInvitesResult.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <JobInvitesModel>[];
      json['result'].forEach((v) {
        result!.add(new JobInvitesModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class JobInvitesModel {
  String? sId;
  String? jobId;
  String? from;
  String? to;
  String? status;
  String? category;
  String? createdAt;
  String? updatedAt;
  List<JobDetails>? jobDetails;
  int? invitesCount;
  bool? expanded;

  JobInvitesModel({
    this.sId,
    this.jobId,
    this.from,
    this.to,
    this.status,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.jobDetails,
    this.invitesCount,
    this.expanded,
  });

  JobInvitesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobId = json['jobId'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
    category = json['category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['jobDetails'] != null) {
      jobDetails = <JobDetails>[];
      json['jobDetails'].forEach((v) {
        jobDetails!.add(new JobDetails.fromJson(v));
      });
    }
    invitesCount = json['invitesCount'];
    expanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['jobId'] = this.jobId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['status'] = this.status;
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.jobDetails != null) {
      data['jobDetails'] = this.jobDetails!.map((v) => v.toJson()).toList();
    }
    data['invitesCount'] = this.invitesCount;
    data['expanded'] = this.expanded;
    return data;
  }
}

class JobDetails {
  String? sId;
  List<CreatedBy>? createdBy;
  String? jobType;
  String? title;
  JobLocation? jobLocation;
  String? description;
  String? startDate;
  String? endDate;
  String? deadline;
  String? ageGroup;
  Height? height;
  String? gender;
  List<JobCategory>? jobCategory;
  bool? isClosed;
  String? experienceLevel;

  JobDetails(
      {this.sId,
      this.createdBy,
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
      this.jobCategory,
      this.isClosed,
      this.experienceLevel});

  JobDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['createdBy'] != null) {
      createdBy = <CreatedBy>[];
      json['createdBy'].forEach((v) {
        createdBy!.add(new CreatedBy.fromJson(v));
      });
    }
    jobType = json['jobType'];
    title = json['title'];
    jobLocation = json['jobLocation'] != null
        ? new JobLocation.fromJson(json['jobLocation'])
        : null;
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    deadline = json['deadline'];
    ageGroup = json['ageGroup'];
    height =
        json['height'] != null ? new Height.fromJson(json['height']) : null;
    gender = json['gender'];
    if (json['jobCategory'] != null) {
      jobCategory = <JobCategory>[];
      json['jobCategory'].forEach((v) {
        jobCategory!.add(new JobCategory.fromJson(v));
      });
    }
    isClosed = json['isClosed'];
    experienceLevel = json['experienceLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy!.map((v) => v.toJson()).toList();
    }
    data['jobType'] = this.jobType;
    data['title'] = this.title;
    if (this.jobLocation != null) {
      data['jobLocation'] = this.jobLocation!.toJson();
    }
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['deadline'] = this.deadline;
    data['ageGroup'] = this.ageGroup;
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    data['gender'] = this.gender;
    if (this.jobCategory != null) {
      data['jobCategory'] = this.jobCategory!.map((v) => v.toJson()).toList();
    }
    data['isClosed'] = this.isClosed;
    data['experienceLevel'] = this.experienceLevel;
    return data;
  }
}

class CreatedBy {
  String? sId;
  String? name;
  String? profileImage;
  String? profileImageType;

  CreatedBy({this.sId, this.name, this.profileImage, this.profileImageType});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}

class JobLocation {
  String? district;
  String? state;
  String? country;

  JobLocation({this.district, this.state, this.country});

  JobLocation.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class Height {
  int? foot;
  int? inch;

  Height({this.foot, this.inch});

  Height.fromJson(Map<String, dynamic> json) {
    foot = json['foot'];
    inch = json['inch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foot'] = this.foot;
    data['inch'] = this.inch;
    return data;
  }
}

class JobCategory {
  String? sId;
  String? jobName;
  List<String>? jobCategory;

  JobCategory({this.sId, this.jobName, this.jobCategory});

  JobCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobName = json['jobName'];
    // jobCategory = json['jobCategory'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['jobName'] = this.jobName;
    data['jobCategory'] = this.jobCategory;
    return data;
  }
}
