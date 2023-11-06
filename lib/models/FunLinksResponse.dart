class FunLinksResponse {
  List<FunLinksResult>? result;
  String? message;
  bool? success;

  FunLinksResponse({this.result, this.message, this.success});

  FunLinksResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FunLinksResult>[];
      json['result'].forEach((v) {
        result!.add(new FunLinksResult.fromJson(v));
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

class FunLinksResult {
  String? sId;
  String? description;
  String? district;
  String? state;
  String? country;
  int? seen;
  int? likesCount;
  int? commentsCount;
  String? createdAt;
  String? updatedAt;
  String? musicId;
  String? audio;
  String? musicName;
  User? user;
  List<Challenges>? challenges;
  List<Media>? images;
  bool? followStatus;
  int? likeStatus;

  FunLinksResult(
      {this.sId,
        this.description,
        this.district,
        this.state,
        this.country,
        this.seen,
        this.likesCount,
        this.commentsCount,
        this.createdAt,
        this.updatedAt,
        this.musicId,
        this.musicName,
        this.user,
        this.audio,
        this.challenges,
        this.followStatus,
        this.images,
        this.likeStatus});

  FunLinksResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    seen = json['seen'];
    likesCount = json['likesCount'];
    audio = json['audio'];
    commentsCount = json['commentsCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    musicId = json['musicId'];
    musicName = json['musicName'];
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
    followStatus = json['followStatus'];
    likeStatus = json['likeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['seen'] = this.seen;
    data['audio'] = this.audio;
    data['likesCount'] = this.likesCount;
    data['commentsCount'] = this.commentsCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['musicId'] = this.musicId;
    data['musicName'] = this.musicName;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.challenges != null) {
      data['challenges'] = this.challenges!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['media'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['followStatus'] = this.followStatus;
    data['likeStatus'] = this.likeStatus;
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

class User {
  String? sId;
  String? name;
  String? username;
  String? bio;
  String? type;
  String? profession;
  String? dob;
  String? profileImage;

  User(
      {this.sId,
        this.name,
        this.type,
        this.bio,
        this.profession,
        this.dob,
        this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    bio = json['bio'];
    profession = json['profession'];
    type = json['type'];
    dob = json['dob'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['type'] = this.type;
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
