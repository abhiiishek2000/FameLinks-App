
// class GetParticularUserProfileModel {
//   GetParticularUserProfileModelResult result;
//   String message;
//   bool success;
//
//   GetParticularUserProfileModel({this.result, this.message, this.success});
//
//   GetParticularUserProfileModel.fromJson(Map<String, dynamic> json) {
//     result =
//     json['result'] != null ? new GetParticularUserProfileModelResult.fromJson(json['result']) : null;
//     message = json['message'];
//     success = json['success'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result.toJson();
//     }
//     data['message'] = this.message;
//     data['success'] = this.success;
//     return data;
//   }
// }
//
// class GetParticularUserProfileModelResult {
//   String sId;
//   String description;
//   String district;
//   String state;
//   String country;
//   int likes0Count;
//   int likes1Count;
//   int likes2Count;
//   int commentsCount;
//   String createdAt;
//   String updatedAt;
//   User user;
//   List<WinnerTitle> winnerTitle;
//   List<Null> challenges;
//   String followStatus;
//   int likeStatus;
//   List<Media> media;
//
//   GetParticularUserProfileModelResult(
//       {this.sId,
//         this.description,
//         this.district,
//         this.state,
//         this.country,
//         this.likes0Count,
//         this.likes1Count,
//         this.likes2Count,
//         this.commentsCount,
//         this.createdAt,
//         this.updatedAt,
//         this.user,
//         this.winnerTitle,
//         this.challenges,
//         this.followStatus,
//         this.likeStatus,
//         this.media});
//
//   GetParticularUserProfileModelResult.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     description = json['description'];
//     district = json['district'];
//     state = json['state'];
//     country = json['country'];
//     likes0Count = json['likes0Count'];
//     likes1Count = json['likes1Count'];
//     likes2Count = json['likes2Count'];
//     commentsCount = json['commentsCount'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     user = json['user'] != null? new User.fromJson(json['user']) : null;
//     if (json['winnerTitle'] != null) {
//       winnerTitle = <WinnerTitle>[];
//       json['winnerTitle'].forEach((v) {
//         winnerTitle.add(new WinnerTitle.fromJson(v));
//       });
//     }
//     if (json['challenges'] != null) {
//       challenges = <Null>[];
//       json['challenges'].forEach((v) {
//        // challenges!.add(new Null.fromJson(v));
//       });
//     }
//     followStatus = json['followStatus'];
//     likeStatus = json['likeStatus'];
//     if (json['media'] != null) {
//       media = <Media>[];
//       json['media'].forEach((v) {
//         media.add(new Media.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['description'] = this.description;
//     data['district'] = this.district;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['likes0Count'] = this.likes0Count;
//     data['likes1Count'] = this.likes1Count;
//     data['likes2Count'] = this.likes2Count;
//     data['commentsCount'] = this.commentsCount;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     if (this.winnerTitle != null) {
//       data['winnerTitle'] = this.winnerTitle.map((v) => v.toJson()).toList();
//     }
//     if (this.challenges != null) {
//      // data['challenges'] = this.challenges.map((v) => v.toJson()).toList();
//     }
//     data['followStatus'] = this.followStatus;
//     data['likeStatus'] = this.likeStatus;
//     if (this.media != null) {
//       data['media'] = this.media.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class User {
//   String sId;
//   String name;
//   String type;
//   String username;
//   String dob;
//   String bio;
//   String profession;
//   String profileImage;
//
//   User(
//       {this.sId,
//         this.name,
//         this.type,
//         this.username,
//         this.dob,
//         this.bio,
//         this.profession,
//         this.profileImage});
//
//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     type = json['type'];
//     username = json['username'];
//     dob = json['dob'];
//     bio = json['bio'];
//     profession = json['profession'];
//     profileImage = json['profileImage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['username'] = this.username;
//     data['dob'] = this.dob;
//     data['bio'] = this.bio;
//     data['profession'] = this.profession;
//     data['profileImage'] = this.profileImage;
//     return data;
//   }
// }
//
// class WinnerTitle {
//   String sId;
//   String name;
//   int likesCount;
//
//   WinnerTitle({this.sId, this.name, this.likesCount});
//
//   WinnerTitle.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     likesCount = json['likesCount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['likesCount'] = this.likesCount;
//     return data;
//   }
// }



import 'package:flutter/material.dart';

class GetParticularUserProfileModel {
  List<GetParticularUserProfileModelResult>? result;
  String? message;
  bool? success;

  GetParticularUserProfileModel({this.result, this.message, this.success});

  GetParticularUserProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result =  <GetParticularUserProfileModelResult>[];
      json['result'].forEach((v) {
        result!.add(new GetParticularUserProfileModelResult.fromJson(v));
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

class GetParticularUserProfileModelResult {
  String? sId;
  String? description;
  String? district;
  String? state;
  String? country;
  int? likes0Count;
  int? likes1Count;
  int? likes2Count;
  int? commentsCount;
  Users? users;
  String? createdAt;
  String? updatedAt;
  List<Challenges>? challenges;
  int? isWelcomeVideo;
  dynamic likeStatus;
  bool? ambassadorTrendz;
  bool? famelinksContest;
  List<Media>? media;

  GetParticularUserProfileModelResult(
      {this.sId,
        this.description,
        this.district,
        this.state,
        this.country,
        this.likes0Count,
        this.likes1Count,
        this.likes2Count,
        this.commentsCount,
        this.createdAt,this.users,
        this.updatedAt,
        this.challenges,
        this.isWelcomeVideo,
        this.likeStatus,
        this.ambassadorTrendz,
        this.famelinksContest,
        this.media});

  GetParticularUserProfileModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    likes0Count = json['likes0Count'];
    likes1Count = json['likes1Count'];
    likes2Count = json['likes2Count'];
    commentsCount = json['commentsCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
    if (json['challenges'] != null) {
      challenges = <Challenges>[];
      json['challenges'].forEach((v) {
        challenges!.add(new Challenges.fromJson(v));
      });
    }
    isWelcomeVideo = json['isWelcomeVideo'];
    likeStatus = json['likeStatus'];
    ambassadorTrendz = json['ambassadorTrendz'];
    famelinksContest = json['famelinksContest'];
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
    data['likes0Count'] = this.likes0Count;
    data['likes1Count'] = this.likes1Count;
    data['likes2Count'] = this.likes2Count;
    data['commentsCount'] = this.commentsCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.challenges != null) {
      data['challenges'] = this.challenges!.map((v) => v.toJson()).toList();
    }
    data['isWelcomeVideo'] = this.isWelcomeVideo;
    data['likeStatus'] = this.likeStatus;
    data['ambassadorTrendz'] = this.ambassadorTrendz;
    data['famelinksContest'] = this.famelinksContest;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Users {
  String? sId;
  String? name;
  String? type;
  String? username;
  String? dob;
  String? bio;
  String? profession;
  String? profileImage;
  String? profileImageType;

  Users(
      {this.sId,
        this.name,
        this.type,
        this.username,
        this.dob,
        this.bio,
        this.profession,
        this.profileImage,
        this.profileImageType});

  Users.fromJson(Map<String, dynamic> json) {
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