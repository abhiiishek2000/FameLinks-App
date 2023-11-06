import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    this.result,
    this.message,
    this.success,
  });

  Result? result;
  String? message;
  String? success;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        result:
        json['result'] != null ? new Result.fromJson(json['result']) : null,
        //result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        message: json["message"],
        success: json["success"].toString(),
      );

  Map<String, dynamic> toJson() => {
    //"result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
    "success": success.toString(),
  };
}

class Result {
  String? sId;
  String? name;
  int? mobileNumber;
  String? gender;
  String? type;
  String? bio;
  String? district;
  String? state;
  String? country;
  String? dob;
  bool? isRegistered;
  bool? isBlocked;
  List<Null>? verificationDoc;
  String? ageGroup;
  String? profileImage;
  Settings? settings;
  bool? isVerified;
  int? followersCount;
  int? followingCount;
  String? pushToken;
  Null? referredBy;
  List<Null>? blockList;
  int? fameCoins;
  String? verificationStatus;
  String? referralCode;
  bool? isFirstLogin;
  String? profileFamelinks;
  String? profileFunlinks;
  String? profileFollowlinks;
  String? profileJobLinksFaces;
  String? profileJobLinksCrew;
  String? profileImageType;
  String? username;
  List<Null>? winnerTitles;
  List<Null>?runnerUp;
  String? level;
  int? score;
  int? thanksGifted;
  int? thanksBalance;
  int? todaysPosts;
  int? perdayPost;
  int? countryCode;
  String? referralLink;
  Null? challengesWon;
  Null? challengesSponsered;
  ContestPath? contestPath;

