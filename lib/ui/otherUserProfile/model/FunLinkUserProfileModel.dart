//
//
//
// class FunLinkUserProfileModel {
//   List<FunLinkUserProfileModelResult> result;
//   String message;
//   bool success;
//
//   FunLinkUserProfileModel({this.result, this.message, this.success});
//
//   FunLinkUserProfileModel.fromJson(Map<String, dynamic> json) {
//     if (json['result'] != null) {
//       result = <FunLinkUserProfileModelResult>[];
//       json['result'].forEach((v) {
//         result.add( FunLinkUserProfileModelResult.fromJson(v));
//       });
//     }
//     message = json['message'];
//     success = json['success'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     data['success'] = this.success;
//     return data;
//   }
// }
//
// class FunLinkUserProfileModelResult {
//   String sId;
//   String description;
//   String district;
//   String state;
//   String country;
//   int seen;
//   String musicName;
//   String musicId;
//   Null audio;
//   int likesCount;
//   int commentsCount;
//   List<Tags> tags;
//   List<String> talentCategory;
//   String createdAt;
//   String updatedAt;
//   List<Challenge> challenges;
//   bool followStatus;
//   Null likeStatus;
//   List<Media> media;
//   User user;
//
//   FunLinkUserProfileModelResult(
//       {this.sId,
//         this.description,
//         this.district,
//         this.state,
//         this.country,
//         this.seen,
//         this.musicName,
//         this.musicId,
//         this.audio,
//         this.likesCount,
//         this.commentsCount,
//         this.tags,
//         this.talentCategory,
//         this.createdAt,
//         this.updatedAt,
//         this.challenges,
//         this.followStatus,
//         this.likeStatus,
//         this.media,
//         this.user});
//
//   FunLinkUserProfileModelResult.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     description = json['description'];
//     district = json['district'];
//     state = json['state'];
//     country = json['country'];
//     seen = json['seen'];
//     musicName = json['musicName'];
//     musicId = json['musicId'];
//     audio = json['audio'];
//     likesCount = json['likesCount'];
//     commentsCount = json['commentsCount'];
//     if (json['tags'] != null) {
//       tags = <Tags>[];
//       json['tags'].forEach((v) {
//         tags.add(new Tags.fromJson(v));
//       });
//     }
//     talentCategory = json['talentCategory'].cast<String>();
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     if (json['challenges'] != null) {
//       challenges = <Null>[];
//       json['challenges'].forEach((v) {
//         //challenges!.add(new Null.fromJson(v));
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
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['description'] = this.description;
//     data['district'] = this.district;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['seen'] = this.seen;
//     data['musicName'] = this.musicName;
//     data['musicId'] = this.musicId;
//     data['audio'] = this.audio;
//     data['likesCount'] = this.likesCount;
//     data['commentsCount'] = this.commentsCount;
//     if (this.tags != null) {
//       data['tags'] = this.tags.map((v) => v.toJson()).toList();
//     }
//     data['talentCategory'] = this.talentCategory;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     if (this.challenges != null) {
//       //data['challenges'] = this.challenges!.map((v) => v.toJson()).toList();
//     }
//     data['followStatus'] = this.followStatus;
//     data['likeStatus'] = this.likeStatus;
//     if (this.media != null) {
//       data['media'] = this.media.map((v) => v.toJson()).toList();
//     }
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     return data;
//   }
// }
//
// class Tags {
//   String sId;
//   String username;
//
//   Tags({this.sId, this.username});
//
//   Tags.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     username = json['username'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['username'] = this.username;
//     return data;
//   }
// }
//
// class Media {
//   String path;
//   String type;
//
//   Media({this.path, this.type});
//
//   Media.fromJson(Map<String, dynamic> json) {
//     path = json['path'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['path'] = this.path;
//     data['type'] = this.type;
//     return data;
//   }
// }
//
//
// class Challenge {
//   Challenge({
//     this.id,
//     this.hashTag,
//   });
//
//   String id;
//   String hashTag;
//
//   factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
//     id: json["_id"],
//     hashTag: json["hashTag"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "hashTag": hashTag,
//   };
// }
//
// class User {
//   String nId;
//   String name;
//   String type;
//   String username;
//   String dob;
//   String bio;
//   String profession;
//   String profileImage;
//   Null avatarImage;
//
//   User(
//       {this.nId,
//         this.name,
//         this.type,
//         this.username,
//         this.dob,
//         this.bio,
//         this.profession,
//         this.profileImage,
//         this.avatarImage});
//
//   User.fromJson(Map<String, dynamic> json) {
//     nId = json['_id'];
//     name = json['name'];
//     type = json['type'];
//     username = json['username'];
//     dob = json['dob'];
//     bio = json['bio'];
//     profession = json['profession'];
//     profileImage = json['profileImage'];
//     avatarImage = json['avatarImage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.nId;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['username'] = this.username;
//     data['dob'] = this.dob;
//     data['bio'] = this.bio;
//     data['profession'] = this.profession;
//     data['profileImage'] = this.profileImage;
//     data['avatarImage'] = this.avatarImage;
//     return data;
//   }
// }


class FunLinkUserProfileModel {
  FunLinkUserProfileModel({
    this.result,
    this.message,
    this.success,
  });

  List<Result>? result;
  String? message;
  bool? success;

  factory FunLinkUserProfileModel.fromJson(Map<String, dynamic> json) => FunLinkUserProfileModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "message": message,
    "success": success,
  };
}



