class OtherUserProfileFollowLinksModel {
  List<OtherUserProfileFollowLinksModelResult>? result;
  String? message;
  bool? success;

  OtherUserProfileFollowLinksModel({this.result, this.message, this.success});

  OtherUserProfileFollowLinksModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <OtherUserProfileFollowLinksModelResult>[];
      json['result'].forEach((v) {
        result!.add(new OtherUserProfileFollowLinksModelResult.fromJson(v));
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

class OtherUserProfileFollowLinksModelResult {
  String? sId;
  String? name;
  String? bio;
  String? profession;
  String? profileImage;
  List<Null>? restrictedList;
  bool? isRegistered;
  bool? isBlocked;
  bool? isDeleted;
  String? profileImageType;
  List<Null>? clubCategory;
  List<Posts>? posts;
  MasterUser? masterUser;
  int? followers;
  int? following;
  String? club;
  int? offersCompleted;
  List<Requests>? requests;
  String? followStatus;
  List<Clubs>? clubs;
  int? newOffers;
  List<ClubDetails>? clubDetails;
  String? chatId;

  OtherUserProfileFollowLinksModelResult(
      {this.sId,
      this.name,
      this.bio,
      this.profession,
      this.profileImage,
      this.restrictedList,
      this.isRegistered,
      this.isBlocked,
      this.isDeleted,
      this.profileImageType,
      this.clubCategory,
      this.posts,
      this.masterUser,
      this.followers,
      this.following,
      this.club,
      this.offersCompleted,
      this.requests,
      this.followStatus,
      this.clubs,
      this.newOffers,
      this.clubDetails,
      this.chatId});

  OtherUserProfileFollowLinksModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    profession = json['profession'];
    profileImage = json['profileImage'];
    // if (json['restrictedList'] != null) {
    //   restrictedList = new List<Null>();
    //   json['restrictedList'].forEach((v) {
    //     restrictedList.add(new Null.fromJson(v));
    //   });
    // }
    isRegistered = json['isRegistered'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    profileImageType = json['profileImageType'];
    // if (json['clubCategory'] != null) {
    //   clubCategory = new List<Null>();
    //   json['clubCategory'].forEach((v) {
    //     clubCategory.add(new Null.fromJson(v));
    //   });
    // }
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    masterUser = json['masterUser'] != null
        ? new MasterUser.fromJson(json['masterUser'])
        : null;
    followers = json['Followers'];
    following = json['Following'];
    club = json['Club'];
    offersCompleted = json['offersCompleted'];
    if (json['Requests'] != null) {
      requests = <Requests>[];
      json['Requests'].forEach((v) {
        requests!.add(new Requests.fromJson(v));
      });
    }
    followStatus = json['followStatus'];
    if (json['clubs'] != null) {
      clubs = <Clubs>[];
      json['clubs'].forEach((v) {
        clubs!.add(new Clubs.fromJson(v));
      });
    }
    newOffers = json['newOffers'];
    if (json['clubDetails'] != null) {
      clubDetails = <ClubDetails>[];
      json['clubDetails'].forEach((v) {
        clubDetails!.add(new ClubDetails.fromJson(v));
      });
    }
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['profileImage'] = this.profileImage;
    // if (this.restrictedList != null) {
    //   data['restrictedList'] =
    //       this.restrictedList.map((v) => v.toJson()).toList();
    // }
    data['isRegistered'] = this.isRegistered;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    data['profileImageType'] = this.profileImageType;
    // if (this.clubCategory != null) {
    //   data['clubCategory'] = this.clubCategory.map((v) => v.toJson()).toList();
    // }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.masterUser != null) {
      data['masterUser'] = this.masterUser!.toJson();
    }
    data['Followers'] = this.followers;
    data['Following'] = this.following;
    data['Club'] = this.club;
    data['offersCompleted'] = this.offersCompleted;
    if (this.requests != null) {
      data['Requests'] = this.requests!.map((v) => v.toJson()).toList();
    }
    data['followStatus'] = this.followStatus;
    if (this.clubs != null) {
      data['clubs'] = this.clubs!.map((v) => v.toJson()).toList();
    }
    data['newOffers'] = this.newOffers;
    if (this.clubDetails != null) {
      data['clubDetails'] = this.clubDetails!.map((v) => v.toJson()).toList();
    }
    data['chatId'] = this.chatId;
    return data;
  }
}

class Posts {
  String? sId;
  List<Media>? media;
  int? isWelcomeVideo;

  Posts({this.sId, this.media, this.isWelcomeVideo});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    isWelcomeVideo = json['isWelcomeVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    data['isWelcomeVideo'] = this.isWelcomeVideo;
    return data;
  }
}

class Media {
  String? type;
  String? media;

  Media({this.type, this.media});

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['media'] = this.media;
    return data;
  }
}

class MasterUser {
  String? id;
  String? district;
  String? state;
  String? country;
  String? continent;
  String? dob;
  String? profileImage;
  String? profileImageType;
  int? fameCoins;
  String? username;

  MasterUser(
      {this.id,
      this.district,
      this.state,
      this.country,
      this.continent,
      this.dob,
      this.profileImage,
      this.profileImageType,
      this.fameCoins,
      this.username});

  MasterUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
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
    data['_id'] = this.id;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['dob'] = this.dob;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    data['fameCoins'] = this.fameCoins;
    data['username'] = this.username;
    return data;
  }
}

class Requests {
  String? sId;
  String? name;
  String? username;
  String? district;
  String? state;
  String? country;
  String? createdAt;
  String? profileImage;

  Requests(
      {this.sId,
      this.name,
      this.username,
      this.district,
      this.state,
      this.country,
      this.createdAt,
      this.profileImage});

  Requests.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    username = json['username'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    createdAt = json['createdAt'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Clubs {
  String? name;
  int? minRange;
  int? maxRange;
  int? minCost;
  int? maxCost;
  String? type;

  Clubs(
      {this.name,
      this.minRange,
      this.maxRange,
      this.minCost,
      this.maxCost,
      this.type});

  Clubs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    minRange = json['minRange'];
    maxRange = json['maxRange'];
    minCost = json['minCost'];
    maxCost = json['maxCost'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['minRange'] = this.minRange;
    data['maxRange'] = this.maxRange;
    data['minCost'] = this.minCost;
    data['maxCost'] = this.maxCost;
    data['type'] = this.type;
    return data;
  }
}

class ClubDetails {
  String? clubName;
  String? clubOffer;
  String? clubRange;

  ClubDetails({this.clubName, this.clubOffer, this.clubRange});

  ClubDetails.fromJson(Map<String, dynamic> json) {
    clubName = json['clubName'];
    clubOffer = json['clubOffer'];
    clubRange = json['clubRange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clubName'] = this.clubName;
    data['clubOffer'] = this.clubOffer;
    data['clubRange'] = this.clubRange;
    return data;
  }
}
