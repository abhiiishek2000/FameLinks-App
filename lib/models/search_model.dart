import 'OpenChallengesResponse.dart';

// class SearchResponse {
//
//   Result result;
//   String message;
//   bool success;
//
//   SearchResponse({this.result, this.message, this.success});
//
//   SearchResponse.fromJson(Map<String, dynamic> json) {
//     result = json['result'] != null  new Result.fromJson(json['result']) : null;
//     message = json['message'];
//     success = json['success'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result.toJson();
//     }
//     data['message'] = this.message;
//     data['success'] = this.success;
//     return data;
//   }
// }
// class Result {
//   List<User> users;
//   List<Challenge> challenges;
//   List<OpenChallengesResult> hashTags;
//
//   Result(
//       {this.users,
//         this.challenges});
//
//   Result.fromJson(Map<String, dynamic> json) {
//     if (json['users'] != null) {
//       users = <User>[];
//       json['users'].forEach((v) {
//         users.add(new User.fromJson(v));
//       });
//     }
//     if (json['challenges'] != null) {
//       challenges = <Challenge>[];
//       json['challenges'].forEach((v) {
//         challenges.add(new Challenge.fromJson(v));
//       });
//     }
//     if (json['hashTags'] != null) {
//       hashTags = <OpenChallengesResult>[];
//       json['hashTags'].forEach((v) {
//         hashTags.add(new OpenChallengesResult.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.users != null) {
//       data['users'] = this.users.map((v) => v.toJson()).toList();
//     }
//     if (this.challenges != null) {
//       data['challenges'] = this.challenges.map((v) => v.toJson()).toList();
//     }
//     if (this.hashTags != null) {
//       data['hashTags'] = this.hashTags.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class User {
//   String sId;
//   String name;
//   String type;
//   String district;
//   String state;
//   String country;
//   String gender;
//   String ageGroup;
//   bool followStatus;
//   List<Media> images;
//
//   User(
//       {this.sId,
//         this.name,
//         this.district,
//         this.state,
//         this.country,
//         this.gender,
//         this.ageGroup,
//         this.followStatus,
//         this.images});
//
//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     type = json['type'];
//     district = json['district'];
//     state = json['state'];
//     country = json['country'];
//     gender = json['gender'];
//     ageGroup = json['ageGroup'];
//     followStatus = json['followStatus'];
//     if (json['media'] != null) {
//       images = <Media>[];
//       json['media'].forEach((v) {
//         images.add(new Media.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['district'] = this.district;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['gender'] = this.gender;
//     data['ageGroup'] = this.ageGroup;
//     data['followStatus'] = this.followStatus;
//     if (this.images != null) {
//       data['media'] = this.images.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Challenge {
//   String sId;
//   String name;
//   String description;
//   String reward;
//   String type;
//   String image;
//   String hashTag;
//
//   Challenge(
//       {this.sId,
//         this.name,
//         this.description,
//         this.reward,
//         this.hashTag,
//         this.type,
//         this.image});
//
//   Challenge.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     description = json['description'];
//     reward = json['reward'];
//     type = json['type'];
//     image = json['image'];
//     hashTag = json['hashTag'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['reward'] = this.reward;
//     data['type'] = this.type;
//     data['image'] = this.image;
//     data['hashTag'] = this.hashTag;
//     return data;
//   }
// }
//
// class HshTag {
//   String sId;
//   String name;
//   String sponsor;
//   String description;
//   String reward;
//   String startDate;
//   String endDate;
//   String type;
//   String image;
//   List<String> hashTag;
//   List<String> forUser;
//   List<String> mediaPreference;
//
//   HshTag(
//       {this.sId,
//         this.name,
//         this.sponsor,
//         this.description,
//         this.reward,
//         this.startDate,
//         this.endDate,
//         this.type,
//         this.image,
//         this.hashTag,
//         this.forUser,
//         this.mediaPreference});
//
//   HshTag.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     sponsor = json['sponsor'];
//     description = json['description'];
//     reward = json['reward'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//     type = json['type'];
//     image = json['image'];
//     hashTag = json['hashTag'].cast<String>();
//     forUser = json['for'].cast<String>();
//     mediaPreference = json['mediaPreference'].cast<String>();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['sponsor'] = this.sponsor;
//     data['description'] = this.description;
//     data['reward'] = this.reward;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     data['type'] = this.type;
//     data['image'] = this.image;
//     data['hashTag'] = this.hashTag;
//     data['for'] = this.forUser;
//     data['mediaPreference'] = this.mediaPreference;
//     return data;
//   }
// }
//
// class Media {
//   String image;
//   int likesCount;
//
//   Media(
//       {this.image,
//         this.likesCount});
//
//   Media.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     likesCount = json['likesCount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['likesCount'] = this.likesCount;
//     return data;
//   }
// }
class SearchResponse {
  Result? result;
  String? message;
  bool? success;

