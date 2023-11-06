

class OtherFameLinksModel {
  List<OtherFameLinksModelResult>? result;
  String? message;
  bool? success;

  OtherFameLinksModel({this.result, this.message, this.success});

  OtherFameLinksModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <OtherFameLinksModelResult>[];
      json['result'].forEach((v) {
        result!.add(new OtherFameLinksModelResult.fromJson(v));
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

class OtherFameLinksModelResult {
  String? sId;
  String? name;
  String? bio;
  String? profession;
  String? profileImage;
  String? profileImageType;
  int? likes0Count;
  int? likes1Count;
  int? likes2Count;
  List<Null>? restrictedList;
  bool? isRegistered;
  bool? isBlocked;
  bool? isDeleted;
  Null avatarImage;
  List<Posts>? posts;
  MasterUser? masterUser;
  List<TrendsWon>? trendsWon;
  List<TitlesWon>? titlesWon;
  List<Ambassador>? ambassador;
  String? followStatus;
  int? hearts;
  int? score;
  int? trendzSet;
  String? contesting;
  String? chatId;

  OtherFameLinksModelResult(
      {this.sId,
        this.name,
        this.bio,
        this.profession,
        this.profileImage,
        this.likes0Count,
        this.likes1Count,
        this.likes2Count,
        this.restrictedList,
        this.isRegistered,
        this.isBlocked,
        this.isDeleted,
        this.avatarImage,
        this.posts,
        this.masterUser,
        this.trendsWon,
        this.titlesWon,
        this.ambassador,
        this.followStatus,this.profileImageType,
        this.hearts,
        this.score,
        this.trendzSet,this.chatId,
        this.contesting});

  OtherFameLinksModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    profession = json['profession'];
    profileImage = json['profileImage'].toString();
    profileImageType = json['profileImageType'].toString();
    likes0Count = json['likes0Count'];
    likes1Count = json['likes1Count'];
    likes2Count = json['likes2Count'];
    if (json['restrictedList'] != null) {
      restrictedList = <Null>[];
      json['restrictedList'].forEach((v) {
       //restrictedList!.add(new Null.fromJson(v));
      });
    }
    isRegistered = json['isRegistered'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    avatarImage = json['avatarImage'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    masterUser = json['masterUser'] != null
         ?new MasterUser.fromJson(json['masterUser'])
        : null;
    if (json['trendsWon'] != null) {
      trendsWon = <TrendsWon>[];
      json['trendsWon'].forEach((v) {
        trendsWon!.add(new TrendsWon.fromJson(v));
      });
    }
    if (json['titlesWon'] != null) {
      titlesWon = <TitlesWon>[];
      json['titlesWon'].forEach((v) {
        titlesWon!.add(new TitlesWon.fromJson(v));
      });
    }
    if (json['ambassador'] != null) {
      ambassador = <Ambassador>[];
      json['ambassador'].forEach((v) {
        ambassador!.add(new Ambassador.fromJson(v));
      });
    }
    followStatus = json['followStatus'];
    hearts = json['hearts'];
    score = json['score'];
    trendzSet = json['trendzSet'];
    contesting = json['Contesting'];
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['profileImage'] = this.profileImage;
    data['likes0Count'] = this.likes0Count;
    data['likes1Count'] = this.likes1Count;
    data['likes2Count'] = this.likes2Count;
    if (this.restrictedList != null) {
      //data['restrictedList'] = this.restrictedList!.map((v) => v.toJson()).toList();
    }
    data['isRegistered'] = this.isRegistered;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    data['avatarImage'] = this.avatarImage;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.masterUser != null) {
      data['masterUser'] = this.masterUser!.toJson();
    }
    if (this.trendsWon != null) {
      data['trendsWon'] = this.trendsWon!.map((v) => v.toJson()).toList();
    }
    if (this.titlesWon != null) {
      data['titlesWon'] = this.titlesWon!.map((v) => v.toJson()).toList();
    }
    if (this.ambassador != null) {
      //data['ambassador'] = this.ambassador.map((v) => v.toJson()).toList();
    }
    data['followStatus'] = this.followStatus;
    data['hearts'] = this.hearts;
    data['score'] = this.score;
    data['trendzSet'] = this.trendzSet;
    data['Contesting'] = this.contesting;
    return data;
  }
}

class Posts {
  String? sId;
  String? closeUp;
  String? medium;
  String? long;
  String? pose1;
  String? pose2;
  String? additional;
  String? video;
  int? isWelcomeVideo;

  Posts(
      {this.sId,
        this.closeUp,
        this.medium,
        this.long,
        this.pose1,
        this.pose2,
        this.additional,
        this.video,
        this.isWelcomeVideo});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    closeUp = json['closeUp'];
    medium = json['medium'];
    long = json['long'];
    pose1 = json['pose1'];
    pose2 = json['pose2'];
    additional = json['additional'];
    video = json['video'];
    isWelcomeVideo = json['isWelcomeVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['closeUp'] = this.closeUp;
    data['medium'] = this.medium;
    data['long'] = this.long;
    data['pose1'] = this.pose1;
    data['pose2'] = this.pose2;
    data['additional'] = this.additional;
    data['video'] = this.video;
    data['isWelcomeVideo'] = this.isWelcomeVideo;
    return data;
  }
}

class MasterUser {
  String? sId;
  String? district;
  String? state;
  String? country;
  String? continent;
  String? dob;
  String? profileImage;
  int? fameCoins;
  String? username;
  String? avatarImage;

  MasterUser(
      {this.sId,
        this.district,
        this.state,
        this.country,
        this.continent,
        this.dob,
        this.profileImage,
        this.fameCoins,
        this.username,
        this.avatarImage});

  MasterUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    dob = json['dob'];
    profileImage = json['profileImage'];
    fameCoins = json['fameCoins'];
    username = json['username'];
    avatarImage = json['avatarImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['dob'] = this.dob;
    data['profileImage'] = this.profileImage;
    data['fameCoins'] = this.fameCoins;
    data['username'] = this.username;
    data['avatarImage'] = this.avatarImage;
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
        reward!.add(new Reward.fromJson(v));
      });
    }
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
    data['category'] = this.category;
    data['totalImpressions'] = this.totalImpressions;
    data['totalPost'] = this.totalPost;
    data['totalParticipants'] = this.totalParticipants;
    data['hashTag'] = this.hashTag;
    data['challengeCompleteAt'] = this.challengeCompleteAt;
    data['totalHearts'] = this.totalHearts;
    data['position'] = this.position;
    if (this.reward != null) {
      data['reward'] = this.reward!.map((v) => v.toJson()).toList();
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
  String? level;

  String? title;


  Ambassador({this.level,  this.title});

  Ambassador.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['title'] = this.title;
    return data;
  }
}
