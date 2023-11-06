// To parse this JSON data, do
//
//     final myInfoResponse = myInfoResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse myInfoResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String myInfoResponseToJson(ProfileResponse data) => json.encode(data.toJson());

class ProfileResponse {
  MyProfileResult? result;
  String? message;
  bool? success;

  ProfileResponse({this.result, this.message, this.success});

  ProfileResponse.fromJson(Map<dynamic, dynamic> json) {
    result =
    json['result'] != null ? new MyProfileResult.fromJson(json['result']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class MyProfileResult {
  String? id;
  String? name;
  int? mobileNumber;
  String? gender;
  String? type;
  String? bio;
  String? profession;
  String? district;
  String? state;
  String? country;
  String? continent;
  String? dob;
  String? username;
  String? email;
  String? profileImageType;
  String? referredBy;
  bool? isRegistered;
  bool? isVerified;
  String? ageGroup;
  int? todaysPosts;
  int? recommendationCount;
  String? profileImage;
  int? followingCount;
  int? followersCount;
  int? fameCoins;
  int? likesCount;
  int? score;
  List<RunnerUp>? winnerTitles;
  List<RunnerUp>? runnerUp;
  String? countryLevel;
  bool? followStatus;
  Settings? settings;
  Brand? brand;
  Agency? agency;
  ContestPath? contestPath;
  String? referralLink;
  String? verificationStatus;
  String? challengesWon;
  String? challengesSponsered;
  String? chatId;
  S3? s3;

  MyProfileResult(
      {this.id,
        this.name,
        this.mobileNumber,
        this.gender,
        this.type,
        this.bio,
        this.profession,
        this.followingCount,this.profileImageType,
        this.likesCount,
        this.score,
        this.followersCount,
        this.fameCoins,
        this.district,
        this.state,
        this.country,
        this.recommendationCount,
        this.email,
        this.referredBy,
        this.continent,
        this.dob,
        this.username,
        this.isRegistered,
        this.ageGroup,
        this.isVerified,
        this.profileImage,
        this.brand,
        this.agency,
        this.contestPath,
        this.winnerTitles,
        this.runnerUp,
        this.countryLevel,
        this.chatId,
        this.verificationStatus,
        this.followStatus,
        this.challengesWon,
        this.challengesSponsered,
      this.settings,this.referralLink,this.s3});

  MyProfileResult.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    mobileNumber = json['mobileNumber'];
    gender = json['gender'];
    type = json['type'];
    bio = json['bio'];
    profession = json['profession'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    email = json['email'];
    dob = json['dob'];
    username = json['username'];
    profileImageType = json['profileImageType'];
    referredBy = json['referredBy'];
    isRegistered = json['isRegistered'];
    isVerified = json['isVerified'];
    ageGroup = json['ageGroup'];
    todaysPosts = json['todaysPosts'];
    recommendationCount = json['recommendationCount'];
    profileImage = json['profileImage'];
    followingCount = json['followingCount'];
    followersCount = json['followersCount'];
    fameCoins = json['fameCoins'];
    score = json['score'];
    likesCount = json['likesCount'];
    verificationStatus = json['verificationStatus'];
    if (json['winnerTitles'] != null) {
      winnerTitles = <RunnerUp>[];
      json['winnerTitles'].forEach((v) {
        winnerTitles!.add(new RunnerUp.fromJson(v));
      });
    }
    if (json['runnerUp'] != null) {
      runnerUp = <RunnerUp>[];
      json['runnerUp'].forEach((v) {
        runnerUp!.add(new RunnerUp.fromJson(v));
      });
    }
    countryLevel = json['countryLevel'];
    followStatus = json['followStatus'];
    referralLink = json['referralLink'];
    chatId = json['chatId'];
    challengesSponsered = json['challengesSponsered'];
    challengesWon = json['challengesWon'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    brand = json['brand'] != null
        ? new Brand.fromJson(json['brand'])
        : null;
    agency = json['agency'] != null
        ? new Agency.fromJson(json['agency'])
        : null;
    contestPath = json['contestPath'] != null
        ? new ContestPath.fromJson(json['contestPath'])
        : null;
    s3 = json['s3'] != null ? new S3.fromJson(json['s3']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['email'] = this.email;
    data['continent'] = this.continent;
    data['dob'] = this.dob;
    data['todaysPosts'] = this.todaysPosts;
    data['recommendationCount'] = this.recommendationCount;
    data['username'] = this.username;
    data['referredBy'] = this.referredBy;
    data['isRegistered'] = this.isRegistered;
    data['isVerified'] = this.isVerified;
    data['ageGroup'] = this.ageGroup;
    data['profileImage'] = this.profileImage;
    data['followingCount'] = this.followingCount;
    data['followersCount'] = this.followersCount;
    data['fameCoins'] = this.fameCoins;
    data['likesCount'] = this.likesCount;
    data['challengesWon'] = this.challengesWon;
    data['challengesSponsered'] = this.challengesSponsered;
    data['verificationStatus'] = this.verificationStatus;
    data['score'] = this.score;
    if (this.winnerTitles != null) {
      data['winnerTitles'] = this.winnerTitles!.map((v) => v.toJson()).toList();
    }
    if (this.runnerUp != null) {
      data['runnerUp'] = this.runnerUp!.map((v) => v.toJson()).toList();
    }
    data['countryLevel'] = this.countryLevel;
    data['followStatus'] = this.followStatus;
    data['referralLink'] = this.referralLink;
    data['chatId'] = this.chatId;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    if (this.contestPath != null) {
      data['contestPath'] = this.contestPath!.toJson();
    }
    return data;
  }
}
class Brand {
  List<String>? bannerMedia;
  String? websiteUrl;
  Brand({this.bannerMedia});

  Brand.fromJson(Map<String, dynamic> json) {
    websiteUrl = json['websiteUrl'] != null ? json['websiteUrl']:"";
    bannerMedia = json['bannerMedia'] != null ? json['bannerMedia'].cast<String>():[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerMedia'] = this.bannerMedia;
    data['websiteUrl'] = this.websiteUrl;
    return data;
  }
}
class Agency {
  List<String>? bannerMedia;
  String? websiteUrl;
  Agency({this.bannerMedia});

  Agency.fromJson(Map<String, dynamic> json) {
    bannerMedia = json['bannerMedia'] != null ? json['bannerMedia'].cast<String>():[];
    websiteUrl = json['websiteUrl'] != null ? json['websiteUrl']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerMedia'] = this.bannerMedia;
    data['websiteUrl'] = this.websiteUrl;
    return data;
  }
}
class ContestPath {
  District? district;
  District? state;
  District? country;
  District? continent;
  District? world;

  ContestPath({this.district, this.state, this.country, this.continent});

  ContestPath.fromJson(Map<String, dynamic> json) {
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    state = json['state'] != null ? new District.fromJson(json['state']) : null;
    country =
    json['country'] != null ? new District.fromJson(json['country']) : null;
    continent = json['continent'] != null
        ? new District.fromJson(json['continent'])
        : null;
    world = json['world'] != null
        ? new District.fromJson(json['world'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.continent != null) {
      data['continent'] = this.continent!.toJson();
    }
    if (this.world != null) {
      data['world'] = this.world!.toJson();
    }
    return data;
  }
}

class District {
  String? name;
  bool? isWinner;

  District({this.name, this.isWinner});

  District.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isWinner = json['isWinner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isWinner'] = this.isWinner;
    return data;
  }
}


class RunnerUp {
  String? title;
  String? date;
  String? type;

  RunnerUp({this.title, this.date, this.type});

  RunnerUp.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    type = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['category'] = this.type;
    return data;
  }
}

class Settings {
  Notifications? notification;

  Settings({this.notification});

  Settings.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? new Notifications.fromJson(json['notification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    return data;
  }
}

class Notifications {
  bool? comments;
  bool? likes;
  bool? trendingPosts;
  bool? newFollower;
  bool? sponser;
  bool? liveEvents;
  bool? upcomingChallenges;
  bool? endingChallenges;

  Notifications({this.comments, this.likes, this.trendingPosts, this.newFollower, this.sponser, this.liveEvents, this.upcomingChallenges, this.endingChallenges});

  Notifications.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    likes = json['likes'];
    trendingPosts = json['trendingPosts'];
    newFollower = json['newFollower'];
    sponser = json['sponser'];
    liveEvents = json['liveEvents'];
    upcomingChallenges = json['upcomingChallenges'];
    endingChallenges = json['endingChallenges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['likes'] = this.likes;
    data['trendingPosts'] = this.trendingPosts;
    data['newFollower'] = this.newFollower;
    data['sponser'] = this.sponser;
    data['liveEvents'] = this.liveEvents;
    data['upcomingChallenges'] = this.upcomingChallenges;
    data['endingChallenges'] = this.endingChallenges;
    return data;
  }
}
class S3 {
  Bucket? bucket;
  String? s3UrlPath;

  S3({this.bucket, this.s3UrlPath});

  S3.fromJson(Map<String, dynamic> json) {
    bucket =
    json['bucket'] != null ? new Bucket.fromJson(json['bucket']) : null;
    s3UrlPath = json['s3UrlPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bucket != null) {
      data['bucket'] = this.bucket!.toJson();
    }
    data['s3UrlPath'] = this.s3UrlPath;
    return data;
  }
}

class Bucket {
  String? name;
  String? famelinks;
  String? followlinks;
  String? profile;
  String? funlinks;
  String? funlinksMusic;
  String? avatar;
  String? joblinks;
  String? cluboffer;
  String? challenges;
  String? trendz;

  Bucket(
      {this.name,
        this.famelinks,
        this.followlinks,
        this.profile,
        this.funlinks,
        this.funlinksMusic,
        this.avatar,
        this.joblinks,
        this.cluboffer,
        this.challenges,
        this.trendz,
      });

  Bucket.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    famelinks = json['famelinks'];
    followlinks = json['followlinks'];
    profile = json['profile'];
    funlinks = json['funlinks'];
    funlinksMusic = json['funlinksMusic'];
    avatar = json['avatar'];
    joblinks = json['joblinks'];
    cluboffer = json['cluboffer'];
    challenges = json['challenges'];
    trendz = json['trendz'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['famelinks'] = this.famelinks;
    data['followlinks'] = this.followlinks;
    data['profile'] = this.profile;
    data['funlinks'] = this.funlinks;
    data['funlinksMusic'] = this.funlinksMusic;
    data['avatar'] = this.avatar;
    data['joblinks'] = this.joblinks;
    data['cluboffer'] = this.cluboffer;
    data['challenges'] = this.challenges;
    data['trendz'] = this.trendz;
    return data;
  }
}

