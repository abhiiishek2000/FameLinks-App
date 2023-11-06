class FameLinkResponse {
  Result? result;
  String? message;
  bool? success;

  FameLinkResponse({this.result, this.message, this.success});

  FameLinkResponse.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  String? sId;
  String? description;
  String? district;
  String? state;
  String? country;
  String? createdAt;
  String? updatedAt;
  int? maleSeen;
  int? femaleSeen;
  int? likeStatus;
  int? likes0Count;
  int? likes1Count;
  int? likes2Count;
  int? commentsCount;
  bool? followStatus;
  User? user;
  List<Challenges>? challenges;
  List<Media>? images;
  List<String>? winnerTitles;

  Result(
      {this.sId,
        this.description,
        this.district,
        this.state,
        this.country,
        this.createdAt,
        this.updatedAt,
        this.likeStatus,
        this.likes0Count,
        this.likes1Count,
        this.likes2Count,
        this.commentsCount,
        this.maleSeen,
        this.femaleSeen,
        this.followStatus,
        this.user,
        this.challenges,
        this.winnerTitles,
        this.images});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    likeStatus = json['likeStatus'];
    femaleSeen = json['femaleSeen'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    maleSeen = json['maleSeen'];
    commentsCount = json['commentsCount'];
    likes0Count = json['likes0Count'] != null ? json['likes0Count'] : 0;
    likes1Count = json['likes1Count'] != null ? json['likes1Count'] : 0;
    likes2Count = json['likes2Count'] != null ? json['likes2Count'] : 0;
    followStatus = json['followStatus'];
    winnerTitles = json['winnerTitles'] != null ? json['winnerTitles'].cast<String>() : [];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['challenges'] != null) {
      challenges = <Challenges>[];
      json['challenges'].forEach((v) {
        challenges!.add(new Challenges.fromJson(v));
      });
    }
    if (json['media'] != null) {
      images = <Media>[];
      json['media'].forEach((v) {
        images!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['femaleSeen'] = this.femaleSeen;
    data['commentsCount'] = this.commentsCount;
    data['maleSeen'] = this.maleSeen;
    data['likeStatus'] = this.likeStatus;
    data['likes0Count'] = this.likes0Count;
    data['likes1Count'] = this.likes1Count;
    data['likes2Count'] = this.likes2Count;
    data['followStatus'] = this.followStatus;
    data['winnerTitles'] = this.winnerTitles;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.challenges != null) {
      data['challenges'] = this.challenges!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['media'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? bio;
  String? profession;
  String? dob;
  String? profileImage;

  User(
      {this.sId,
        this.name,
        this.bio,
        this.profession,
        this.dob,
        this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    profession = json['profession'];
    dob = json['dob'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['dob'] = this.dob;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Challenges {
  String? sId;
  String? name;

  Challenges({this.sId, this.name});

  Challenges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Media {
  String?  path;
  String? type;

  Media(
      {this.path,
        this.type});

  Media.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    return data;
  }
}
