
class ProfileJobLinksModel {
  List<ProfileJobLinksModelResult>? result;
  String? message;
  bool? success;

  ProfileJobLinksModel({this.result, this.message, this.success});

  ProfileJobLinksModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProfileJobLinksModelResult>[];
      json['result'].forEach((v) {
        result?.add(new ProfileJobLinksModelResult.fromJson(v));
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

class ProfileJobLinksModelResult {
  String? sId;
  String? name;
  String? bio;
  String? profession;
  String? profileImage;
  String? profileImageType;
  List<Null>? restrictedList;
  bool? isRegistered;
  bool? isBlocked;

  bool? isDeleted;
  List<ClubDetails>? clubDetails;
  List<ProfileFollowLinksModelResultPosts>? posts;
  int? followers;
  int? following;
  List<Requests>? requests;
  String? club;

  ProfileJobLinksModelResult(
      {this.sId,
        this.name,
        this.bio,
        this.profession,
        this.profileImage,
        this.restrictedList,
        this.isRegistered,
        this.isBlocked,
        this.isDeleted,
        this.posts,
        this.profileImageType,
        this.followers,
        this.following,
        this.requests,this.clubDetails,
        this.club});

  ProfileJobLinksModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    profession = json['profession'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    if (json['restrictedList'] != null) {
      restrictedList = <Null>[];
      json['restrictedList'].forEach((v) {
        // restrictedList!.add(new Null.fromJson(v));
      });
    }
    isRegistered = json['isRegistered'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    if (json['posts'] != null) {
      posts = <ProfileFollowLinksModelResultPosts>[];
      json['posts'].forEach((v) {
        posts?.add(new ProfileFollowLinksModelResultPosts.fromJson(v));
      });
    }
    followers = json['Followers'];
    following = json['Following'];
    if (json['Requests'] != null) {
      requests = <Requests>[];
      json['Requests'].forEach((v) {
        requests?.add(new Requests.fromJson(v));
      });
    }
    club = json['Club'];
    if (json['clubDetails'] != null) {
      clubDetails = <ClubDetails>[];
      json['clubDetails'].forEach((v) {
        clubDetails?.add(new ClubDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['profileImageType'] = this.profileImageType;
    data['profileImage'] = this.profileImage;
    // if (this.restrictedList != null) {
    //   data['restrictedList'] = this.restrictedList.map((v) => v.toJson()).toList();
    // }
    data['isRegistered'] = this.isRegistered;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    if (this.posts != null) {
      data['posts'] = this.posts?.map((v) => v.toJson()).toList();
    }
    data['Followers'] = this.followers;
    data['Following'] = this.following;
    if (this.requests != null) {
      data['Requests'] = this.requests?.map((v) => v.toJson()).toList();
    }
    data['Club'] = this.club;
    return data;
  }
}

class ProfileFollowLinksModelResultPosts {
  String? sId;
  List<Media>? media;
  int? isWelcomeVideo;

  ProfileFollowLinksModelResultPosts({this.sId, this.media, this.isWelcomeVideo});

  ProfileFollowLinksModelResultPosts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media?.add(new Media.fromJson(v));
      });
    }
    isWelcomeVideo = json['isWelcomeVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.media != null) {
      data['media'] = this.media?.map((v) => v.toJson()).toList();
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
  String? profileImage;
  int? fameCoins;
  String? dob;
  String? username;

  MasterUser(
      {this.id,
        this.district,
        this.state,
        this.country,
        this.continent,
        this.profileImage,
        this.dob,
        this.fameCoins,
        this.username});

  MasterUser.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    profileImage = json['profileImage'];
    fameCoins = json['fameCoins'];
    dob = json['dob'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.id;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['profileImage'] = this.profileImage;
    data['dob'] = this.dob;
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