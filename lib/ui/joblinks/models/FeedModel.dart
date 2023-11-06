class FeedModel {
  Feed? result;
  String? message;
  bool? success;

  FeedModel({this.result, this.message, this.success});

  FeedModel.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Feed.fromJson(json['result']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Feed {
  List<Talents>? talents;
  List<Jobs>? jobs;
  List<OpenJobs>? openJobs;
  List<ClosedJobs>? closedJobs;

  Feed({this.talents, this.jobs, this.openJobs, this.closedJobs});

  Feed.fromJson(Map<String, dynamic> json) {
    if (json['talents'] != null) {
      talents = <Talents>[];
      json['talents'].forEach((v) {
        talents!.add(new Talents.fromJson(v));
      });
    }
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
    if (json['openJobs'] != null) {
      openJobs = <OpenJobs>[];
      json['openJobs'].forEach((v) {
        openJobs!.add(new OpenJobs.fromJson(v));
      });
    }
    if (json['closedJobs'] != null) {
      closedJobs = <ClosedJobs>[];
      json['closedJobs'].forEach((v) {
        closedJobs!.add(new ClosedJobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.talents != null) {
      data['talents'] = this.talents!.map((v) => v.toJson()).toList();
    }
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    if (this.openJobs != null) {
      data['openJobs'] = this.openJobs!.map((v) => v.toJson()).toList();
    }
    if (this.closedJobs != null) {
      data['closedJobs'] = this.closedJobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Talents {
  String? sId;
  String? createdAt;
  bool? saved;
  MasterProfile? masterProfile;
  List<Posts>? posts;
  Profile? profile;
  bool? invitationStatus;
  bool? isSwipe = true;
  bool? isPlaying = false;

  Talents(
      {this.sId,
      this.createdAt,
      this.saved,
      this.masterProfile,
      this.posts,
      this.profile,
      this.invitationStatus});

  Talents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    saved = json['saved'];
    invitationStatus = json['invitationStatus'];
    masterProfile = json['masterProfile'] != null
        ? new MasterProfile.fromJson(json['masterProfile'])
        : null;
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['saved'] = this.saved;
    data['invitationStatus'] = this.invitationStatus;
    if (this.masterProfile != null) {
      data['masterProfile'] = this.masterProfile!.toJson();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class MasterProfile {
  String? sId;
  String? profileImage;
  String? profileImageType;
  int? followersCount;
  String? username;
  int? age;
  String? achievements;
  String? ageGroup;
  String? gender;

  MasterProfile(
      {this.sId,
      this.profileImage,
      this.profileImageType,
      this.followersCount,
      this.username,
      this.age,
      this.achievements,
      this.ageGroup,
      this.gender});

  MasterProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    followersCount = json['followersCount'];
    username = json['username'];
    age = json['age'];
    achievements = json['achievements'];
    ageGroup: json["ageGroup"] == null ? null : json["ageGroup"];
    gender: json["gender"] == null ? null : json["gender"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    data['followersCount'] = this.followersCount;
    data['username'] = this.username;
    data['age'] = this.age;
    data['achievements'] = this.achievements;
    data["ageGroup"]= this.ageGroup == null ? null : this.ageGroup;
    data["gender"]= this.gender == null ? null : this.gender;
    return data;
  }
}

class Posts {
  String? sId;
  String? closeUp;
  String? medium;
  String? long;
  String? pose1;
  String? pose2;
  String? additional;
  String? video;

  Posts(
      {this.sId,
      this.closeUp,
      this.medium,
      this.long,
      this.pose1,
      this.pose2,
      this.additional,
      this.video});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    closeUp = json['closeUp'];
    medium = json['medium'];
    long = json['long'];
    pose1 = json['pose1'];
    pose2 = json['pose2'];
    additional = json['additional'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['closeUp'] = this.closeUp;
    data['medium'] = this.medium;
    data['long'] = this.long;
    data['pose1'] = this.pose1;
    data['pose2'] = this.pose2;
    data['additional'] = this.additional;
    data['video'] = this.video;
    return data;
  }
}

class Profile {
  String? sId;
  String? name;
  Null? profileImage;
  String? profileImageType;
  String? greetVideo;
  String? profileFaces;
  String? profileCrew;
  List<Faces>? faces;
  List<Crew>? crew;

  Profile(
      {this.sId,
      this.name,
      this.profileImage,
      this.profileImageType,
      this.greetVideo,
      this.profileFaces,
      this.profileCrew,
      this.faces,
      this.crew});

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    greetVideo = json['greetVideo'];
    profileFaces = json['profileFaces'];
    profileCrew = json['profileCrew'];
    if (json['faces'] != null) {
      faces = <Faces>[];
      json['faces'].forEach((v) {
        faces!.add(new Faces.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = <Crew>[];
      json['crew'].forEach((v) {
        crew!.add(new Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    data['greetVideo'] = this.greetVideo;
    data['profileFaces'] = this.profileFaces;
    data['profileCrew'] = this.profileCrew;
    if (this.faces != null) {
      data['faces'] = this.faces!.map((v) => v.toJson()).toList();
    }
    if (this.crew != null) {
      data['crew'] = this.crew!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faces {
  Height? height;
  int? weight;
  int? bust;
  int? waist;
  int? hip;
  String? eyeColor;
  String? complexion;
  String? ageGroup;
  String? gender;
  List<InterestCat>? interestCat;
  List<InterestedLoc>? interestedLoc;

  Faces(
      {
      this.height,
      this.weight,
      this.bust,
      this.waist,
      this.hip,
      this.eyeColor,
      this.complexion,
      this.interestCat,
      this.interestedLoc
    });

  Faces.fromJson(Map<String, dynamic> json) {
    height =
        json['height'] != null ? new Height.fromJson(json['height']) : null;
    weight = json['weight'];
    bust = json['bust'];
    waist = json['waist'];
    hip = json['hip'];
    eyeColor = json['eyeColor'];
    complexion = json['complexion'];
    if (json['interestCat'] != null) {
      interestCat = <InterestCat>[];
      json['interestCat'].forEach((v) {
        interestCat!.add(new InterestCat.fromJson(v));
      });
    }
    if (json['interestedLoc'] != null) {
      interestedLoc = <InterestedLoc>[];
      json['interestedLoc'].forEach((v) {
        interestedLoc!.add(new InterestedLoc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    data['weight'] = this.weight;
    data['bust'] = this.bust;
    data['waist'] = this.waist;
    data['hip'] = this.hip;
    data['eyeColor'] = this.eyeColor;
    data['complexion'] = this.complexion;
    if (this.interestCat != null) {
      data['interestCat'] = this.interestCat!.map((v) => v.toJson()).toList();
    }
    if (this.interestedLoc != null) {
      data['interestedLoc'] =
          this.interestedLoc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InterestCat {
  String? jobName;
  String? jobCategory;

  InterestCat({this.jobName, this.jobCategory});

  InterestCat.fromJson(Map<String, dynamic> json) {
    jobName = json['jobName'];
    jobCategory = json['jobCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobName'] = this.jobName;
    data['jobCategory'] = this.jobCategory;
    return data;
  }
}

class InterestedLoc {
  String? district;
  String? state;
  String? country;

  InterestedLoc({this.district, this.state, this.country});

  InterestedLoc.fromJson(Map<String, dynamic> json) {
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

class Crew {
  String? experienceLevel;
  String? workExperience;
  String? achievements;
  List<InterestCat>? interestCat;
  List<InterestedLoc>? interestedLoc;

  Crew(
      {this.experienceLevel,
      this.workExperience,
      this.achievements,
      this.interestCat,
      this.interestedLoc});

  Crew.fromJson(Map<String, dynamic> json) {
    experienceLevel = json['experienceLevel'];
    workExperience = json['workExperience'];
    achievements = json['achievements'];
    if (json['interestCat'] != null) {
      interestCat = <InterestCat>[];
      json['interestCat'].forEach((v) {
        interestCat!.add(new InterestCat.fromJson(v));
      });
    }
    if (json['interestedLoc'] != null) {
      interestedLoc = <InterestedLoc>[];
      json['interestedLoc'].forEach((v) {
        interestedLoc!.add(new InterestedLoc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['experienceLevel'] = this.experienceLevel;
    data['workExperience'] = this.workExperience;
    data['achievements'] = this.achievements;
    if (this.interestCat != null) {
      data['interestCat'] = this.interestCat!.map((v) => v.toJson()).toList();
    }
    if (this.interestedLoc != null) {
      data['interestedLoc'] =
          this.interestedLoc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  String? sId;
  List<CreatedBy>? createdBy;
  String? jobType;
  String? title;
  InterestedLoc? jobLocation;
  String? description;
  String? experienceLevel;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? deadline;
  Height? height;
  DateTime? createdAt;
  List<JobDetails>? jobDetails;
  bool? savedStatus;
  String? ageGroup;
  String? gender;
  bool? isSwipe = true;
  bool? isApplied = false;

  Jobs(
      {this.sId,
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
      this.gender});

  Jobs.fromJson(Map<String, dynamic> json) {
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
        ? new InterestedLoc.fromJson(json['jobLocation'])
        : null;
    description = json['description'];
    experienceLevel = json['experienceLevel'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    deadline = DateTime.parse(json['deadline']);
    height =
        json['height'] != null ? new Height.fromJson(json['height']) : null;
    createdAt = DateTime.parse(json['createdAt']);
    if (json['jobDetails'] != null) {
      jobDetails = <JobDetails>[];
      json['jobDetails'].forEach((v) {
        jobDetails!.add(new JobDetails.fromJson(v));
      });
    }
    savedStatus = json['savedStatus'];
    ageGroup = json['ageGroup'];
    gender = json['gender'];
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
    data['experienceLevel'] = this.experienceLevel;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['deadline'] = this.deadline;
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    data['createdAt'] = this.createdAt;
    if (this.jobDetails != null) {
      data['jobDetails'] = this.jobDetails!.map((v) => v.toJson()).toList();
    }
    data['savedStatus'] = this.savedStatus;
    data['ageGroup'] = this.ageGroup;
    data['gender'] = this.gender;
    return data;
  }
}

class CreatedBy {
  String? name;
  String? profileImage;
  String? profileImageType;

  CreatedBy({this.name, this.profileImage, this.profileImageType});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}

class JobDetails {
  String? jobName;
  String? jobType;
  String? jobCategory;

  JobDetails({this.jobName, this.jobType, this.jobCategory});

  JobDetails.fromJson(Map<String, dynamic> json) {
    jobName = json['jobName'];
    jobType = json['jobType'];
    jobCategory = json['jobCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobName'] = this.jobName;
    data['jobType'] = this.jobType;
    data['jobCategory'] = this.jobCategory;
    return data;
  }
}

class OpenJobs {
  String? sId;
  String? jobType;
  String? title;
  InterestedLoc? jobLocation;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? deadline;
  String? ageGroup;
  String? gender;
  DateTime? createdAt;
  List<JobDetails>? jobDetails;
  List<Applicants>? applicants;
  String? experienceLevel;
  Height? height;
  bool? isSwipe = true;

  OpenJobs(
      {this.sId,
      this.jobType,
      this.title,
      this.jobLocation,
      this.description,
      this.startDate,
      this.endDate,
      this.deadline,
      this.ageGroup,
      this.gender,
      this.createdAt,
      this.jobDetails,
      this.applicants,
      this.experienceLevel,
      this.height});

  OpenJobs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobType = json['jobType'];
    title = json['title'];
    jobLocation = json['jobLocation'] != null
        ? new InterestedLoc.fromJson(json['jobLocation'])
        : null;
    description = json['description'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    deadline = DateTime.parse(json['deadline']);
    ageGroup = json['ageGroup'];
    gender = json['gender'];
    createdAt = DateTime.parse(json['createdAt']);
    if (json['jobDetails'] != null) {
      jobDetails = <JobDetails>[];
      json['jobDetails'].forEach((v) {
        jobDetails!.add(new JobDetails.fromJson(v));
      });
    }
    if (json['applicants'] != null) {
      applicants = <Applicants>[];
      json['applicants'].forEach((v) {
        applicants!.add(new Applicants.fromJson(v));
      });
    }
    experienceLevel = json['experienceLevel'];
    height =
        json['height'] != null ? new Height.fromJson(json['height']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    if (this.jobDetails != null) {
      data['jobDetails'] = this.jobDetails!.map((v) => v.toJson()).toList();
    }
    if (this.applicants != null) {
      data['applicants'] = this.applicants!.map((v) => v.toJson()).toList();
    }
    data['experienceLevel'] = this.experienceLevel;
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    return data;
  }
}

class Applicants {
  String? sId;
  String? profileImage;
  String? profileImageType;

  Applicants({this.sId, this.profileImage, this.profileImageType});

  Applicants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}

class ClosedJobs {
  String? sId;
  String? jobType;
  String? title;
  InterestedLoc? jobLocation;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? deadline;
  String? ageGroup;
  String? gender;
  DateTime? createdAt;
  String? experienceLevel;
  List<JobDetails>? jobDetails;
  List<SelectedCandidates>? selectedCandidates;
  Height? height;
  bool? isSwipe = true;

  ClosedJobs(
      {this.sId,
      this.jobType,
      this.title,
      this.jobLocation,
      this.description,
      this.startDate,
      this.endDate,
      this.deadline,
      this.ageGroup,
      this.gender,
      this.createdAt,
      this.experienceLevel,
      this.jobDetails,
      this.selectedCandidates,
      this.height});

  ClosedJobs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobType = json['jobType'];
    title = json['title'];
    jobLocation = json['jobLocation'] != null
        ? new InterestedLoc.fromJson(json['jobLocation'])
        : null;
    description = json['description'];
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    deadline = DateTime.parse(json['deadline']);
    ageGroup = json['ageGroup'];
    gender = json['gender'];
    createdAt = DateTime.parse(json['createdAt']);
    experienceLevel = json['experienceLevel'];
    if (json['jobDetails'] != null) {
      jobDetails = <JobDetails>[];
      json['jobDetails'].forEach((v) {
        jobDetails!.add(new JobDetails.fromJson(v));
      });
    }
    if (json['selectedCandidates'] != null) {
      selectedCandidates = <SelectedCandidates>[];
      json['selectedCandidates'].forEach((v) {
        selectedCandidates!.add(new SelectedCandidates.fromJson(v));
      });
    }
    height =
        json['height'] != null ? new Height.fromJson(json['height']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['experienceLevel'] = this.experienceLevel;
    if (this.jobDetails != null) {
      data['jobDetails'] = this.jobDetails!.map((v) => v.toJson()).toList();
    }
    if (this.selectedCandidates != null) {
      data['selectedCandidates'] =
          this.selectedCandidates!.map((v) => v.toJson()).toList();
    }
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    return data;
  }
}

class SelectedCandidates {
  String? sId;
  String? name;
  String? profileImage;
  String? profileImageType;

  SelectedCandidates(
      {this.sId, this.name, this.profileImage, this.profileImageType});

  SelectedCandidates.fromJson(Map<String, dynamic> json) {
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