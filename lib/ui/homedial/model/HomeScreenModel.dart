







class HomeScreenModel {
  List<Result>? result;
  String? message;
  bool? success;

  HomeScreenModel({this.result, this.message, this.success});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }

    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null ){
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}


class Result {
  String? title;
  String? category;
  List<PostResult>? postResult;
  List<TrendzResult>? trendzResult;
  List<UserResult>? userResult;

  Result({this.title, this.category, this.postResult});

  Result.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
    if (json['result'] != null) {
      if(json['category'] == "post"){
        postResult = <PostResult>[];
        json['result'].forEach((v) { postResult!.add(new PostResult.fromJson(v)); });
      }else if(json['category'] == "trendz"){
        trendzResult = <TrendzResult>[];
        json['result'].forEach((v) { trendzResult!.add(new TrendzResult.fromJson(v)); });
      } else if(json['category'] == "user"){
        userResult = <UserResult>[];
        json['result'].forEach((v) { userResult!.add(new UserResult.fromJson(v)); });
      }

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['category'] = this.category;
    if (this.postResult != null) {
      data['result'] = this.postResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class PostResult {
  String? sId;
  String? description;
  String? district;
  String? state;
  String? country;
  int? likes1Count;
  int? likes2Count;
  String? createdAt;
  List<Challenges>? challenges;
  String? cardTitle;
  List<Media>? media;
  int? likes;

  PostResult(
      {this.sId,
        this.description,
        this.district,
        this.state,
        this.country,
        this.likes1Count,
        this.likes2Count,
        this.createdAt,
        this.challenges,
        this.cardTitle,
        this.media,
        this.likes});

  PostResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    likes1Count = json['likes1Count'];
    likes2Count = json['likes2Count'];
    createdAt = json['createdAt'];
    if (json['challenges'] != null) {
      challenges = <Challenges>[];
      json['challenges'].forEach((v) {
        challenges!.add(new Challenges.fromJson(v));
      });
    }
    cardTitle = json['cardTitle'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['likes1Count'] = this.likes1Count;
    data['likes2Count'] = this.likes2Count;
    data['createdAt'] = this.createdAt;
    if (this.challenges != null) {
      data['challenges'] = this.challenges!.map((v) => v.toJson()).toList();
    }
    data['cardTitle'] = this.cardTitle;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    data['likes'] = this.likes;
    return data;
  }
}

class Challenges {
  String? sId;
  String? hashTag;

  Challenges({this.sId, this.hashTag});

  Challenges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hashTag = json['hashTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hashTag'] = this.hashTag;
    return data;
  }
}

class Media {
  String? path;
  String? type;

  Media({this.path, this.type});

  Media.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    return data;
  }
}

class TrendzResult {
  String? sId;
  String? sponsor;
  String? description;
  String? startDate;
  String? category;
  bool? isCompleted;
  int? totalImpressions;
  int? requiredImpressions;
  int? totalPost;
  int? requiredPost;
  int? requiredParticipants;
  int ? totalParticipants;
  String? type;
  List<String>? for1;
  List<String>? mediaPreference;
  List<String>? images;
  String? hashTag;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  List<RewardRunnerUp>? rewardRunnerUp;
  List<RewardWinner>? rewardWinner;
  String? cardTitle;

  TrendzResult({this.sId, this.sponsor, this.description, this.startDate, this.category, this.isCompleted, this.totalImpressions, this.requiredImpressions, this.totalPost, this.requiredPost, this.requiredParticipants, this.totalParticipants, this.type, this.for1, this.mediaPreference, this.images, this.hashTag, this.isDeleted, this.createdAt, this.updatedAt, this.rewardRunnerUp, this.rewardWinner, this.cardTitle});

  TrendzResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sponsor = json['sponsor'];
    description = json['description'];
    startDate = json['startDate'];
    category = json['category'];
    isCompleted = json['isCompleted'];
    totalImpressions = json['totalImpressions'];
    requiredImpressions = json['requiredImpressions'];
    totalPost = json['totalPost'];
    requiredPost = json['requiredPost'];
    requiredParticipants = json['requiredParticipants'];
    totalParticipants = json['totalParticipants'];
    type = json['type'];
    for1 = json['for'].cast<String>();
    mediaPreference = json['mediaPreference'].cast<String>();
    images = json['images'].cast<String>();
    hashTag = json['hashTag'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['rewardRunnerUp'] != null) {
      rewardRunnerUp = <RewardRunnerUp>[];
      json['rewardRunnerUp'].forEach((v) { rewardRunnerUp!.add(new RewardRunnerUp.fromJson(v)); });
    }
    if (json['rewardWinner'] != null) {
      rewardWinner = <RewardWinner>[];
      json['rewardWinner'].forEach((v) { rewardWinner!.add(new RewardWinner.fromJson(v)); });
    }
    cardTitle = json['cardTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sponsor'] = this.sponsor;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['category'] = this.category;
    data['isCompleted'] = this.isCompleted;
    data['totalImpressions'] = this.totalImpressions;
    data['requiredImpressions'] = this.requiredImpressions;
    data['totalPost'] = this.totalPost;
    data['requiredPost'] = this.requiredPost;
    data['requiredParticipants'] = this.requiredParticipants;
    data['totalParticipants'] = this.totalParticipants;
    data['type'] = this.type;
    data['for'] = this.for1;
    data['mediaPreference'] = this.mediaPreference;
    data['images'] = this.images;
    data['hashTag'] = this.hashTag;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.rewardRunnerUp != null) {
      data['rewardRunnerUp'] = this.rewardRunnerUp!.map((v) => v.toJson()).toList();
    }
    if (this.rewardWinner != null) {
      data['rewardWinner'] = this.rewardWinner!.map((v) => v.toJson()).toList();
    }
    data['cardTitle'] = this.cardTitle;
    return data;
  }
}

class RewardRunnerUp {
  String? giftName;
  String? giftValue;
  String? giftImage;

  RewardRunnerUp({this.giftName, this.giftValue, this.giftImage});

  RewardRunnerUp.fromJson(Map<String, dynamic> json) {
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

class RewardWinner {
  String? giftName;
  dynamic? giftValue;
  String? giftImage;

  RewardWinner({this.giftName, this.giftValue, this.giftImage});

  RewardWinner.fromJson(Map<String, dynamic> json) {
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

class UserResult {
  String? sId;
  String? type;
  String? profileImage;
  String? cardTitle;
  String? profileImageType;

  UserResult(
      {this.sId,
        this.type,
        this.profileImage,
        this.cardTitle,
        this.profileImageType});

  UserResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    profileImage = json['profileImage'];
    cardTitle = json['cardTitle'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['profileImage'] = this.profileImage;
    data['cardTitle'] = this.cardTitle;
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}