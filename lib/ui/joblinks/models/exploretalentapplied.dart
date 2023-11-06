/// result : [{"_id":"64ad4da1d6ee9a4a9ce5eff8","createdBy":[{"_id":"63fcc0d6dbc4fa3dbb872c86","name":"Naznin Developer","profileImage":"famelinks-6d6c5a6c-c811-4723-b816-06bfb283c56b-xs","profileImageType":"avatar"}],"jobType":"faces","title":"Models required for Ethenic Wear shoot","jobLocation":{"district":"mumbai","state":"maharashtra","country":"india"},"description":"Apply for agency job faces","startDate":"2022-08-10T00:00:00.000Z","endDate":"2022-08-20T00:00:00.000Z","deadline":"2022-08-07T00:00:00.000Z","ageGroup":"groupD","height":{"foot":5,"inch":6},"gender":"female","createdAt":"2023-07-11T12:40:01.701Z","appliedOn":"2023-07-11T05:14:26.423Z","applicationId":"64ace5327150ab944dd38a9a","jobDetails":[{"_id":"64a65f7b4cf51ae0197032b3","jobName":"Photo Shoots","jobCategory":["Print Ad Shoot, Digital Media, Corporator"]},{"_id":"64a660304cf51ae0197032bd","jobName":"Video Shoots","jobCategory":["Ad Shoot, Song Shoot, Short Films, Documentary Shoot"]}],"chatId":null},{"_id":"64af9b8e5ac28823d5c3c634","createdBy":[{"_id":"63fd9fbaebccee8e597db8fb","name":"abhi job","profileImage":"famelinks-6d6c5a6c-c811-4723-b816-06bfb283c56b-xs","profileImageType":"avatar"}],"jobType":"crew","title":"test crew","jobLocation":{"district":"varanasi","state":"uttar pradesh","country":"india"},"description":"tesdis","experienceLevel":"experienced","startDate":"2023-07-13T00:00:00.000Z","endDate":"2023-07-21T00:00:00.000Z","deadline":"2023-07-22T00:00:00.000Z","height":{"foot":0,"inch":0},"createdAt":"2023-07-13T06:37:02.837Z","appliedOn":"2023-07-11T05:14:26.423Z","applicationId":"64b251240f3e00f877d948b9","jobDetails":[{"_id":"64a646164d602ad0089ee812","jobName":"Hair Stylist","jobCategory":null},{"_id":"64a646904d602ad0089ee826","jobName":"Mehandi Art","jobCategory":null},{"_id":"64a648999039244005454f40","jobName":"Designer","jobCategory":null}],"chatId":null},{"_id":"64b00fcc1aa730d6fe74eb55","createdBy":[{"_id":"63fcc0d6dbc4fa3dbb872c86","name":"Naznin Developer","profileImage":"famelinks-6d6c5a6c-c811-4723-b816-06bfb283c56b-xs","profileImageType":"avatar"}],"jobType":"crew","title":"Hair Stylist required at pune","jobLocation":{"district":"mumbai","state":"maharashtra","country":"india"},"description":"Apply for agency job crew","experienceLevel":"fresher","startDate":"2022-08-10T00:00:00.000Z","endDate":"2022-08-20T00:00:00.000Z","deadline":"2022-08-07T00:00:00.000Z","height":{"foot":0,"inch":0},"createdAt":"2023-07-11T10:45:01.757Z","appliedOn":"2023-07-17T07:12:47.041Z","applicationId":"64b4e9ef25263820ac24681f","jobDetails":[{"_id":"64a646164d602ad0089ee812","jobName":"Hair Stylist","jobCategory":null}],"chatId":null}]
/// message : "Applied jobs fetched succesfuly"
/// success : true

class Exploretalentapplied {
  Exploretalentapplied({
    this.result,
    this.message,
    this.success,
  });

  Exploretalentapplied.fromJson(dynamic json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }
  List<Result>? result;
  String? message;
  bool? success;
  Exploretalentapplied copyWith({
    List<Result>? result,
    String? message,
    bool? success,
  }) =>
      Exploretalentapplied(
        result: result ?? this.result,
        message: message ?? this.message,
        success: success ?? this.success,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['success'] = success;
    return map;
  }
}

