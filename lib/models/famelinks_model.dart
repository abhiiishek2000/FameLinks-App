class FamelinksResponse {
  List<Result>? result;
  String? message;
  bool? success;

  FamelinksResponse({this.result, this.message, this.success});

  FamelinksResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
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

class Result {
  String? sId;
  String? description;
  String? district;
  String? state;
  String? price;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? typeOf;
  String? title;
  String? saveUrl;
  String? buttonName;
  String? musicName;
  String? musicId;
  int? maleSeen;
  int? femaleSeen;
  int? likeStatus;
  int? likesCount;
  int? likes0Count;
  int? likes1Count;
  int? likes2Count;
  int? commentsCount;
  dynamic? followStatus;
  FameUser? user;
  List<Challenges>? challenges;
  List<Challenges>? hashTag;
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
      this.type,
      this.saveUrl,
      this.buttonName,
      this.typeOf,
      this.musicName,
      this.musicId,
      this.likeStatus,
      this.likesCount,
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
      this.hashTag,
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
    type = json['type'];
    typeOf = json['typeOf'];
    title = json['name'];
    saveUrl = json['purchaseUrl'];
    buttonName = json['buttonName'];
    price = json['price'] != null ? json['price'].toString() : null;
    musicName = json['musicName'];
    musicId = json['musicId'];
    commentsCount = json['commentsCount'];
    likesCount = json['likesCount'] != null ? json['likesCount'] : 0;
    likes0Count = json['likes0Count'] != null ? json['likes0Count'] : 0;
    likes1Count = json['likes1Count'] != null ? json['likes1Count'] : 0;
    likes2Count = json['likes2Count'] != null ? json['likes2Count'] : 0;
    followStatus = json['followStatus'];
    winnerTitles =
        json['winnerTitles'] != null ? json['winnerTitles'].cast<String>() : [];
    user = json['user'] != null ? new FameUser.fromJson(json['user']) : null;
    if (json['users'] != null) {
      json['users'].forEach((v) {
        user = new FameUser.fromJson(v);
      });
    }
    if (json['challenges'] != null) {
      challenges = <Challenges>[];
      json['challenges'].forEach((v) {
        challenges!.add(new Challenges.fromJson(v));
      });
    }
    if (json.containsKey("hashTag")) {
      hashTag = <Challenges>[];
      json['hashTag'].forEach((v) {
        hashTag!.add(new Challenges.fromJson(v));
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
    data['type'] = this.type;
    data['name'] = this.title;
    data['purchaseUrl'] = this.saveUrl;
    data['buttonName'] = this.buttonName;
    data['typeOf'] = this.typeOf;
    data['musicName'] = this.musicName;
    data['musicId'] = this.musicId;
    data['femaleSeen'] = this.femaleSeen;
    data['commentsCount'] = this.commentsCount;
    data['maleSeen'] = this.maleSeen;
    data['likeStatus'] = this.likeStatus;
    data['likesCount'] = this.likesCount;
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
    if (this.hashTag != null) {
      data['hashTag'] = this.hashTag!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['media'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FameUser {
  String? sId;
  String? name;
  String? username;
  String? bio;
  String? type;
  String? profession;
  String? dob;
  String? profileImage;

  FameUser(
      {this.sId,
      this.name,
      this.type,
      this.bio,
      this.profession,
      this.dob,
      this.profileImage});

  FameUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    bio = json['bio'];
    type = json['type'];
    profession = json['profession'];
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
  String? hashTag;
  dynamic? percentCompleted;
  int? participantsCount;

  Challenges({this.sId, this.name, this.hashTag});

  Challenges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    hashTag = json['hashTag'];
    percentCompleted =
        json['percentCompleted'] != null ? json['percentCompleted'] : 0;
    participantsCount = json['participantsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['percentCompleted'] = this.percentCompleted;
    data['participantsCount'] = this.participantsCount;
    return data;
  }
}

class Media {
  String? path;
  String? type;
  String? thumbnail;

  Media({this.path, this.type, this.thumbnail});

  Media.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    return data;
  }
}
