import 'package:flutter/material.dart';

class OtherUserProfileFunlinksPostModel {
  List<OtherUserProfileFunlinksPostModelResult>? result;
  String? message;
  bool? success;

  OtherUserProfileFunlinksPostModel({this.result, this.message, this.success});

  OtherUserProfileFunlinksPostModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <OtherUserProfileFunlinksPostModelResult>[];
      json['result'].forEach((v) {
        result!.add(new OtherUserProfileFunlinksPostModelResult.fromJson(v));
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

class OtherUserProfileFunlinksPostModelResult {
  String? sId;
  String? description;
  String? district;
  String? state;
  String? country;
  int? seen;
  String? musicName;
  dynamic musicId;
  dynamic audio;
  int? likesCount;
  int? commentsCount;
  List<Null>? tags;
  List<Null>? talentCategory;
  String? createdAt;
  String? updatedAt;
  User? user;
  List<Challenges>? challenges;
  String? followStatus;
  int? likeStatus;
  List<Media>? media;

  OtherUserProfileFunlinksPostModelResult(
      {this.sId,
      this.description,
      this.district,
      this.state,
      this.country,
      this.seen,
      this.musicName,
      this.musicId,
      this.audio,
      this.likesCount,
      this.commentsCount,
      this.tags,
      this.talentCategory,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.challenges,
      this.followStatus,
      this.likeStatus,
      this.media});

  OtherUserProfileFunlinksPostModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    seen = json['seen'];
    musicName = json['musicName'];
    musicId = json['musicId'] == null ? null : json['musicId'];
    audio = json['audio'];
    likesCount = json['likesCount'];
    commentsCount = json['commentsCount'];
    // if (json['tags'] != null) {
    //   tags = new List<Null>();
    //   json['tags'].forEach((v) {
    //     tags.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['talentCategory'] != null) {
    //   talentCategory = new List<Null>();
    //   json['talentCategory'].forEach((v) {
    //     talentCategory.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['users'] != null ? new User.fromJson(json['users']) : null;
    if (json['challenges'] != null) {
      challenges = <Challenges>[];
      json['challenges'].forEach((v) {
        challenges!.add(new Challenges.fromJson(v));
      });
    }
    followStatus = json['followStatus'];
    likeStatus = json['likeStatus'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
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
    data['seen'] = this.seen;
    data['musicName'] = this.musicName;
    data['musicId'] = this.musicId;
    data['audio'] = this.audio;
    data['likesCount'] = this.likesCount;
    data['commentsCount'] = this.commentsCount;
    // if (this.tags != null) {
    //   data['tags'] = this.tags.map((v) => v.toJson()).toList();
    // }
    // if (this.talentCategory != null) {
    //   data['talentCategory'] =
    //       this.talentCategory.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.challenges != null) {
      data['challenges'] = this.challenges!.map((v) => v.toJson()).toList();
    }
    data['followStatus'] = this.followStatus;
    data['likeStatus'] = this.likeStatus;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? type;
  String? username;
  String? dob;
  String? bio;
  String? profession;
  String? profileImage;
  String? profileImageType;

  User(
      {this.sId,
      this.name,
      this.type,
      this.username,
      this.dob,
      this.bio,
      this.profession,
      this.profileImage,
      this.profileImageType});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    username = json['username'];
    dob = json['dob'];
    bio = json['bio'];
    profession = json['profession'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['username'] = this.username;
    data['dob'] = this.dob;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}

class Challenges {
  String? sId;
  String? hashTag;

  Challenges({this.sId, this.hashTag});

  Challenges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hashTag = json['hashTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hashTag'] = this.hashTag;
    return data;
  }
}

class Media {
  String? path;
  String? type;
  Image? image;

  Media({this.path, this.type});

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