/// _id : "64ad4da1d6ee9a4a9ce5eff8"
/// createdBy : [{"_id":"63fcc0d6dbc4fa3dbb872c86","name":"Naznin Developer","profileImage":"famelinks-6d6c5a6c-c811-4723-b816-06bfb283c56b-xs","profileImageType":"avatar"}]
/// jobType : "faces"
/// title : "Models required for Ethenic Wear shoot"
/// jobLocation : {"district":"mumbai","state":"maharashtra","country":"india"}
/// description : "Apply for agency job faces"
/// startDate : "2022-08-10T00:00:00.000Z"
/// endDate : "2022-08-20T00:00:00.000Z"
/// deadline : "2022-08-07T00:00:00.000Z"
/// ageGroup : "groupD"
/// height : {"foot":5,"inch":6}
/// gender : "female"
/// createdAt : "2023-07-11T12:40:01.701Z"
/// appliedOn : "2023-07-11T05:14:26.423Z"
/// applicationId : "64ace5327150ab944dd38a9a"
/// jobDetails : [{"_id":"64a65f7b4cf51ae0197032b3","jobName":"Photo Shoots","jobCategory":["Print Ad Shoot, Digital Media, Corporator"]},{"_id":"64a660304cf51ae0197032bd","jobName":"Video Shoots","jobCategory":["Ad Shoot, Song Shoot, Short Films, Documentary Shoot"]}]
/// chatId : null

class Result {
  Result({
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
    this.ageGroup,
    this.height,
    this.gender,
    this.createdAt,
    this.appliedOn,
    this.applicationId,
    this.jobDetails,
    this.chatId,
  });

  Result.fromJson(dynamic json) {
    id = json['_id'];
    if (json['createdBy'] != null) {
      createdBy = [];
      json['createdBy'].forEach((v) {
        createdBy?.add(CreatedBy.fromJson(v));
      });
    }
    jobType = json['jobType'];
    title = json['title'];
    jobLocation = json['jobLocation'] != null
        ? JobLocation.fromJson(json['jobLocation'])
        : null;
    description = json['description'];
    experienceLevel = json['experienceLevel'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    deadline = json['deadline'];
    ageGroup = json['ageGroup'];
    height = json['height'] != null ? Height.fromJson(json['height']) : null;
    gender = json['gender'];
    createdAt = json['createdAt'];
    appliedOn = json['appliedOn'];
    applicationId = json['applicationId'];
    if (json['jobDetails'] != null) {
      jobDetails = [];
      json['jobDetails'].forEach((v) {
        jobDetails?.add(JobDetails.fromJson(v));
      });
    }
    chatId = json['chatId'];
  }
  String? id;
  List<CreatedBy>? createdBy;
  String? jobType;
  String? title;
  JobLocation? jobLocation;
  String? description;
  String? experienceLevel;
  String? startDate;
  String? endDate;
  String? deadline;
  String? ageGroup;
  Height? height;
  String? gender;
  String? createdAt;
  String? appliedOn;
  String? applicationId;
  List<JobDetails>? jobDetails;
  dynamic chatId;
  Result copyWith({
    String? id,
    List<CreatedBy>? createdBy,
    String? jobType,
    String? title,
    JobLocation? jobLocation,
    String? description,
    String? experienceLevel,
    String? startDate,
    String? endDate,
    String? deadline,
    String? ageGroup,
    Height? height,
    String? gender,
    String? createdAt,
    String? appliedOn,
    String? applicationId,
    List<JobDetails>? jobDetails,
    dynamic chatId,
  }) =>
      Result(
        id: id ?? this.id,
        createdBy: createdBy ?? this.createdBy,
        jobType: jobType ?? this.jobType,
        title: title ?? this.title,
        jobLocation: jobLocation ?? this.jobLocation,
        description: description ?? this.description,
        experienceLevel: experienceLevel ?? this.experienceLevel,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        deadline: deadline ?? this.deadline,
        ageGroup: ageGroup ?? this.ageGroup,
        height: height ?? this.height,
        gender: gender ?? this.gender,
        createdAt: createdAt ?? this.createdAt,
        appliedOn: appliedOn ?? this.appliedOn,
        applicationId: applicationId ?? this.applicationId,
        jobDetails: jobDetails ?? this.jobDetails,
        chatId: chatId ?? this.chatId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (createdBy != null) {
      map['createdBy'] = createdBy?.map((v) => v.toJson()).toList();
    }
    map['jobType'] = jobType;
    map['title'] = title;
    if (jobLocation != null) {
      map['jobLocation'] = jobLocation?.toJson();
    }
    map['description'] = description;
    map['experienceLevel'] = experienceLevel;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['deadline'] = deadline;
    map['ageGroup'] = ageGroup;
    if (height != null) {
      map['height'] = height?.toJson();
    }
    map['gender'] = gender;
    map['createdAt'] = createdAt;
    map['appliedOn'] = appliedOn;
    map['applicationId'] = applicationId;
    if (jobDetails != null) {
      map['jobDetails'] = jobDetails?.map((v) => v.toJson()).toList();
    }
    map['chatId'] = chatId;
    return map;
  }
}

/// _id : "64a65f7b4cf51ae0197032b3"
/// jobName : "Photo Shoots"
/// jobCategory : ["Print Ad Shoot, Digital Media, Corporator"]

class JobDetails {
  JobDetails({
    this.id,
    this.jobName,
    this.jobCategory,
  });