  SearchResponse({this.result, this.message, this.success});

  SearchResponse.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  List<SearchChallenges>? challenges;
  List<HashTags>? hashTags;
  List<SearchUsers>? users;

  Result({this.challenges, this.hashTags, this.users});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['challenges'] != null) {
      challenges = <SearchChallenges>[];
      json['challenges'].forEach((v) { challenges!.add(new SearchChallenges.fromJson(v)); });
    }
    if (json['hashTags'] != null) {
      hashTags = <HashTags>[];
      json['hashTags'].forEach((v) { hashTags!.add(new HashTags.fromJson(v)); });
    }
    if (json['users'] != null) {
      users = <SearchUsers>[];
      json['users'].forEach((v) { users!.add(new SearchUsers.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.challenges != null) {
      data['challenges'] = this.challenges!.map((v) => v.toJson()).toList();
    }
    if (this.hashTags != null) {
      data['hashTags'] = this.hashTags!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchChallenges {
  String? sId;
  String? hashTag;
  int? totalImpressions;
  int? totalPost;
  int? totalParticipants;
  bool? isDeleted;
  String? type;
  String? createdAt;
  String? updatedAt;

  SearchChallenges(
      {this.sId,
        this.hashTag,
        this.totalImpressions,
        this.totalPost,
        this.totalParticipants,
        this.isDeleted,
        this.type,
        this.createdAt,
        this.updatedAt});

  SearchChallenges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hashTag = json['hashTag'];
    totalImpressions = json['totalImpressions'];
    totalPost = json['totalPost'];
    totalParticipants = json['totalParticipants'];
    isDeleted = json['isDeleted'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hashTag'] = this.hashTag;
    data['totalImpressions'] = this.totalImpressions;
    data['totalPost'] = this.totalPost;
    data['totalParticipants'] = this.totalParticipants;
    data['isDeleted'] = this.isDeleted;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
class HashTags {
  String? sId;
  String? hashTag;
  int? totalImpressions;
  int? totalPost;
  int? totalParticipants;
  bool? isDeleted;
  String? type;
  String? createdAt;
  String? updatedAt;

  HashTags(
      {this.sId,
        this.hashTag,
        this.totalImpressions,
        this.totalPost,
        this.totalParticipants,
        this.isDeleted,
        this.type,
        this.createdAt,
        this.updatedAt});

  HashTags.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    hashTag = json['hashTag'];
    totalImpressions = json['totalImpressions'];
    totalPost = json['totalPost'];
    totalParticipants = json['totalParticipants'];
    isDeleted = json['isDeleted'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['hashTag'] = this.hashTag;
    data['totalImpressions'] = this.totalImpressions;
    data['totalPost'] = this.totalPost;
    data['totalParticipants'] = this.totalParticipants;
    data['isDeleted'] = this.isDeleted;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
class SearchUsers {
  String? sId;
  String? name;
  String? gender;
  String? type;
  String? district;
  String? state;
  String? country;
  String? continent;
  String? ageGroup;
  String? profileImage;
  bool? followStatus;
  List<Media>? media;

  SearchUsers({this.sId, this.name, this.gender, this.type, this.district, this.state, this.country, this.continent, this.ageGroup, this.profileImage, this.followStatus, this.media});

  SearchUsers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    gender = json['gender'];
    type = json['type'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    ageGroup = json['ageGroup'];
    profileImage = json['profileImage'];
    followStatus = json['followStatus'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) { media!.add(new Media.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['ageGroup'] = this.ageGroup;
    data['profileImage'] = this.profileImage;
    data['followStatus'] = this.followStatus;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Media {
  String? image;
  int? likesCount;

  Media({this.image, this.likesCount});

  Media.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    likesCount = json['likesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['likesCount'] = this.likesCount;
    return data;
  }
}

class Sponsor {
  String? sId;
  String? name;

  Sponsor({this.sId, this.name});

  Sponsor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
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