class Challenge {
  Challenge({
    this.id,
    this.hashTag,
  });

  String? id;
  String? hashTag;

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
    id: json["_id"],
    hashTag: json["hashTag"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "hashTag": hashTag,
  };
}

class Result {
  Result({
    this.id,
    this.description,
    this.district,
    this.state,
    this.country,
    this.seen,
    this.musicName,
    this.musicId,
    this.audio,
    this.likesCount,
    this.NewPostsAvailable,
    this.commentsCount,
    this.tags,
    this.talentCategory,
    this.createdAt,
    this.updatedAt,
    this.challenges,
    this.followStatus,
    this.likeStatus,
    this.media,
    this.user,
  });

  String? id;
  String? description;
  String? district;
  dynamic state;
  dynamic country;
  int? seen;
  String? musicName;
  String? musicId;
  dynamic audio;
  int? likesCount;
  bool? NewPostsAvailable;
  int? commentsCount;
  List<Tag>? tags;
  List<String>? talentCategory;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Challenge>? challenges;
  String? followStatus;
  dynamic likeStatus;
  List<Media>? media;
  User? user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    description: json["description"],
    district: json["district"],
    state: json["state"],
    country: json["country"],
    seen: json["seen"],
    musicName: json["musicName"],
    musicId: json["musicId"] == null ? null : json["musicId"],
    audio: json["audio"],
    likesCount: json["likesCount"],
    NewPostsAvailable: json["NewPostsAvailable"],
    commentsCount: json["commentsCount"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    talentCategory: json["talentCategory"] == null ? null : List<String>.from(json["talentCategory"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),

    challenges:json["challenges"] == null ? null : List<Challenge>.from(json["challenges"].map((x) => Challenge.fromJson(x))),
    followStatus: json["followStatus"],
    likeStatus: json["likeStatus"],
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "description": description,
    "district": district,
    "state": state,
    "country": country,
    "seen": seen,
    "musicName": musicName,
    "musicId": musicId == null ? null : musicId,
    "audio": audio,
    "likesCount": likesCount,
    "NewPostsAvailable": NewPostsAvailable,
    "commentsCount": commentsCount,
    "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
    "talentCategory": talentCategory == null ? null : List<dynamic>.from(talentCategory!.map((x) => x)),
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "challenges": List<dynamic>.from(challenges!.map((x) => x)),
    "followStatus": followStatus,
    "likeStatus": likeStatus,
    "media": List<dynamic>.from(media!.map((x) => x.toJson())),
    "user": user == null ? null : user!.toJson(),
  };
}

class Media {
  Media({
    this.path,
    this.type,
  });

  String? path;
  String? type;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    path: json["path"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "type": type,
  };
}

class Tag {
  Tag({
    this.id,
    this.username,
  });

  String? id;
  String? username;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["_id"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.type,
    this.username,
    this.dob,
    this.bio,
    this.profession,
    this.profileImage,
    this.avatarImage,
    this.profileImageType,
  });

  dynamic id;
  dynamic name;
  dynamic type;
  dynamic username;
  dynamic dob;
  dynamic bio;
  String? profession;
  String? profileImage;
  dynamic avatarImage;
  dynamic profileImageType;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    type: json["type"],
    username: json["username"],
    dob: json["dob"],
    bio: json["bio"],
    profession: json["profession"],
    profileImage: json["profileImage"],
    avatarImage: json["avatarImage"],
    profileImageType: json["profileImageType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "type": type,
    "username": username,
    "dob": dob,
    "bio": bio,
    "profession": profession,
    "profileImage": profileImage,
    "avatarImage": avatarImage,
  };
}