  JobDetails.fromJson(dynamic json) {
    id = json['_id'];
    jobName = json['jobName'];
    jobCategory =
        json['jobCategory'] != null ? json['jobCategory'].cast<String>() : [];
  }
  String? id;
  String? jobName;
  List<String>? jobCategory;
  JobDetails copyWith({
    String? id,
    String? jobName,
    List<String>? jobCategory,
  }) =>
      JobDetails(
        id: id ?? this.id,
        jobName: jobName ?? this.jobName,
        jobCategory: jobCategory ?? this.jobCategory,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['jobName'] = jobName;
    map['jobCategory'] = jobCategory;
    return map;
  }
}

/// foot : 5
/// inch : 6

class Height {
  Height({
    this.foot,
    this.inch,
  });

  Height.fromJson(dynamic json) {
    foot = json['foot'];
    inch = json['inch'];
  }
  num? foot;
  num? inch;
  Height copyWith({
    num? foot,
    num? inch,
  }) =>
      Height(
        foot: foot ?? this.foot,
        inch: inch ?? this.inch,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foot'] = foot;
    map['inch'] = inch;
    return map;
  }
}

/// district : "mumbai"
/// state : "maharashtra"
/// country : "india"

class JobLocation {
  JobLocation({
    this.district,
    this.state,
    this.country,
  });

  JobLocation.fromJson(dynamic json) {
    district = json['district'];
    state = json['state'];
    country = json['country'];
  }
  String? district;
  String? state;
  String? country;
  JobLocation copyWith({
    String? district,
    String? state,
    String? country,
  }) =>
      JobLocation(
        district: district ?? this.district,
        state: state ?? this.state,
        country: country ?? this.country,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = district;
    map['state'] = state;
    map['country'] = country;
    return map;
  }
}

/// _id : "63fcc0d6dbc4fa3dbb872c86"
/// name : "Naznin Developer"
/// profileImage : "famelinks-6d6c5a6c-c811-4723-b816-06bfb283c56b-xs"
/// profileImageType : "avatar"

class CreatedBy {
  CreatedBy({
    this.id,
    this.name,
    this.profileImage,
    this.profileImageType,
  });

  CreatedBy.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
  }
  String? id;
  String? name;
  String? profileImage;
  String? profileImageType;
  CreatedBy copyWith({
    String? id,
    String? name,
    String? profileImage,
    String? profileImageType,
  }) =>
      CreatedBy(
        id: id ?? this.id,
        name: name ?? this.name,
        profileImage: profileImage ?? this.profileImage,
        profileImageType: profileImageType ?? this.profileImageType,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['profileImage'] = profileImage;
    map['profileImageType'] = profileImageType;
    return map;
  }
}
