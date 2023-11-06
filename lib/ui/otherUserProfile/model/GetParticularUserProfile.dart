
class GetParticularProfileResultContestPathWorld {


  String? name;
  bool? isWinner;

  GetParticularProfileResultContestPathWorld({
    this.name,
    this.isWinner,
  });
  GetParticularProfileResultContestPathWorld.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    isWinner = json['isWinner'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['isWinner'] = isWinner;
    return data;
  }
}

class GetParticularProfileResultContestPathContinent {
/*
{
  "name": "Asia",
  "isWinner": false
}
*/

  String? name;
  bool? isWinner;

  GetParticularProfileResultContestPathContinent({
    this.name,
    this.isWinner,
  });
  GetParticularProfileResultContestPathContinent.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    isWinner = json['isWinner'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['isWinner'] = isWinner;
    return data;
  }
}

class GetParticularProfileResultContestPathCountry {

  String? name;
  bool? isWinner;

  GetParticularProfileResultContestPathCountry({
    this.name,
    this.isWinner,
  });
  GetParticularProfileResultContestPathCountry.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    isWinner = json['isWinner'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['isWinner'] = isWinner;
    return data;
  }
}

class GetParticularProfileResultContestPathState {
/*
{
  "name": "Delhi",
  "isWinner": false
}
*/

  String? name;
  bool? isWinner;

  GetParticularProfileResultContestPathState({
    this.name,
    this.isWinner,
  });
  GetParticularProfileResultContestPathState.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    isWinner = json['isWinner'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['isWinner'] = isWinner;
    return data;
  }
}

class GetParticularProfileResultContestPathDistrict {
/*
{
  "name": "New delhi",
  "isWinner": true
}
*/

  String? name;
  bool? isWinner;

  GetParticularProfileResultContestPathDistrict({
    this.name,
    this.isWinner,
  });
  GetParticularProfileResultContestPathDistrict.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    isWinner = json['isWinner'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['isWinner'] = isWinner;
    return data;
  }
}

class GetParticularProfileResultContestPath {
/*
{
  "district": {
    "name": "New delhi",
    "isWinner": true
  },
  "state": {
    "name": "Delhi",
    "isWinner": false
  },
  "country": {
    "name": "India",
    "isWinner": false
  },
  "continent": {
    "name": "Asia",
    "isWinner": false
  },
  "world": {
    "name": "World",
    "isWinner": false
  }
}
*/

  GetParticularProfileResultContestPathDistrict? district;
  GetParticularProfileResultContestPathState? state;
  GetParticularProfileResultContestPathCountry? country;
  GetParticularProfileResultContestPathContinent? continent;
  GetParticularProfileResultContestPathWorld? world;

  GetParticularProfileResultContestPath({
    this.district,
    this.state,
    this.country,
    this.continent,
    this.world,
  });
  GetParticularProfileResultContestPath.fromJson(Map<String, dynamic> json) {
    district = (json['district'] != null) ? GetParticularProfileResultContestPathDistrict.fromJson(json['district']) : null;
    state = (json['state'] != null) ? GetParticularProfileResultContestPathState.fromJson(json['state']) : null;
    country = (json['country'] != null) ? GetParticularProfileResultContestPathCountry.fromJson(json['country']) : null;
    continent = (json['continent'] != null) ? GetParticularProfileResultContestPathContinent.fromJson(json['continent']) : null;
    world = (json['world'] != null) ? GetParticularProfileResultContestPathWorld.fromJson(json['world']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (continent != null) {
      data['continent'] = continent!.toJson();
    }
    if (world != null) {
      data['world'] = world!.toJson();
    }
    return data;
  }
}

class GetParticularProfileResultSettingsNotification {
/*
{
  "comments": true,
  "likes": true,
  "trendingPosts": true,
  "requestAccepted": true,
  "followRequest": true,
  "newFollower": true,
  "sponser": true,
  "liveEvents": true,
  "upcomingChallenges": true,
  "endingChallenges": true
}
*/

  bool? comments;
  bool? likes;
  bool? trendingPosts;
  bool? requestAccepted;
  bool? followRequest;
  bool? newFollower;
  bool? sponser;
  bool? liveEvents;
  bool? upcomingChallenges;
  bool? endingChallenges;

