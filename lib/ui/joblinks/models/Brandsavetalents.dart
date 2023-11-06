/// result : [{"_id":"63fcc0d6dbc4fa3dbb872c86","name":"Naznin Developer","profileImage":"famelinks-6d6c5a6c-c811-4723-b816-06bfb283c56b-xs","profileImageType":"avatar","masterProfile":{"_id":"63fcc0d6dbc4fa3dbb872c8d","profileImage":"famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs","profileImageType":"image","followersCount":10,"username":"naznin_27960845","achievements":"","age":30},"invitation":false}]
/// message : "Saved Talents fetched succesfuly"
/// success : true

class Brandsavetalents {
  Brandsavetalents({
    this.result,
    this.message,
    this.success,
  });

  Brandsavetalents.fromJson(dynamic json) {
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
  Brandsavetalents copyWith({
    List<Result>? result,
    String? message,
    bool? success,
  }) =>
      Brandsavetalents(
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

/// _id : "63fcc0d6dbc4fa3dbb872c86"
/// name : "Naznin Developer"
/// profileImage : "famelinks-6d6c5a6c-c811-4723-b816-06bfb283c56b-xs"
/// profileImageType : "avatar"
/// masterProfile : {"_id":"63fcc0d6dbc4fa3dbb872c8d","profileImage":"famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs","profileImageType":"image","followersCount":10,"username":"naznin_27960845","achievements":"","age":30}
/// invitation : false

class Result {
  Result({
    this.id,
    this.name,
    this.profileImage,
    this.profileImageType,
    this.masterProfile,
    this.invitation,
  });

  Result.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    masterProfile = json['masterProfile'] != null
        ? MasterProfile.fromJson(json['masterProfile'])
        : null;
    invitation = json['invitation'];
  }
  String? id;
  String? name;
  String? profileImage;
  String? profileImageType;
  MasterProfile? masterProfile;
  bool? invitation;
  Result copyWith({
    String? id,
    String? name,
    String? profileImage,
    String? profileImageType,
    MasterProfile? masterProfile,
    bool? invitation,
  }) =>
      Result(
        id: id ?? this.id,
        name: name ?? this.name,
        profileImage: profileImage ?? this.profileImage,
        profileImageType: profileImageType ?? this.profileImageType,
        masterProfile: masterProfile ?? this.masterProfile,
        invitation: invitation ?? this.invitation,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['profileImage'] = profileImage;
    map['profileImageType'] = profileImageType;
    if (masterProfile != null) {
      map['masterProfile'] = masterProfile?.toJson();
    }
    map['invitation'] = invitation;
    return map;
  }
}

/// _id : "63fcc0d6dbc4fa3dbb872c8d"
/// profileImage : "famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs"
/// profileImageType : "image"
/// followersCount : 10
/// username : "naznin_27960845"
/// achievements : ""
/// age : 30

class MasterProfile {
  MasterProfile({
    this.id,
    this.name,
    this.profileImage,
    this.profileImageType,
    this.followersCount,
    this.username,
    this.achievements,
    this.age,
  });

  MasterProfile.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'] ?? '';
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    followersCount = json['followersCount'];
    username = json['username'];
    achievements = json['achievements'];
    age = json['age'];
  }
  String? id;
  String? name;
  String? profileImage;
  String? profileImageType;
  num? followersCount;
  String? username;
  String? achievements;
  num? age;
  MasterProfile copyWith({
    String? id,
    String? name,
    String? profileImage,
    String? profileImageType,
    num? followersCount,
    String? username,
    String? achievements,
    num? age,
  }) =>
      MasterProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        profileImage: profileImage ?? this.profileImage,
        profileImageType: profileImageType ?? this.profileImageType,
        followersCount: followersCount ?? this.followersCount,
        username: username ?? this.username,
        achievements: achievements ?? this.achievements,
        age: age ?? this.age,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['profileImage'] = profileImage;
    map['profileImageType'] = profileImageType;
    map['followersCount'] = followersCount;
    map['username'] = username;
    map['achievements'] = achievements;
    map['age'] = age;
    return map;
  }
}
