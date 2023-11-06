class JobLinkFeedResponseResultPastJobsJobDetails {
/*
{
  "jobName": "Mehandi Art",
  "jobCategory": null
}
*/

  String? jobName;
  String? jobCategory;

  JobLinkFeedResponseResultPastJobsJobDetails({
    this.jobName,
    this.jobCategory,
  });
  JobLinkFeedResponseResultPastJobsJobDetails.fromJson(
      Map<String, dynamic> json) {
    jobName = json['jobName']?.toString();
    jobCategory = json['jobCategory']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jobName'] = jobName;
    data['jobCategory'] = jobCategory;
    return data;
  }
}

class JobLinkFeedResponseResultPastJobsJobLocation {
/*
{
  "district": "mumbai",
  "state": "maharashtra",
  "country": "india"
}
*/

  String? district;
  String? state;
  String? country;

  JobLinkFeedResponseResultPastJobsJobLocation({
    this.district,
    this.state,
    this.country,
  });
  JobLinkFeedResponseResultPastJobsJobLocation.fromJson(
      Map<String, dynamic> json) {
    district = json['district']?.toString();
    state = json['state']?.toString();
    country = json['country']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['district'] = district;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

class JobLinkFeedResponseResultPastJobs {
/*
{
  "_id": "64ad509a48014f7b2b51d2fa",
  "jobType": "crew",
  "title": "Mahendi artist required at Mumbai",
  "jobLocation": {
    "district": "mumbai",
    "state": "maharashtra",
    "country": "india"
  },
  "description": "Apply for job crew",
  "experienceLevel": "experienced",
  "startDate": "2022-08-10T00:00:00.000Z",
  "endDate": "2022-08-20T00:00:00.000Z",
  "deadline": "2022-08-07T00:00:00.000Z",
  "createdAt": "2023-07-11T12:52:42.390Z",
  "jobDetails": [
    {
      "jobName": "Mehandi Art",
      "jobCategory": null
    }
  ],
  "selectedCandidates": [
    null
  ]
}
*/

  String? Id;
  String? jobType;
  String? title;
  JobLinkFeedResponseResultPastJobsJobLocation? jobLocation;
  String? description;
  String? experienceLevel;
  String? startDate;
  String? endDate;
  String? deadline;
  String? createdAt;
  List<JobLinkFeedResponseResultPastJobsJobDetails?>? jobDetails;
  dynamic selectedCandidates;

  JobLinkFeedResponseResultPastJobs({
    this.Id,
    this.jobType,
    this.title,
    this.jobLocation,
    this.description,
    this.experienceLevel,
    this.startDate,
    this.endDate,
    this.deadline,
    this.createdAt,
    this.jobDetails,
    this.selectedCandidates,
  });
  JobLinkFeedResponseResultPastJobs.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    jobType = json['jobType']?.toString();
    title = json['title']?.toString();
    jobLocation = (json['jobLocation'] != null)
        ? JobLinkFeedResponseResultPastJobsJobLocation.fromJson(
            json['jobLocation'])
        : null;
    description = json['description']?.toString();
    experienceLevel = json['experienceLevel']?.toString();
    startDate = json['startDate']?.toString();
    endDate = json['endDate']?.toString();
    deadline = json['deadline']?.toString();
    createdAt = json['createdAt']?.toString();
    if (json['jobDetails'] != null) {
      final v = json['jobDetails'];
      final arr0 = <JobLinkFeedResponseResultPastJobsJobDetails>[];
      v.forEach((v) {
        arr0.add(JobLinkFeedResponseResultPastJobsJobDetails.fromJson(v));
      });
      jobDetails = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['jobType'] = jobType;
    data['title'] = title;
    if (jobLocation != null) {
      data['jobLocation'] = jobLocation!.toJson();
    }
    data['description'] = description;
    data['experienceLevel'] = experienceLevel;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['deadline'] = deadline;
    data['createdAt'] = createdAt;
    if (jobDetails != null) {
      final v = jobDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['jobDetails'] = arr0;
    }
    return data;
  }
}

class JobLinkFeedResponseResultYourJobsHeight {
/*
{
  "foot": 5,
  "inch": 6
}
*/

  int? foot;
  int? inch;

  JobLinkFeedResponseResultYourJobsHeight({
    this.foot,
    this.inch,
  });
  JobLinkFeedResponseResultYourJobsHeight.fromJson(Map<String, dynamic> json) {
    foot = json['foot']?.toInt();
    inch = json['inch']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['foot'] = foot;
    data['inch'] = inch;
    return data;
  }
}

class JobLinkFeedResponseResultYourJobsJobLocation {
/*
{
  "district": "mumbai",
  "state": "maharashtra",
  "country": "india"
}
*/

  String? district;
  String? state;
  String? country;

  JobLinkFeedResponseResultYourJobsJobLocation({
    this.district,
    this.state,
    this.country,
  });
  JobLinkFeedResponseResultYourJobsJobLocation.fromJson(
      Map<String, dynamic> json) {
    district = json['district']?.toString();
    state = json['state']?.toString();
    country = json['country']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['district'] = district;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

class JobLinkFeedResponseResultYourJobs {
/*
{
  "_id": "64ae2c9b6cdaef8a4ce92c03",
  "jobType": "faces",
  "title": "Agency created job faces",
  "jobLocation": {
    "district": "mumbai",
    "state": "maharashtra",
    "country": "india"
  },
  "description": "Apply for agency job faces",
  "startDate": "2022-08-10T00:00:00.000Z",
  "endDate": "2022-08-20T00:00:00.000Z",
  "deadline": "2022-08-07T00:00:00.000Z",
  "ageGroup": "groupD",
  "height": {
    "foot": 5,
    "inch": 6
  },
  "gender": "male",
  "createdAt": "2023-07-12T04:31:23.936Z",
  "jobDetails": [
    null
  ],
  "applicants": [
    null
  ]
}
*/

  String? Id;
  String? jobType;
  String? title;
  JobLinkFeedResponseResultYourJobsJobLocation? jobLocation;
  String? description;
  String? startDate;
  String? endDate;
  String? deadline;
  String? ageGroup;
  JobLinkFeedResponseResultYourJobsHeight? height;
  String? gender;
  String? createdAt;
  List<JobLinkFeedResponseResultExploreJobsJobDetails?>? jobDetails;
  dynamic applicants;

  JobLinkFeedResponseResultYourJobs({
    this.Id,
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
    this.createdAt,
    this.jobDetails,
    this.applicants,
  });
  JobLinkFeedResponseResultYourJobs.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    jobType = json['jobType']?.toString();
    title = json['title']?.toString();
    jobLocation = (json['jobLocation'] != null)
        ? JobLinkFeedResponseResultYourJobsJobLocation.fromJson(
            json['jobLocation'])
        : null;
    description = json['description']?.toString();
    startDate = json['startDate']?.toString();
    endDate = json['endDate']?.toString();
    deadline = json['deadline']?.toString();
    ageGroup = json['ageGroup']?.toString();
    height = (json['height'] != null)
        ? JobLinkFeedResponseResultYourJobsHeight.fromJson(json['height'])
        : null;
    gender = json['gender']?.toString();
    createdAt = json['createdAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['jobType'] = jobType;
    data['title'] = title;
    if (jobLocation != null) {
      data['jobLocation'] = jobLocation!.toJson();
    }
    data['description'] = description;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['deadline'] = deadline;
    data['ageGroup'] = ageGroup;
    if (height != null) {
      data['height'] = height!.toJson();
    }
    data['gender'] = gender;
    data['createdAt'] = createdAt;
    return data;
  }
}

class JobLinkFeedResponseResultExploreJobsJobDetails {
/*
{
  "_id": "64a65f7b4cf51ae0197032b3",
  "jobName": "Photo Shoots",
  "jobType": "faces",
  "jobCategory": [
    "Print Ad Shoot, Digital Media, Corporator"
  ]
}
*/

  String? Id;
  String? jobName;
  String? jobType;
  List<String?>? jobCategory;

  JobLinkFeedResponseResultExploreJobsJobDetails({
    this.Id,
    this.jobName,
    this.jobType,
    this.jobCategory,
  });
  JobLinkFeedResponseResultExploreJobsJobDetails.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    jobName = json['jobName']?.toString();
    jobType = json['jobType']?.toString();
    if (json['jobCategory'] != null) {
      final v = json['jobCategory'];
      final arr0 = <String>[];
      v.forEach((v) {
        arr0.add(v.toString());
      });
      jobCategory = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['jobName'] = jobName;
    data['jobType'] = jobType;
    if (jobCategory != null) {
      final v = jobCategory;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v);
      });
      data['jobCategory'] = arr0;
    }
    return data;
  }
}

class JobLinkFeedResponseResultExploreJobsHeight {
/*
{
  "foot": 5,
  "inch": 6
}
*/