  GetParticularProfileResultSettingsNotification({
    this.comments,
    this.likes,
    this.trendingPosts,
    this.requestAccepted,
    this.followRequest,
    this.newFollower,
    this.sponser,
    this.liveEvents,
    this.upcomingChallenges,
    this.endingChallenges,
  });
  GetParticularProfileResultSettingsNotification.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    likes = json['likes'];
    trendingPosts = json['trendingPosts'];
    requestAccepted = json['requestAccepted'];
    followRequest = json['followRequest'];
    newFollower = json['newFollower'];
    sponser = json['sponser'];
    liveEvents = json['liveEvents'];
    upcomingChallenges = json['upcomingChallenges'];
    endingChallenges = json['endingChallenges'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['comments'] = comments;
    data['likes'] = likes;
    data['trendingPosts'] = trendingPosts;
    data['requestAccepted'] = requestAccepted;
    data['followRequest'] = followRequest;
    data['newFollower'] = newFollower;
    data['sponser'] = sponser;
    data['liveEvents'] = liveEvents;
    data['upcomingChallenges'] = upcomingChallenges;
    data['endingChallenges'] = endingChallenges;
    return data;
  }
}

class GetParticularProfileResultSettings {
/*
{
  "notification": {
    "comments": true,
    "likes": true,
    "trendingPosts": true,
    "requestAccepted": true,
    "followRequest": true,
    "newFollower": true,
    "sponser": true,
    "liveEvents": true,
    "upcomingChallenges": true,
    "endingChallenges": true
  }
}
*/

  GetParticularProfileResultSettingsNotification? notification;

  GetParticularProfileResultSettings({
    this.notification,
  });
  GetParticularProfileResultSettings.fromJson(Map<String, dynamic> json) {
    notification = (json['notification'] != null) ? GetParticularProfileResultSettingsNotification.fromJson(json['notification']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    return data;
  }
}

class GetParticularProfileResult {
/*
{
  "_id": "64d0d6498422a7659898b6f2",
  "name": "abhishekbrand",
  "gender": "female",
  "type": "brand",
  "bio": null,
  "district": "new delhi",
  "state": "delhi",
  "country": "india",
  "dob": "2023-07-11T00:00:00.000Z",
  "isRegistered": true,
  "isBlocked": false,
  "isDeleted": false,
  "verificationDoc": [
    null
  ],
  "ageGroup": "groupD",
  "profileImage": "avatar.png",
  "profileImageType": "",
  "settings": {
    "notification": {
      "comments": true,
      "likes": true,
      "trendingPosts": true,
      "requestAccepted": true,
      "followRequest": true,
      "newFollower": true,
      "sponser": true,
      "liveEvents": true,
      "upcomingChallenges": true,
      "endingChallenges": true
    }
  },
  "isVerified": false,
  "followersCount": 0,
  "followingCount": 10,
  "pushToken": null,
  "blockList": [
    null
  ],
  "fameCoins": 0,
  "verificationStatus": "Pending",
  "isSuspended": false,
  "deleteDate": null,
  "isFirstLogin": false,
  "profileFunlinks": "64d0d6728422a7659898b7f0",
  "profileFollowlinks": "64d0d6728422a7659898b7f2",
  "profileJoblinks": "64d0d6728422a7659898b7f4",
  "profileStorelinks": "64d0ddb4b9ce95cf6a302f30",
  "username": "abhishekbrand",
  "winnerTitles": [
    null
  ],
  "runnerUp": [
    null
  ],
  "level": "india",
  "score": 0,
  "thanksGifted": 23000,
  "thanksBalance": 3000,
  "todaysPosts": 0,
  "famelinksContestpost": 0,
  "ambassadorTrendzPost": 0,
  "perdayPost": 5,
  "chatId": "64d0d6728422a7659898b7fe",
  "contestPath": {
    "district": {
      "name": "New delhi",
      "isWinner": true
    },
    "state": {
      "name": "Delhi",
      "isWinner": false
    },
    "country": {
      "name": "India",
      "isWinner": false
    },
    "continent": {
      "name": "Asia",
      "isWinner": false
    },
    "world": {
      "name": "World",
      "isWinner": false
    }
  }
}
*/

