

class ProfileFunLinksModel {
  List<ProfileFunLinksModelResult>? result;
  String? message;
  bool? success;

  ProfileFunLinksModel({this.result, this.message, this.success});

  ProfileFunLinksModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProfileFunLinksModelResult>[];
      json['result'].forEach((v) {
        result?.add(new ProfileFunLinksModelResult.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result?.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class ProfileFunLinksModelResult {
  String? sId;
  String? name;
  String? profession;
  List<Null>? restrictedList;
  bool? isRegistered;
  bool? isBlocked;
  bool? isDeleted;
  String? profileImage;
  String? profileImageType;

  String? bio;
  List<SavedMusic>? savedMusic;
  List<ProfileFunLinksModelResultPosts>? posts;
  MasterUser? masterUser;
  List<Ambassador>? ambassador;
  int? totalLikes;
  int? totalViews;
  int? videos;

  ProfileFunLinksModelResult(
      {this.sId,
        this.name,
        this.profession,
        this.restrictedList,
        this.isRegistered,
        this.isBlocked,
        this.isDeleted,
        this.profileImage,
        this.savedMusic,
        this.profileImageType,
        this.posts,
        this.bio,
        this.masterUser,
        this.ambassador,
        this.totalLikes,
        this.totalViews,
        this.videos});

  ProfileFunLinksModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profession = json['profession'];
    if (json['restrictedList'] != null) {
      restrictedList = <Null>[];
      json['restrictedList'].forEach((v) {
        //restrictedList.add(new Null.fromJson(v));
      });
    }
    isRegistered = json['isRegistered'];
    profileImageType = json['profileImageType'];
    bio = json['bio'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    profileImage = json['profileImage'];
    if (json['savedMusic'] != null) {
      savedMusic = <SavedMusic>[];
      json['savedMusic'].forEach((v) {
        savedMusic?.add(new SavedMusic.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = <ProfileFunLinksModelResultPosts>[];
      json['posts'].forEach((v) {
        posts?.add(new ProfileFunLinksModelResultPosts.fromJson(v));
      });
    }
    masterUser = json['masterUser'] != null?
    new MasterUser.fromJson(json['masterUser'])
        : null;
    if (json['ambassador'] != null) {
      ambassador = <Ambassador>[];
      json['ambassador'].forEach((v) {
        ambassador?.add(new Ambassador.fromJson(v));
      });
    }
    totalLikes = json['totalLikes'];
    totalViews = json['totalViews'];
    videos = json['videos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profession'] = this.profession;
    if (this.restrictedList != null) {
      // data['restrictedList'] =
      //this.restrictedList.map((v) => v.toJson()).toList();
    }
    data['isRegistered'] = this.isRegistered;
    data['profileImageType'] = this.profileImageType;
    data['bio'] = this.bio;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    data['profileImage'] = this.profileImage;
    if (this.savedMusic != null) {
      data['savedMusic'] = this.savedMusic?.map((v) => v.toJson()).toList();
    }
    if (this.posts != null) {
      data['posts'] = this.posts?.map((v) => v.toJson()).toList();
    }
    if (this.masterUser != null) {
      data['masterUser'] = this.masterUser?.toJson();
    }
    if (this.ambassador != null) {
      data['ambassador'] = this.ambassador?.map((v) => v.toJson()).toList();
    }
    data['totalLikes'] = this.totalLikes;
    data['totalViews'] = this.totalViews;
    data['videos'] = this.videos;
    return data;
  }
}

class SavedMusic {
  String? sId;
  String? music;
  String? name;
  int? duration;

  SavedMusic({this.sId, this.music, this.name, this.duration});

  SavedMusic.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    music = json['music'];
    name = json['name'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['music'] = this.music;
    data['name'] = this.name;
    data['duration'] = this.duration;
    return data;
  }
}

class ProfileFunLinksModelResultPosts {
  String? sId;
  String? video;
  List<Null>? challengeId;
  String? description;
  String? district;
  String? state;
  String? country;
  String? userId;
  int? seen;
  Null? musicName;
  Null? musicId;
  Null? audio;
  int? likesCount;
  int? commentsCount;
  bool? isBlocked;
  bool? isDeleted;
  bool? isSafe;
  String? createdAt;
  String? updatedAt;
  Null? closeUp;
  Null? medium;
  Null? long;
  Null? pose1;
  Null? pose2;
  Null? additional;

  ProfileFunLinksModelResultPosts(
      {this.sId,
        this.video,
        this.challengeId,
        this.description,
        this.district,
        this.state,
        this.country,
        this.userId,
        this.seen,
        this.musicName,
        this.musicId,
        this.audio,
        this.likesCount,
        this.commentsCount,
        this.isBlocked,
        this.isDeleted,
        this.isSafe,
        this.createdAt,
        this.updatedAt,
        this.closeUp,
        this.medium,
        this.long,
        this.pose1,
        this.pose2,
        this.additional});

  ProfileFunLinksModelResultPosts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    video = json['video'];
    if (json['challengeId'] != null) {
      challengeId = <Null>[];
      json['challengeId'].forEach((v) {
        //challengeId!.add(new Null.fromJson(v));
      });
    }
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    userId = json['userId'];
    seen = json['seen'];
    musicName = json['musicName'];
    musicId = json['musicId'];
    audio = json['audio'];
    likesCount = json['likesCount'];
    commentsCount = json['commentsCount'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    isSafe = json['isSafe'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    closeUp = json['closeUp'];
    medium = json['medium'];
    long = json['long'];
    pose1 = json['pose1'];
    pose2 = json['pose2'];
    additional = json['additional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['video'] = this.video;
    if (this.challengeId != null) {
      //data['challengeId'] = this.challengeId!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['userId'] = this.userId;
    data['seen'] = this.seen;
    data['musicName'] = this.musicName;
    data['musicId'] = this.musicId;
    data['audio'] = this.audio;
    data['likesCount'] = this.likesCount;
    data['commentsCount'] = this.commentsCount;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    data['isSafe'] = this.isSafe;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['closeUp'] = this.closeUp;
    data['medium'] = this.medium;
    data['long'] = this.long;
    data['pose1'] = this.pose1;
    data['pose2'] = this.pose2;
    data['additional'] = this.additional;
    return data;
  }
}

class MasterUser {
  String? district;
  String? state;
  String? country;
  String? continent;
  String? profileImage;
  String? profileImageType;
  int? fameCoins;
  String? dob;
  String? username;

  MasterUser(
      {this.district,
        this.state,
        this.country,
        this.dob,
        this.continent,
        this.profileImage,this.profileImageType,
        this.fameCoins,
        this.username});

  MasterUser.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    dob = json['dob'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    fameCoins = json['fameCoins'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['dob'] = this.dob;
    data['profileImage'] = this.profileImage;
    data['fameCoins'] = this.fameCoins;
    data['username'] = this.username;
    return data;
  }
}

class Ambassador {
  String? title;
  String? level;

  Ambassador({this.title, this.level});

  Ambassador.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['level'] = this.level;
    return data;
  }
}