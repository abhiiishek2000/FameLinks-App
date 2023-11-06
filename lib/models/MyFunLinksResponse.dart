import 'famelinks_model.dart';

class MyFunLinksResponse {
  List<MyFunLinksResult>? result;
  String? message;
  bool? success;

  MyFunLinksResponse({this.result, this.message, this.success});

  MyFunLinksResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <MyFunLinksResult>[];
      json['result'].forEach((v) {
        result!.add(new MyFunLinksResult.fromJson(v));
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

class MyFunLinksResult {
  String? sId;
  String? video;
  String? description;
  String? district;
  String? state;
  String? country;
  int? likesCount;
  int? commentsCount;
  String? createdAt;
  String? updatedAt;
  String? musicId;
  String? musicName;
  MyFunLinkUser? user;
  List<Challenge>? challenges;
  List<Media>? images;
  String? followStatus;
  bool? likeStatus;

  MyFunLinksResult(
      {this.sId,
        this.video,
        this.description,
        this.district,
        this.state,
        this.country,
        this.likesCount,
        this.commentsCount,
        this.createdAt,
        this.updatedAt,
        this.musicId,
        this.musicName,
        this.user,
        this.challenges,
        this.followStatus,
        this.images,
        this.likeStatus});

  MyFunLinksResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    video = json['video'];
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    likesCount = json['likesCount'];
    commentsCount = json['commentsCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    musicId = json['musicId'] != null ?json['musicId']:"";
    musicName = json['musicName'] != null ? json['musicName']:"";
    user = json['user'] != null ? new MyFunLinkUser.fromJson(json['user']) : null;
    if (json['challenges'] != null) {
      challenges = <Challenge>[];
      json['challenges'].forEach((v) {
        challenges!.add(new Challenge.fromJson(v));
      });
    }
    followStatus = json['followStatus'];
    likeStatus = json['likeStatus'] == null ? false:true;
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
    data['video'] = this.video;
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
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

class MyFunLinkUser {
  String? sId;
  String? name;
  String? bio;
  String? profession;
  String? dob;
  String? profileImage;

  MyFunLinkUser(
      {this.sId,
        this.name,
        this.bio,
        this.profession,
        this.dob,
        this.profileImage});

  MyFunLinkUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'] != null ? json['bio']:"";
    profession = json['profession'] != null ?json['profession']:"";
    dob = json['dob'] != null ? json['dob']:"";
    profileImage = json['profileImage'] != null ?json['profileImage']:"";
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
class Challenge {
    Challenge({
        this.id,
        this.hashTag,
        this.totalImpressions,
        this.totalPost,
        this.totalParticipants,
        this.createdBy,
        this.type,
        this.percentCompleted,
        this.participantsCount,
        this.name,
    });

    String? id;
    String? hashTag;
    int? totalImpressions;
    int? totalPost;
    int? totalParticipants;
    List<CreatedBy>? createdBy;
    String? type;
    dynamic percentCompleted;
    int? participantsCount;
    String? name;

    factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        id: json["_id"],
        hashTag: json["hashTag"],
        totalImpressions: json["totalImpressions"],
        totalPost: json["totalPost"],
        totalParticipants: json["totalParticipants"],
        createdBy: List<CreatedBy>.from(json["createdBy"].map((x) => CreatedBy.fromJson(x))),
        type: json["type"],
        percentCompleted: json["percentCompleted"],
        participantsCount: json["participantsCount"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "hashTag": hashTag,
        "totalImpressions": totalImpressions,
        "totalPost": totalPost,
        "totalParticipants": totalParticipants,
        "createdBy": List<dynamic>.from(createdBy!.map((x) => x.toJson())),
        "type": type,
        "percentCompleted": percentCompleted,
        "participantsCount": participantsCount,
        "name": name,
    };
}

class CreatedBy {
    CreatedBy({
        this.name,
    });

    String? name;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