  String? Id;
  String? name;
  String? gender;
  String? type;
  String? bio;
  String? district;
  String? state;
  String? country;
  String? dob;
  bool? isRegistered;
  bool? isBlocked;
  bool? isDeleted;
  String? ageGroup;
  String? profileImage;
  String? profileImageType;
  GetParticularProfileResultSettings? settings;
  bool? isVerified;
  int? followersCount;
  int? followingCount;
  String? pushToken;
  int? fameCoins;
  String? verificationStatus;
  bool? isSuspended;
  String? deleteDate;
  bool? isFirstLogin;
  String? profileFunlinks;
  String? profileFollowlinks;
  String? profileJoblinks;
  String? profileStorelinks;
  String? username;
  String? level;
  int? score;
  int? thanksGifted;
  int? thanksBalance;
  int? todaysPosts;
  int? famelinksContestpost;
  int? ambassadorTrendzPost;
  int? perdayPost;
  String? chatId;
  GetParticularProfileResultContestPath? contestPath;

  GetParticularProfileResult({
    this.Id,
    this.name,
    this.gender,
    this.type,
    this.bio,
    this.district,
    this.state,
    this.country,
    this.dob,
    this.isRegistered,
    this.isBlocked,
    this.isDeleted,
    this.ageGroup,
    this.profileImage,
    this.profileImageType,
    this.settings,
    this.isVerified,
    this.followersCount,
    this.followingCount,
    this.pushToken,
    this.fameCoins,
    this.verificationStatus,
    this.isSuspended,
    this.deleteDate,
    this.isFirstLogin,
    this.profileFunlinks,
    this.profileFollowlinks,
    this.profileJoblinks,
    this.profileStorelinks,
    this.username,
    this.level,
    this.score,
    this.thanksGifted,
    this.thanksBalance,
    this.todaysPosts,
    this.famelinksContestpost,
    this.ambassadorTrendzPost,
    this.perdayPost,
    this.chatId,
    this.contestPath,
  });
  GetParticularProfileResult.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    name = json['name']?.toString();
    gender = json['gender']?.toString();
    type = json['type']?.toString();
    bio = json['bio']?.toString();
    district = json['district']?.toString();
    state = json['state']?.toString();
    country = json['country']?.toString();
    dob = json['dob']?.toString();
    isRegistered = json['isRegistered'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    ageGroup = json['ageGroup']?.toString();
    profileImage = json['profileImage']?.toString();
    profileImageType = json['profileImageType']?.toString();
    settings = (json['settings'] != null) ? GetParticularProfileResultSettings.fromJson(json['settings']) : null;
    isVerified = json['isVerified'];
    followersCount = json['followersCount']?.toInt();
    followingCount = json['followingCount']?.toInt();
    pushToken = json['pushToken']?.toString();
    fameCoins = json['fameCoins']?.toInt();
    verificationStatus = json['verificationStatus']?.toString();
    isSuspended = json['isSuspended'];
    deleteDate = json['deleteDate']?.toString();
    isFirstLogin = json['isFirstLogin'];
    profileFunlinks = json['profileFunlinks']?.toString();
    profileFollowlinks = json['profileFollowlinks']?.toString();
    profileJoblinks = json['profileJoblinks']?.toString();
    profileStorelinks = json['profileStorelinks']?.toString();
    username = json['username']?.toString();
    level = json['level']?.toString();
    score = json['score']?.toInt();
    thanksGifted = json['thanksGifted']?.toInt();
    thanksBalance = json['thanksBalance']?.toInt();
    todaysPosts = json['todaysPosts']?.toInt();
    famelinksContestpost = json['famelinksContestpost']?.toInt();
    ambassadorTrendzPost = json['ambassadorTrendzPost']?.toInt();
    perdayPost = json['perdayPost']?.toInt();
    chatId = json['chatId']?.toString();
    contestPath = (json['contestPath'] != null) ? GetParticularProfileResultContestPath.fromJson(json['contestPath']) : null;
    }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['name'] = name;
    data['gender'] = gender;
    data['type'] = type;
    data['bio'] = bio;
    data['district'] = district;
    data['state'] = state;
    data['country'] = country;
    data['dob'] = dob;
    data['isRegistered'] = isRegistered;
    data['isBlocked'] = isBlocked;
    data['isDeleted'] = isDeleted;
    data['ageGroup'] = ageGroup;
    data['profileImage'] = profileImage;
    data['profileImageType'] = profileImageType;
    if (settings != null) {
    data['settings'] = settings!.toJson();
    }
    data['isVerified'] = isVerified;
    data['followersCount'] = followersCount;
    data['followingCount'] = followingCount;
    data['pushToken'] = pushToken;
    data['fameCoins'] = fameCoins;
    data['verificationStatus'] = verificationStatus;
    data['isSuspended'] = isSuspended;
    data['deleteDate'] = deleteDate;
    data['isFirstLogin'] = isFirstLogin;
    data['profileFunlinks'] = profileFunlinks;
    data['profileFollowlinks'] = profileFollowlinks;
    data['profileJoblinks'] = profileJoblinks;
    data['profileStorelinks'] = profileStorelinks;
    data['username'] = username;
    data['level'] = level;
    data['score'] = score;
    data['thanksGifted'] = thanksGifted;
    data['thanksBalance'] = thanksBalance;
    data['todaysPosts'] = todaysPosts;
    data['famelinksContestpost'] = famelinksContestpost;
    data['ambassadorTrendzPost'] = ambassadorTrendzPost;
    data['perdayPost'] = perdayPost;
    data['chatId'] = chatId;
    if (contestPath != null) {
    data['contestPath'] = contestPath!.toJson();
    }
    return data;
  }
}

class GetParticularProfile {
/*
{
  "result": {
    "_id": "64d0d6498422a7659898b6f2",
    "name": "abhishekbrand",
    "gender": "female",
    "type": "brand",
    "bio": null,
    "district": "new delhi",
    "state": "delhi",
    "country": "india",
    "dob": "2023-07-11T00:00:00.000Z",
    "isRegistered": true,
    "isBlocked": false,
    "isDeleted": false,
    "verificationDoc": [
      null
    ],
    "ageGroup": "groupD",
    "profileImage": "avatar.png",
    "profileImageType": "",
    "settings": {
      "notification": {
        "comments": true,
        "likes": true,
        "trendingPosts": true,
        "requestAccepted": true,
        "followRequest": true,
        "newFollower": true,
        "sponser": true,
        "liveEvents": true,
        "upcomingChallenges": true,
        "endingChallenges": true
      }
    },
    "isVerified": false,
    "followersCount": 0,
    "followingCount": 10,
    "pushToken": null,
    "blockList": [
      null
    ],
    "fameCoins": 0,
    "verificationStatus": "Pending",
    "isSuspended": false,
    "deleteDate": null,
    "isFirstLogin": false,
    "profileFunlinks": "64d0d6728422a7659898b7f0",
    "profileFollowlinks": "64d0d6728422a7659898b7f2",
    "profileJoblinks": "64d0d6728422a7659898b7f4",
    "profileStorelinks": "64d0ddb4b9ce95cf6a302f30",
    "username": "abhishekbrand",
    "winnerTitles": [
      null
    ],
    "runnerUp": [
      null
    ],
    "level": "india",
    "score": 0,
    "thanksGifted": 23000,
    "thanksBalance": 3000,
    "todaysPosts": 0,
    "famelinksContestpost": 0,
    "ambassadorTrendzPost": 0,
    "perdayPost": 5,
    "chatId": "64d0d6728422a7659898b7fe",
    "contestPath": {
      "district": {
        "name": "New delhi",
        "isWinner": true
      },
      "state": {
        "name": "Delhi",
        "isWinner": false
      },
      "country": {
        "name": "India",
        "isWinner": false
      },
      "continent": {
        "name": "Asia",
        "isWinner": false
      },
      "world": {
        "name": "World",
        "isWinner": false
      }
    }
  },
  "message": "User Fetched",
  "success": true
}
*/

  GetParticularProfileResult? result;
  String? message;
  bool? success;

  GetParticularProfile({
    this.result,
    this.message,
    this.success,
  });
  GetParticularProfile.fromJson(Map<String, dynamic> json) {
    result = (json['result'] != null) ? GetParticularProfileResult.fromJson(json['result']) : null;
    message = json['message']?.toString();
    success = json['success'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}