  int? foot;
  int? inch;

  JobLinkFeedResponseResultExploreJobsHeight({
    this.foot,
    this.inch,
  });
  JobLinkFeedResponseResultExploreJobsHeight.fromJson(
      Map<String, dynamic> json) {
    foot = json['foot']?.toInt();
    inch = json['inch']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['foot'] = foot;
    data['inch'] = inch;
    return data;
  }
}

class JobLinkFeedResponseResultExploreJobsJobLocation {
/*
{
  "district": "mumbai",
  "state": "maharashtra",
  "country": "india"
}
*/

  String? district;
  String? state;
  String? country;

  JobLinkFeedResponseResultExploreJobsJobLocation({
    this.district,
    this.state,
    this.country,
  });
  JobLinkFeedResponseResultExploreJobsJobLocation.fromJson(
      Map<String, dynamic> json) {
    district = json['district']?.toString();
    state = json['state']?.toString();
    country = json['country']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['district'] = district;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

class JobLinkFeedResponseResultExploreJobsCreatedBy {
/*
{
  "name": "naznin joblinks",
  "profileImage": null,
  "profileImageType": ""
}
*/

  String? name;
  String? profileImage;
  String? profileImageType;

  JobLinkFeedResponseResultExploreJobsCreatedBy({
    this.name,
    this.profileImage,
    this.profileImageType,
  });
  JobLinkFeedResponseResultExploreJobsCreatedBy.fromJson(
      Map<String, dynamic> json) {
    name = json['name']?.toString();
    profileImage = json['profileImage']?.toString();
    profileImageType = json['profileImageType']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['profileImage'] = profileImage;
    data['profileImageType'] = profileImageType;
    return data;
  }
}

class JobLinkFeedResponseResultExploreJobs {
/*
{
  "_id": "64ad4da1d6ee9a4a9ce5eff8",
  "createdBy": [
    {
      "name": "naznin joblinks",
      "profileImage": null,
      "profileImageType": ""
    }
  ],
  "jobType": "faces",
  "title": "Models required for Ethenic Wear shoot",
  "jobLocation": {
    "district": "mumbai",
    "state": "maharashtra",
    "country": "india"
  },
  "description": "Apply for agency job faces",
  "startDate": "2022-08-10T00:00:00.000Z",
  "endDate": "2022-08-20T00:00:00.000Z",
  "deadline": "2022-08-07T00:00:00.000Z",
  "ageGroup": "groupD",
  "height": {
    "foot": 5,
    "inch": 6
  },
  "gender": "female",
  "lastVisited": "2023-07-11T12:40:01.682Z",
  "createdAt": "2023-07-11T12:40:01.701Z",
  "jobDetails": [
    {
      "_id": "64a65f7b4cf51ae0197032b3",
      "jobName": "Photo Shoots",
      "jobType": "faces",
      "jobCategory": [
        "Print Ad Shoot, Digital Media, Corporator"
      ]
    }
  ],
  "savedStatus": false
}
*/

  String? Id;
  List<JobLinkFeedResponseResultExploreJobsCreatedBy?>? createdBy;
  String? jobType;
  String? title;
  JobLinkFeedResponseResultExploreJobsJobLocation? jobLocation;
  String? description;
  String? startDate;
  String? endDate;
  String? deadline;
  String? ageGroup;
  JobLinkFeedResponseResultExploreJobsHeight? height;
  String? gender;
  String? lastVisited;
  String? createdAt;
  List<JobLinkFeedResponseResultExploreJobsJobDetails?>? jobDetails;
  bool? savedStatus;

  JobLinkFeedResponseResultExploreJobs({
    this.Id,
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
    this.lastVisited,
    this.createdAt,
    this.jobDetails,
    this.savedStatus,
  });
  JobLinkFeedResponseResultExploreJobs.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    if (json['createdBy'] != null) {
      final v = json['createdBy'];
      final arr0 = <JobLinkFeedResponseResultExploreJobsCreatedBy>[];
      v.forEach((v) {
        arr0.add(JobLinkFeedResponseResultExploreJobsCreatedBy.fromJson(v));
      });
      createdBy = arr0;
    }
    jobType = json['jobType']?.toString();
    title = json['title']?.toString();
    jobLocation = (json['jobLocation'] != null)
        ? JobLinkFeedResponseResultExploreJobsJobLocation.fromJson(
            json['jobLocation'])
        : null;
    description = json['description']?.toString();
    startDate = json['startDate']?.toString();
    endDate = json['endDate']?.toString();
    deadline = json['deadline']?.toString();
    ageGroup = json['ageGroup']?.toString();
    height = (json['height'] != null)
        ? JobLinkFeedResponseResultExploreJobsHeight.fromJson(json['height'])
        : null;
    gender = json['gender']?.toString();
    lastVisited = json['lastVisited']?.toString();
    createdAt = json['createdAt']?.toString();
    if (json['jobDetails'] != null) {
      final v = json['jobDetails'];
      final arr0 = <JobLinkFeedResponseResultExploreJobsJobDetails>[];
      v.forEach((v) {
        arr0.add(JobLinkFeedResponseResultExploreJobsJobDetails.fromJson(v));
      });
      jobDetails = arr0;
    }
    savedStatus = json['savedStatus'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    if (createdBy != null) {
      final v = createdBy;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['createdBy'] = arr0;
    }
    data['jobType'] = jobType;
    data['title'] = title;
    if (jobLocation != null) {
      data['jobLocation'] = jobLocation!.toJson();
    }
    data['description'] = description;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['deadline'] = deadline;
    data['ageGroup'] = ageGroup;
    if (height != null) {
      data['height'] = height!.toJson();
    }
    data['gender'] = gender;
    data['lastVisited'] = lastVisited;
    data['createdAt'] = createdAt;
    if (jobDetails != null) {
      final v = jobDetails;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['jobDetails'] = arr0;
    }
    data['savedStatus'] = savedStatus;
    return data;
  }
}

class JobLinkFeedResponseResultExploreTalentsProfileCrew {
/*
{
  "experienceLevel": "fresher",
  "workExperience": "",
  "achievements": "",
  "interestCat": [
    null
  ],
  "interestedLoc": [
    null
  ]
}
*/

  String? experienceLevel;
  String? workExperience;
  String? achievements;
  dynamic interestCat;
  dynamic interestedLoc;

  JobLinkFeedResponseResultExploreTalentsProfileCrew({
    this.experienceLevel,
    this.workExperience,
    this.achievements,
    this.interestCat,
    this.interestedLoc,
  });
  JobLinkFeedResponseResultExploreTalentsProfileCrew.fromJson(
      Map<String, dynamic> json) {
    experienceLevel = json['experienceLevel']?.toString();
    workExperience = json['workExperience']?.toString();
    achievements = json['achievements']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['experienceLevel'] = experienceLevel;
    data['workExperience'] = workExperience;
    data['achievements'] = achievements;

    return data;
  }
}

class JobLinkFeedResponseResultExploreTalentsProfileFacesHeight {
/*
{
  "foot": 0,
  "inch": 0
}
*/

  int? foot;
  int? inch;

  JobLinkFeedResponseResultExploreTalentsProfileFacesHeight({
    this.foot,
    this.inch,
  });
  JobLinkFeedResponseResultExploreTalentsProfileFacesHeight.fromJson(
      Map<String, dynamic> json) {
    foot = json['foot']?.toInt();
    inch = json['inch']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['foot'] = foot;
    data['inch'] = inch;
    return data;
  }
}

class JobLinkFeedResponseResultExploreTalentsProfileFaces {
/*
{
  "interestCat": [
    null
  ],
  "height": {
    "foot": 0,
    "inch": 0
  },
  "weight": 0,
  "bust": 0,
  "waist": 0,
  "hip": 0,
  "eyeColor": "",
  "complexion": "",
  "interestedLoc": [
    null
  ]
}
*/

  dynamic interestCat;
  JobLinkFeedResponseResultExploreTalentsProfileFacesHeight? height;
  int? weight;
  int? bust;
  int? waist;
  int? hip;
  String? eyeColor;
  String? complexion;
  dynamic interestedLoc;

  JobLinkFeedResponseResultExploreTalentsProfileFaces({
    this.interestCat,
    this.height,
    this.weight,
    this.bust,
    this.waist,
    this.hip,
    this.eyeColor,
    this.complexion,
    this.interestedLoc,
  });
  JobLinkFeedResponseResultExploreTalentsProfileFaces.fromJson(
      Map<String, dynamic> json) {
    height = (json['height'] != null)
        ? JobLinkFeedResponseResultExploreTalentsProfileFacesHeight.fromJson(
            json['height'])
        : null;
    weight = json['weight']?.toInt();
    bust = json['bust']?.toInt();
    waist = json['waist']?.toInt();
    hip = json['hip']?.toInt();
    eyeColor = json['eyeColor']?.toString();
    complexion = json['complexion']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (height != null) {
      data['height'] = height!.toJson();
    }
    data['weight'] = weight;
    data['bust'] = bust;
    data['waist'] = waist;
    data['hip'] = hip;
    data['eyeColor'] = eyeColor;
    data['complexion'] = complexion;
    return data;
  }
}

class JobLinkFeedResponseResultExploreTalentsProfile {
/*
{
  "_id": "64a6a32fc6bd6caba612d634",
  "name": "",
  "profileImage": null,
  "profileImageType": "",
  "greetVideo": "",
  "profileFaces": "64a6a32fc6bd6caba612d636",
  "profileCrew": "64a6a32fc6bd6caba612d638",
  "faces": [
    {
      "interestCat": [
        null
      ],
      "height": {
        "foot": 0,
        "inch": 0
      },
      "weight": 0,
      "bust": 0,
      "waist": 0,
      "hip": 0,
      "eyeColor": "",
      "complexion": "",
      "interestedLoc": [
        null
      ]
    }
  ],
  "crew": [
    {
      "experienceLevel": "fresher",
      "workExperience": "",
      "achievements": "",
      "interestCat": [
        null
      ],
      "interestedLoc": [
        null
      ]
    }
  ]
}
*/

  String? Id;
  String? name;
  String? profileImage;
  String? profileImageType;
  String? greetVideo;
  String? profileFaces;
  String? profileCrew;
  List<JobLinkFeedResponseResultExploreTalentsProfileFaces?>? faces;
  List<JobLinkFeedResponseResultExploreTalentsProfileCrew?>? crew;

  JobLinkFeedResponseResultExploreTalentsProfile({
    this.Id,
    this.name,
    this.profileImage,
    this.profileImageType,
    this.greetVideo,
    this.profileFaces,
    this.profileCrew,
    this.faces,
    this.crew,
  });
  JobLinkFeedResponseResultExploreTalentsProfile.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    name = json['name']?.toString();
    profileImage = json['profileImage']?.toString();
    profileImageType = json['profileImageType']?.toString();
    greetVideo = json['greetVideo']?.toString();
    profileFaces = json['profileFaces']?.toString();
    profileCrew = json['profileCrew']?.toString();
    if (json['faces'] != null) {
      final v = json['faces'];
      final arr0 = <JobLinkFeedResponseResultExploreTalentsProfileFaces>[];
      v.forEach((v) {
        arr0.add(
            JobLinkFeedResponseResultExploreTalentsProfileFaces.fromJson(v));
      });
      faces = arr0;
    }
    if (json['crew'] != null) {
      final v = json['crew'];
      final arr0 = <JobLinkFeedResponseResultExploreTalentsProfileCrew>[];
      v.forEach((v) {
        arr0.add(
            JobLinkFeedResponseResultExploreTalentsProfileCrew.fromJson(v));
      });
      crew = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['name'] = name;
    data['profileImage'] = profileImage;
    data['profileImageType'] = profileImageType;
    data['greetVideo'] = greetVideo;
    data['profileFaces'] = profileFaces;
    data['profileCrew'] = profileCrew;
    if (faces != null) {
      final v = faces;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['faces'] = arr0;
    }
    if (crew != null) {
      final v = crew;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['crew'] = arr0;
    }
    return data;
  }
}

class JobLinkFeedResponseResultExploreTalentsMasterProfile {
/*
{
  "_id": "64a6a32fc6bd6caba612d63b",
  "name": "Abhishekkumaelrty",
  "gender": "male",
  "ageGroup": "groupC",
  "profileImage": null,
  "profileImageType": "",
  "followersCount": 1,
  "username": "abhishekkumaelrty",
  "age": 15,
  "achievements": ""
}
*/

  String? Id;
  String? name;
  String? gender;
  String? ageGroup;
  String? profileImage;
  String? profileImageType;
  int? followersCount;
  String? username;
  int? age;
  String? achievements;

  JobLinkFeedResponseResultExploreTalentsMasterProfile({
    this.Id,
    this.name,
    this.gender,
    this.ageGroup,
    this.profileImage,
    this.profileImageType,
    this.followersCount,
    this.username,
    this.age,
    this.achievements,
  });
  JobLinkFeedResponseResultExploreTalentsMasterProfile.fromJson(
      Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    name = json['name']?.toString();
    gender = json['gender']?.toString();
    ageGroup = json['ageGroup']?.toString();
    profileImage = json['profileImage']?.toString();
    profileImageType = json['profileImageType']?.toString();
    followersCount = json['followersCount']?.toInt();
    username = json['username']?.toString();
    age = json['age']?.toInt();
    achievements = json['achievements']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['name'] = name;
    data['gender'] = gender;
    data['ageGroup'] = ageGroup;
    data['profileImage'] = profileImage;
    data['profileImageType'] = profileImageType;
    data['followersCount'] = followersCount;
    data['username'] = username;
    data['age'] = age;
    data['achievements'] = achievements;
    return data;
  }
}

class JobLinkFeedResponseResultExploreTalents {
/*
{
  "_id": "64a6a32fc6bd6caba612d63b",
  "createdAt": "2023-07-06T11:19:11.830Z",
  "saved": false,
  "invitationStatus": false,
  "masterProfile": {
    "_id": "64a6a32fc6bd6caba612d63b",
    "name": "Abhishekkumaelrty",
    "gender": "male",
    "ageGroup": "groupC",
    "profileImage": null,
    "profileImageType": "",
    "followersCount": 1,
    "username": "abhishekkumaelrty",
    "age": 15,
    "achievements": ""
  },
  "posts": [
    null
  ],
  "profile": {
    "_id": "64a6a32fc6bd6caba612d634",
    "name": "",
    "profileImage": null,
    "profileImageType": "",
    "greetVideo": "",
    "profileFaces": "64a6a32fc6bd6caba612d636",
    "profileCrew": "64a6a32fc6bd6caba612d638",
    "faces": [
      {
        "interestCat": [
          null
        ],
        "height": {
          "foot": 0,
          "inch": 0
        },
        "weight": 0,
        "bust": 0,
        "waist": 0,
        "hip": 0,
        "eyeColor": "",
        "complexion": "",
        "interestedLoc": [
          null
        ]
      }
    ],
    "crew": [
      {
        "experienceLevel": "fresher",
        "workExperience": "",
        "achievements": "",
        "interestCat": [
          null
        ],
        "interestedLoc": [
          null
        ]
      }
    ]
  }
}
*/

  String? Id;
  String? createdAt;
  bool? saved;
  bool? invitationStatus;
  JobLinkFeedResponseResultExploreTalentsMasterProfile? masterProfile;
  dynamic posts;
  JobLinkFeedResponseResultExploreTalentsProfile? profile;

  JobLinkFeedResponseResultExploreTalents({
    this.Id,
    this.createdAt,
    this.saved,
    this.invitationStatus,
    this.masterProfile,
    this.posts,
    this.profile,
  });
  JobLinkFeedResponseResultExploreTalents.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    createdAt = json['createdAt']?.toString();
    saved = json['saved'];
    invitationStatus = json['invitationStatus'];
    masterProfile = (json['masterProfile'] != null)
        ? JobLinkFeedResponseResultExploreTalentsMasterProfile.fromJson(
            json['masterProfile'])
        : null;
    profile = (json['profile'] != null)
        ? JobLinkFeedResponseResultExploreTalentsProfile.fromJson(
            json['profile'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['createdAt'] = createdAt;
    data['saved'] = saved;
    data['invitationStatus'] = invitationStatus;
    if (masterProfile != null) {
      data['masterProfile'] = masterProfile!.toJson();
    }
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class JobLinkFeedResponseResult {
/*
{
  "ExploreTalents": [
    {
      "_id": "64a6a32fc6bd6caba612d63b",
      "createdAt": "2023-07-06T11:19:11.830Z",
      "saved": false,
      "invitationStatus": false,
      "masterProfile": {
        "_id": "64a6a32fc6bd6caba612d63b",
        "name": "Abhishekkumaelrty",
        "gender": "male",
        "ageGroup": "groupC",
        "profileImage": null,
        "profileImageType": "",
        "followersCount": 1,
        "username": "abhishekkumaelrty",
        "age": 15,
        "achievements": ""
      },
      "posts": [
        null
      ],
      "profile": {
        "_id": "64a6a32fc6bd6caba612d634",
        "name": "",
        "profileImage": null,
        "profileImageType": "",
        "greetVideo": "",
        "profileFaces": "64a6a32fc6bd6caba612d636",
        "profileCrew": "64a6a32fc6bd6caba612d638",
        "faces": [
          {
            "interestCat": [
              null
            ],
            "height": {
              "foot": 0,
              "inch": 0
            },
            "weight": 0,
            "bust": 0,
            "waist": 0,
            "hip": 0,
            "eyeColor": "",
            "complexion": "",
            "interestedLoc": [
              null
            ]
          }
        ],
        "crew": [
          {
            "experienceLevel": "fresher",
            "workExperience": "",
            "achievements": "",
            "interestCat": [
              null
            ],
            "interestedLoc": [
              null
            ]
          }
        ]
      }
    }
  ],
  "ExploreJobs": [
    {
      "_id": "64ad4da1d6ee9a4a9ce5eff8",
      "createdBy": [
        {
          "name": "naznin joblinks",
          "profileImage": null,
          "profileImageType": ""
        }
      ],
      "jobType": "faces",
      "title": "Models required for Ethenic Wear shoot",
      "jobLocation": {
        "district": "mumbai",
        "state": "maharashtra",
        "country": "india"
      },
      "description": "Apply for agency job faces",
      "startDate": "2022-08-10T00:00:00.000Z",
      "endDate": "2022-08-20T00:00:00.000Z",
      "deadline": "2022-08-07T00:00:00.000Z",
      "ageGroup": "groupD",
      "height": {
        "foot": 5,
        "inch": 6
      },
      "gender": "female",
      "lastVisited": "2023-07-11T12:40:01.682Z",
      "createdAt": "2023-07-11T12:40:01.701Z",
      "jobDetails": [
        {
          "_id": "64a65f7b4cf51ae0197032b3",
          "jobName": "Photo Shoots",
          "jobType": "faces",
          "jobCategory": [
            "Print Ad Shoot, Digital Media, Corporator"
          ]
        }
      ],
      "savedStatus": false
    }
  ],
  "YourJobs": [
    {
      "_id": "64ae2c9b6cdaef8a4ce92c03",
      "jobType": "faces",
      "title": "Agency created job faces",
      "jobLocation": {
        "district": "mumbai",
        "state": "maharashtra",
        "country": "india"
      },
      "description": "Apply for agency job faces",
      "startDate": "2022-08-10T00:00:00.000Z",
      "endDate": "2022-08-20T00:00:00.000Z",
      "deadline": "2022-08-07T00:00:00.000Z",
      "ageGroup": "groupD",
      "height": {
        "foot": 5,
        "inch": 6
      },
      "gender": "male",
      "createdAt": "2023-07-12T04:31:23.936Z",
      "jobDetails": [
        null
      ],
      "applicants": [
        null
      ]
    }
  ],
  "PastJobs": [
    {
      "_id": "64ad509a48014f7b2b51d2fa",
      "jobType": "crew",
      "title": "Mahendi artist required at Mumbai",
      "jobLocation": {
        "district": "mumbai",
        "state": "maharashtra",
        "country": "india"
      },
      "description": "Apply for job crew",
      "experienceLevel": "experienced",
      "startDate": "2022-08-10T00:00:00.000Z",
      "endDate": "2022-08-20T00:00:00.000Z",
      "deadline": "2022-08-07T00:00:00.000Z",
      "createdAt": "2023-07-11T12:52:42.390Z",
      "jobDetails": [
        {
          "jobName": "Mehandi Art",
          "jobCategory": null
        }
      ],
      "selectedCandidates": [
        null
      ]
    }
  ]
}
*/

  List<JobLinkFeedResponseResultExploreTalents?>? ExploreTalents;
  List<JobLinkFeedResponseResultExploreJobs?>? ExploreJobs;
  List<JobLinkFeedResponseResultYourJobs?>? YourJobs;
  List<JobLinkFeedResponseResultPastJobs?>? PastJobs;

  JobLinkFeedResponseResult({
    this.ExploreTalents,
    this.ExploreJobs,
    this.YourJobs,
    this.PastJobs,
  });
  JobLinkFeedResponseResult.fromJson(Map<String, dynamic> json) {
    if (json['ExploreTalents'] != null) {
      final v = json['ExploreTalents'];
      final arr0 = <JobLinkFeedResponseResultExploreTalents>[];
      v.forEach((v) {
        arr0.add(JobLinkFeedResponseResultExploreTalents.fromJson(v));
      });
      ExploreTalents = arr0;
    }
    if (json['ExploreJobs'] != null) {
      final v = json['ExploreJobs'];
      final arr0 = <JobLinkFeedResponseResultExploreJobs>[];
      v.forEach((v) {
        arr0.add(JobLinkFeedResponseResultExploreJobs.fromJson(v));
      });
      ExploreJobs = arr0;
    }
    if (json['YourJobs'] != null) {
      final v = json['YourJobs'];
      final arr0 = <JobLinkFeedResponseResultYourJobs>[];
      v.forEach((v) {
        arr0.add(JobLinkFeedResponseResultYourJobs.fromJson(v));
      });
      YourJobs = arr0;
    }
    if (json['PastJobs'] != null) {
      final v = json['PastJobs'];
      final arr0 = <JobLinkFeedResponseResultPastJobs>[];
      v.forEach((v) {
        arr0.add(JobLinkFeedResponseResultPastJobs.fromJson(v));
      });
      PastJobs = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (ExploreTalents != null) {
      final v = ExploreTalents;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['ExploreTalents'] = arr0;
    }
    if (ExploreJobs != null) {
      final v = ExploreJobs;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['ExploreJobs'] = arr0;
    }
    if (YourJobs != null) {
      final v = YourJobs;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['YourJobs'] = arr0;
    }
    if (PastJobs != null) {
      final v = PastJobs;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['PastJobs'] = arr0;
    }
    return data;
  }
}

class JobLinkFeedResponse {
/*
{
  "result": {
    "ExploreTalents": [
      {
        "_id": "64a6a32fc6bd6caba612d63b",
        "createdAt": "2023-07-06T11:19:11.830Z",
        "saved": false,
        "invitationStatus": false,
        "masterProfile": {
          "_id": "64a6a32fc6bd6caba612d63b",
          "name": "Abhishekkumaelrty",
          "gender": "male",
          "ageGroup": "groupC",
          "profileImage": null,
          "profileImageType": "",
          "followersCount": 1,
          "username": "abhishekkumaelrty",
          "age": 15,
          "achievements": ""
        },
        "posts": [
          null
        ],
        "profile": {
          "_id": "64a6a32fc6bd6caba612d634",
          "name": "",
          "profileImage": null,
          "profileImageType": "",
          "greetVideo": "",
          "profileFaces": "64a6a32fc6bd6caba612d636",
          "profileCrew": "64a6a32fc6bd6caba612d638",
          "faces": [
            {
              "interestCat": [
                null
              ],
              "height": {
                "foot": 0,
                "inch": 0
              },
              "weight": 0,
              "bust": 0,
              "waist": 0,
              "hip": 0,
              "eyeColor": "",
              "complexion": "",
              "interestedLoc": [
                null
              ]
            }
          ],
          "crew": [
            {
              "experienceLevel": "fresher",
              "workExperience": "",
              "achievements": "",
              "interestCat": [
                null
              ],
              "interestedLoc": [
                null
              ]
            }
          ]
        }
      }
    ],
    "ExploreJobs": [
      {
        "_id": "64ad4da1d6ee9a4a9ce5eff8",
        "createdBy": [
          {
            "name": "naznin joblinks",
            "profileImage": null,
            "profileImageType": ""
          }
        ],
        "jobType": "faces",
        "title": "Models required for Ethenic Wear shoot",
        "jobLocation": {
          "district": "mumbai",
          "state": "maharashtra",
          "country": "india"
        },
        "description": "Apply for agency job faces",
        "startDate": "2022-08-10T00:00:00.000Z",
        "endDate": "2022-08-20T00:00:00.000Z",
        "deadline": "2022-08-07T00:00:00.000Z",
        "ageGroup": "groupD",
        "height": {
          "foot": 5,
          "inch": 6
        },
        "gender": "female",
        "lastVisited": "2023-07-11T12:40:01.682Z",
        "createdAt": "2023-07-11T12:40:01.701Z",
        "jobDetails": [
          {
            "_id": "64a65f7b4cf51ae0197032b3",
            "jobName": "Photo Shoots",
            "jobType": "faces",
            "jobCategory": [
              "Print Ad Shoot, Digital Media, Corporator"
            ]
          }
        ],
        "savedStatus": false
      }
    ],
    "YourJobs": [
      {
        "_id": "64ae2c9b6cdaef8a4ce92c03",
        "jobType": "faces",
        "title": "Agency created job faces",
        "jobLocation": {
          "district": "mumbai",
          "state": "maharashtra",
          "country": "india"
        },
        "description": "Apply for agency job faces",
        "startDate": "2022-08-10T00:00:00.000Z",
        "endDate": "2022-08-20T00:00:00.000Z",
        "deadline": "2022-08-07T00:00:00.000Z",
        "ageGroup": "groupD",
        "height": {
          "foot": 5,
          "inch": 6
        },
        "gender": "male",
        "createdAt": "2023-07-12T04:31:23.936Z",
        "jobDetails": [
          null
        ],
        "applicants": [
          null
        ]
      }
    ],
    "PastJobs": [
      {
        "_id": "64ad509a48014f7b2b51d2fa",
        "jobType": "crew",
        "title": "Mahendi artist required at Mumbai",
        "jobLocation": {
          "district": "mumbai",
          "state": "maharashtra",
          "country": "india"
        },
        "description": "Apply for job crew",
        "experienceLevel": "experienced",
        "startDate": "2022-08-10T00:00:00.000Z",
        "endDate": "2022-08-20T00:00:00.000Z",
        "deadline": "2022-08-07T00:00:00.000Z",
        "createdAt": "2023-07-11T12:52:42.390Z",
        "jobDetails": [
          {
            "jobName": "Mehandi Art",
            "jobCategory": null
          }
        ],
        "selectedCandidates": [
          null
        ]
      }
    ]
  },
  "message": "Feed page fetched",
  "success": true
}
*/

  JobLinkFeedResponseResult? result;
  String? message;
  bool? success;

  JobLinkFeedResponse({
    this.result,
    this.message,
    this.success,
  });
  JobLinkFeedResponse.fromJson(Map<String, dynamic> json) {
    result = (json['result'] != null)
        ? JobLinkFeedResponseResult.fromJson(json['result'])
        : null;
    message = json['message']?.toString();
    success = json['success'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}