  Result(
      {this.sId,
        this.name,
        this.mobileNumber,
        this.gender,
        this.type,
        this.bio,
        this.district,
        this.state,
        this.country,
        this.dob,
        this.isRegistered,
        this.isBlocked,
        this.verificationDoc,
        this.ageGroup,
        this.profileImage,
        this.settings,
        this.isVerified,
        this.followersCount,
        this.followingCount,
        this.pushToken,
        this.referredBy,
        this.blockList,
        this.fameCoins,
        this.verificationStatus,
        this.referralCode,
        this.isFirstLogin,
        this.profileFamelinks,
        this.profileFunlinks,
        this.profileFollowlinks,
        this.profileJobLinksFaces,
        this.profileJobLinksCrew,
        this.profileImageType,
        this.username,
        this.winnerTitles,
        this.runnerUp,
        this.level,
        this.score,
        this.thanksGifted,
        this.thanksBalance,
        this.todaysPosts,
        this.perdayPost,
        this.countryCode,
        this.referralLink,
        this.challengesWon,
        this.challengesSponsered,
        this.contestPath});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    gender = json['gender'];
    type = json['type'];
    bio = json['bio'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    dob = json['dob'];
    isRegistered = json['isRegistered'];
    isBlocked = json['isBlocked'];
    if (json['verificationDoc'] != null) {
      verificationDoc = <Null>[];
      json['verificationDoc'].forEach((v) {
        //verificationDoc.add(new Null.fromJson(v));
      });
    }
    ageGroup = json['ageGroup'];
    profileImage = json['profileImage'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    isVerified = json['isVerified'];
    followersCount = json['followersCount'];
    followingCount = json['followingCount'];
    pushToken = json['pushToken'];
    referredBy = json['referredBy'];
    if (json['blockList'] != null) {
      blockList = <Null>[];
      json['blockList'].forEach((v) {
        //blockList!.add(new Null.fromJson(v));
      });
    }
    fameCoins = json['fameCoins'];
    verificationStatus = json['verificationStatus'];
    referralCode = json['referralCode'];
    isFirstLogin = json['isFirstLogin'];
    profileFamelinks = json['profileFamelinks'];
    profileFunlinks = json['profileFunlinks'];
    profileFollowlinks = json['profileFollowlinks'];
    profileJobLinksFaces = json['profileJobLinksFaces'];
    profileJobLinksCrew = json['profileJobLinksCrew'];
    profileImageType = json['profileImageType'];
    username = json['username'];
    if (json['winnerTitles'] != null) {
      winnerTitles = <Null>[];
      json['winnerTitles'].forEach((v) {
        //winnerTitles!.add(new Null.fromJson(v));
      });
    }
    if (json['runnerUp'] != null) {
      runnerUp = <Null>[];
      json['runnerUp'].forEach((v) {
        //runnerUp!.add(new Null.fromJson(v));
      });
    }
    level = json['level'];
    score = json['score'];
    thanksGifted = json['thanksGifted'];
    thanksBalance = json['thanksBalance'];
    todaysPosts = json['todaysPosts'];
    perdayPost = json['perdayPost'];
    countryCode = json['countryCode'];
    referralLink = json['referralLink'];
    challengesWon = json['challengesWon'];
    challengesSponsered = json['challengesSponsered'];
    contestPath = json['contestPath'] != null
        ? new ContestPath.fromJson(json['contestPath'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['bio'] = this.bio;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['dob'] = this.dob;
    data['isRegistered'] = this.isRegistered;
    data['isBlocked'] = this.isBlocked;
    if (this.verificationDoc != null) {
      //data['verificationDoc'] = this.verificationDoc!.map((v) => v.toJson()).toList();
    }
    data['ageGroup'] = this.ageGroup;
    data['profileImage'] = this.profileImage;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    data['isVerified'] = this.isVerified;
    data['followersCount'] = this.followersCount;
    data['followingCount'] = this.followingCount;
    data['pushToken'] = this.pushToken;
    data['referredBy'] = this.referredBy;
    if (this.blockList != null) {
      //data['blockList'] = this.blockList!.map((v) => v.toJson()).toList();
    }
    data['fameCoins'] = this.fameCoins;
    data['verificationStatus'] = this.verificationStatus;
    data['referralCode'] = this.referralCode;
    data['isFirstLogin'] = this.isFirstLogin;
    data['profileFamelinks'] = this.profileFamelinks;
    data['profileFunlinks'] = this.profileFunlinks;
    data['profileFollowlinks'] = this.profileFollowlinks;
    data['profileJobLinksFaces'] = this.profileJobLinksFaces;
    data['profileJobLinksCrew'] = this.profileJobLinksCrew;
    data['profileImageType'] = this.profileImageType;
    data['username'] = this.username;
    if (this.winnerTitles != null) {
      //data['winnerTitles'] = this.winnerTitles!.map((v) => v.toJson()).toList();
    }
    if (this.runnerUp != null) {
      //data['runnerUp'] = this.runnerUp!.map((v) => v.toJson()).toList();
    }
    data['level'] = this.level;
    data['score'] = this.score;
    data['thanksGifted'] = this.thanksGifted;
    data['thanksBalance'] = this.thanksBalance;
    data['todaysPosts'] = this.todaysPosts;
    data['perdayPost'] = this.perdayPost;
    data['countryCode'] = this.countryCode;
    data['referralLink'] = this.referralLink;
    data['challengesWon'] = this.challengesWon;
    data['challengesSponsered'] = this.challengesSponsered;
    if (this.contestPath != null) {
      //data['contestPath'] = this.contestPath!.toJson();
    }
    return data;
  }
}
// class Agency {
//   Agency({
//     this.verificationDoc,
//     this.bannerMedia,
//   });
//
//   List<dynamic> verificationDoc;
//   List<dynamic> bannerMedia;
//
//   factory Agency.fromJson(Map<String, dynamic> json) => Agency(
//     verificationDoc : json['verificationDoc'] != null
//         ? new List<dynamic>.from(json["verificationDoc"].map((x) => x)): null,
//     bannerMedia : json['bannerMedia'] != null
//         ? new List<dynamic>.from(json["bannerMedia"].map((x) => x)): null,
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "verificationDoc": List<dynamic>.from(verificationDoc.map((x) => x)),
//     "bannerMedia": List<dynamic>.from(bannerMedia.map((x) => x)),
//   };
// }

class ContestPath {
  ContestPath({
    this.district,
    this.state,
    this.country,
    this.continent,
    this.world,
  });

  Continent? district;
  Continent? state;
  Continent? country;
  Continent? continent;
  Continent? world;

  factory ContestPath.fromJson(Map<String, dynamic> json) => ContestPath(
    district: Continent.fromJson(json["district"]),
    state: Continent.fromJson(json["state"]),
    country: Continent.fromJson(json["country"]),
    continent: Continent.fromJson(json["continent"]),
    world: Continent.fromJson(json["world"]),
  );

  Map<String, dynamic> toJson() => {
    "district": district!.toJson(),
    "state": state!.toJson(),
    "country": country!.toJson(),
    "continent": continent!.toJson(),
    "world": world!.toJson(),
  };
}

class Continent {
  Continent({
    this.name,
    this.isWinner,
  });

  String? name;
  String? isWinner;

  factory Continent.fromJson(Map<String, dynamic> json) => Continent(
    name: json["name"],
    isWinner: json["isWinner"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "isWinner": isWinner.toString(),
  };
}

class Settings {
  Settings({
    this.notification,
  });

  Notification? notification;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    notification: Notification.fromJson(json["notification"]),
  );

  Map<String, dynamic> toJson() => {
    "notification": notification!.toJson(),
  };
}

class Notification {
  Notification({
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

  String? comments;
  String? likes;
  String? trendingPosts;
  String? requestAccepted;
  String? followRequest;
  String? newFollower;
  String? sponser;
  String? liveEvents;
  String? upcomingChallenges;
  String? endingChallenges;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    comments: json["comments"].toString(),
    likes: json["likes"].toString(),
    trendingPosts: json["trendingPosts"].toString(),
    requestAccepted: json["requestAccepted"].toString(),
    followRequest: json["followRequest"].toString(),
    newFollower: json["newFollower"].toString(),
    sponser: json["sponser"].toString(),
    liveEvents: json["liveEvents"].toString(),
    upcomingChallenges: json["upcomingChallenges"].toString(),
    endingChallenges: json["endingChallenges"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "comments": comments.toString(),
    "likes": likes.toString(),
    "trendingPosts": trendingPosts.toString(),
    "requestAccepted": requestAccepted.toString(),
    "followRequest": followRequest.toString(),
    "newFollower": newFollower.toString(),
    "sponser": sponser.toString(),
    "liveEvents": liveEvents.toString(),
    "upcomingChallenges": upcomingChallenges.toString(),
    "endingChallenges": endingChallenges.toString(),
  };
}
