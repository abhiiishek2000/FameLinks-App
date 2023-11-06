class ProfileFameLinksModel {
  List<ProfileFameLinksModelResult>? result;
  String? message;
  bool? success;

  ProfileFameLinksModel({this.result, this.message, this.success});

  ProfileFameLinksModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProfileFameLinksModelResult>[];
      json['result'].forEach((v) {
        result?.add(new ProfileFameLinksModelResult.fromJson(v));
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

class ProfileFameLinksModelResult {
  String? sId;
  String? name;
  String? bio;
  String? profession;
  String? avatarImage;
  String? profileImage;
  String? profileImageType;
  int? likes0Count;
  int? likes1Count;
  int? likes2Count;
  bool? isRegistered;
  bool? isBlocked;
  bool? isDeleted;
  List<Posts>? posts;
  FameUser? masterUser;
  List<TrendsWon>? trendsWon;
  List<TitlesWon>? titlesWon;
  List<Ambassador>? ambassador;
  int? hearts;
  int? score;
  int? trendzSet;

  ProfileFameLinksModelResult(
      {this.sId,
        this.name,
        this.avatarImage,
        this.bio,
        this.profession,
        this.profileImage,
        this.likes0Count,
        this.likes1Count,
        this.likes2Count,
        this.isRegistered,
        this.isBlocked,
        this.isDeleted,
        this.posts,
        this.masterUser,
        this.trendsWon,this.profileImageType,
        this.titlesWon,
        this.ambassador,
        this.hearts,
        this.score,
        this.trendzSet});

  ProfileFameLinksModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    // avatarImage = json['avatarImage'];
    profession = json['profession'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    likes0Count = json['likes0Count'];
    likes1Count = json['likes1Count'];
    likes2Count = json['likes2Count'];
    // if (json['restrictedList'] = null) {
    //   restrictedList = <Null>[];
    //   json['restrictedList'].forEach((v) {
    //     restrictedList.add(new Null.fromJson(v));
    //   });
    // }
    isRegistered = json['isRegistered'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts?.add(new Posts.fromJson(v));
      });
    }
    masterUser = json['masterUser'] != null?
    new FameUser.fromJson(json['masterUser'])
        : null;
    if (json['trendsWon'] != null) {
      trendsWon = <TrendsWon>[];
      json['trendsWon'].forEach((v) {
        trendsWon?.add(new TrendsWon.fromJson(v));
      });
    }
    if (json['titlesWon'] != null) {
      titlesWon = <TitlesWon>[];
      json['titlesWon'].forEach((v) {
        titlesWon?.add(new TitlesWon.fromJson(v));
      });
    }
    if (json['ambassador'] != null) {
      ambassador = <Ambassador>[];
      json['ambassador'].forEach((v) {
        ambassador?.add(new Ambassador.fromJson(v));
      });
    }
    hearts = json['hearts'];
    score = json['score'];
    trendzSet = json['trendzSet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['profileImage'] = this.profileImage;
    data['likes0Count'] = this.likes0Count;
    data['avatarImage'] = this.avatarImage;
    data['likes1Count'] = this.likes1Count;
    data['likes2Count'] = this.likes2Count;
    // if (this.restrictedList = null) {
    //   data['restrictedList'] =
    //       this.restrictedList.map((v) => v.toJson()).toList();
    // }
    data['isRegistered'] = this.isRegistered;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    if (this.posts != null) {
      data['posts'] = this.posts?.map((v) => v.toJson()).toList();
    }
    if (this.masterUser != null) {
      data['masterUser'] = this.masterUser?.toJson();
    }
    if (this.trendsWon != null) {
      data['trendsWon'] = this.trendsWon?.map((v) => v.toJson()).toList();
    }
    if (this.titlesWon != null) {
      data['titlesWon'] = this.titlesWon?.map((v) => v.toJson()).toList();
    }
    if (this.ambassador != null) {
      data['ambassador'] = this.ambassador?.map((v) => v.toJson()).toList();
    }
    data['hearts'] = this.hearts;
    data['score'] = this.score;
    data['trendzSet'] = this.trendzSet;
    return data;
  }
}

class Posts {
  String? sId;
  String? closeUp;
  String? medium;
  String? isWelcomeVideo;
  String? long;
  String? pose1;
  String? pose2;
  String? additional;
  String? video;
  String? description;
  String? district;
  String? state;
  String? country;
  String? userId;
  int? maleSeen;
  int? femaleSeen;
  int? likes0Count;
  int? likes1Count;
  int? likes2Count;
  int? commentsCount;
  bool? isBlocked;
  bool? isDeleted;
  bool? isSafe;
  String? createdAt;
  String? updatedAt;

  Posts(
      {this.sId,
        this.closeUp,
        this.medium,
        this.long,
        this.pose1,
        this.pose2,
        this.isWelcomeVideo,
        this.additional,
        this.video,
        this.description,
        this.district,
        this.state,
        this.country,
        this.userId,
        this.maleSeen,
        this.femaleSeen,
        this.likes0Count,
        this.likes1Count,
        this.likes2Count,
        this.commentsCount,
        this.isBlocked,
        this.isDeleted,
        this.isSafe,
        this.createdAt,
        this.updatedAt});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    closeUp = json['closeUp'];
    medium = json['medium'];
    long = json['long'];
    pose1 = json['pose1'];
    isWelcomeVideo = json['isWelcomeVideo'].toString();
    pose2 = json['pose2'];
    additional = json['additional'];
    video = json['video'];
    // if (json['challengeId'] = null) {
    //   challengeId = <Null>[];
    //   json['challengeId'].forEach((v) {
    //     challengeId.add(new Null.fromJson(v));
    //   });
    // }
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    userId = json['userId'];
    maleSeen = json['maleSeen'];
    femaleSeen = json['femaleSeen'];
    likes0Count = json['likes0Count'];
    likes1Count = json['likes1Count'];
    likes2Count = json['likes2Count'];
    commentsCount = json['commentsCount'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    isSafe = json['isSafe'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['closeUp'] = this.closeUp;
    data['medium'] = this.medium;
    data['long'] = this.long;
    data['pose1'] = this.pose1;
    data['pose2'] = this.pose2;
    data['isWelcomeVideo'] = this.isWelcomeVideo.toString();
    data['additional'] = this.additional;
    data['video'] = this.video;
    // if (this.challengeId = null) {
    //   data['challengeId'] = this.challengeId.map((v) => v.toJson()).toList();
    // }
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['userId'] = this.userId;
    data['maleSeen'] = this.maleSeen;
    data['femaleSeen'] = this.femaleSeen;
    data['likes0Count'] = this.likes0Count;
    data['likes1Count'] = this.likes1Count;
    data['likes2Count'] = this.likes2Count;
    data['commentsCount'] = this.commentsCount;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    data['isSafe'] = this.isSafe;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class FameUser {
  String? sId;
  String? district;
  String? state;
  String? country;
  String? continent;
  String? profileImage;
  int? fameCoins;
  String? dob;
  String? username;

  FameUser(
      {this.sId,
        this.district,
        this.state,
        this.country,
        this.continent,
        this.profileImage,
        this.dob,
        this.fameCoins,
        this.username});

  FameUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    profileImage = json['profileImage'];
    fameCoins = json['fameCoins'];
    dob = json['dob'].toString();
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['profileImage'] = this.profileImage;
    data['dob'] = this.dob.toString();
    data['fameCoins'] = this.fameCoins;
    data['username'] = this.username;
    return data;
  }
}

class TrendsWon {
  String? sId;
  String? category;
  int? totalImpressions;
  int? totalPost;
  int? totalParticipants;
  String? hashTag;
  String? challengeCompleteAt;
  int? totalHearts;
  String? position;
  List<Reward>? reward;
  List<Media>? media;

  TrendsWon(
      {this.sId,
        this.category,
        this.totalImpressions,
        this.totalPost,
        this.totalParticipants,
        this.hashTag,
        this.challengeCompleteAt,
        this.totalHearts,
        this.position,
        this.reward,this.media});

  TrendsWon.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    totalImpressions = json['totalImpressions'];
    totalPost = json['totalPost'];
    totalParticipants = json['totalParticipants'];
    hashTag = json['hashTag'];
    challengeCompleteAt = json['challengeCompleteAt'];
    totalHearts = json['totalHearts'];
    position = json['position'];
    if (json['reward'] != null) {
      reward = <Reward>[];
      json['reward'].forEach((v) {
        reward?.add(new Reward.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media?.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['totalImpressions'] = this.totalImpressions;
    data['totalPost'] = this.totalPost;
    data['totalParticipants'] = this.totalParticipants;
    data['hashTag'] = this.hashTag;
    data['challengeCompleteAt'] = this.challengeCompleteAt;
    data['totalHearts'] = this.totalHearts;
    data['position'] = this.position;
    if (this.reward != null) {
      data['reward'] = this.reward?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reward {
  String? giftName;
  String? giftValue;
  String? giftImage;

  Reward({this.giftName, this.giftValue, this.giftImage});

  Reward.fromJson(Map<String, dynamic> json) {
    giftName = json['giftName'];
    giftValue = json['giftValue'];
    giftImage = json['giftImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['giftName'] = this.giftName;
    data['giftValue'] = this.giftValue;
    data['giftImage'] = this.giftImage;
    return data;
  }
}

class Media {
  String? closeUp;
  String? medium;
  String? long;
  String? pose1;
  String? pose2;
  Null? additional;
  String? video;

  Media(
      {this.closeUp,
        this.medium,
        this.long,
        this.pose1,
        this.pose2,
        this.additional,
        this.video});

  Media.fromJson(Map<String, dynamic> json) {
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

class TitlesWon {
  String? level;
  String? season;
  String? title;
  int? year;
  String? position;

  TitlesWon({this.level, this.season, this.title, this.year, this.position});

  TitlesWon.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    season = json['season'];
    title = json['title'];
    year = json['year'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['season'] = this.season;
    data['title'] = this.title;
    data['year'] = this.year;
    data['position'] = this.position;
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

class PostImages{
  String? image;
  String? type;

  PostImages({this.image, this.type});
}