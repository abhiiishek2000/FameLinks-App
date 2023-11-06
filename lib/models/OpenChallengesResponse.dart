import 'package:famelink/models/AddRatingResponse.dart';
import 'package:famelink/models/famelinks_model.dart';

class OpenChallengesResponse {
  List<OpenChallengesResult>? result;
  String? message;
  bool? success;

  OpenChallengesResponse({this.result, this.message, this.success});

  OpenChallengesResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <OpenChallengesResult>[];
      json['result'].forEach((v) {
        result!.add(new OpenChallengesResult.fromJson(v));
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

// class OpenChallengesResult {
//   String sId;
//   String name;
//   String sponsor;
//   String description;
//   String reward;
//   String startDate;
//   double percentCompleted;
//   int participantsCount;
//   String type;
//   List<Users> users;
//   List<String> images;
//   List<String> forUser;
//   List<String> mediaPreference;
//   List<Result> posts;
//
//   OpenChallengesResult(
//       {this.sId,
//       this.name,
//       this.sponsor,
//         this.users,
//       this.description,
//       this.reward,
//       this.startDate,
//       this.percentCompleted,
//       this.participantsCount,
//       this.type,
//       this.images,
//       this.forUser,
//       this.mediaPreference,
//       this.posts});
//
//   OpenChallengesResult.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     sponsor = json['sponsor'];
//     description = json['description'];
//     reward = json['reward'];
//     startDate = json['startDate'];
//     users = json["users"] == null ? [] : List<Users>.from(json["users"].map((x) => Users.fromJson(x)));
//     percentCompleted = json['percentCompleted'] != null ?double.parse(json['percentCompleted'].toString()):0;
//     participantsCount = json['participantsCount'];
//     type = json['type'];
//     images = json['images'].cast<String>();
//     forUser = json['for'].cast<String>();
//     mediaPreference = json['mediaPreference'].cast<String>();
//     if (json['posts'] != null) {
//       posts = <Result>[];
//       json['posts'].forEach((v) {
//         posts.add(new Result.fromJson(v));
//       });
//     }
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
//     data['percentCompleted'] = this.percentCompleted;
//     data['participantsCount'] = this.participantsCount;
//     data['type'] = this.type;
//     data['images'] = this.images;
//     data['users'] = this.users;
//     data['for'] = this.forUser;
//     data['mediaPreference'] = this.mediaPreference;
//     if (this.posts != null) {
//       data['posts'] = this.posts.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
// class Users {
//   String sId;
//   String name;
//   String type;
//
//   Users({this.sId, this.name, this.type});
//
//   Users.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     return data;
//   }
// }




class OpenChallengesResult {
  String? sId;
  List<Sponsor>? sponsor;
  String? description;
  String? startDate;
  String? category;
  bool? isCompleted;
  int? totalImpressions;
  int? requiredImpressions;
  int? totalPost;
  int? requiredPost;
  int? requiredParticipants;
  int? totalParticipants;
  String? type;
  List<String>? for1;
  String? hashTag;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  List<RewardRunnerUp>? rewardRunnerUp;
  List<RewardWinner>? rewardWinner;
  List<OpenChallengesResultUsers>? users;
  List<OpenChallengesResponseResultPosts>? posts;
  AddRatingResponseResult? rating;
  List<Result>? postsForFameLink;
  dynamic percentCompleted;
  int? participantsCount;
  String? reward;
  String? challengeCompleteAt;
  List<Winner>? winner;
  List<MediaSet>? media;
  List<String>? bannerImage;
  int? giftCoins;


  OpenChallengesResult({this.sId,
    this.sponsor,
    this.description,
    this.startDate,
    this.category,
    this.isCompleted,
    this.totalImpressions,
    this.requiredImpressions,
    this.totalPost,
    this.requiredPost,
    this.requiredParticipants,
    this.totalParticipants,
    this.type,this.media,
    this.hashTag,
    this.isDeleted,this.for1,
    this.createdAt,
    this.updatedAt,
    this.rewardRunnerUp,
    this.rewardWinner,
    this.users,
    this.posts,
    this.rating,
    this.postsForFameLink,
    this.percentCompleted,
    this.participantsCount,
    this.reward,
    this.challengeCompleteAt,this.bannerImage,
    this.winner, this.giftCoins});

  OpenChallengesResult.fromJson(

Map<String, dynamic> json
) {
sId = json['_id'];
if (json['sponsor'] != null) {
  sponsor = <Sponsor>[];
  json['sponsor'].forEach((v) { sponsor!.add(new Sponsor.fromJson(v)); });
}
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
hashTag = json['hashTag'];
isDeleted = json['isDeleted'];
createdAt = json['createdAt'];
updatedAt = json['updatedAt'];
giftCoins = json['giftCoins'] == null ? null : json['giftCoins'];
if (json['media'] != null) {
  media = <MediaSet>[];
  json['media'].forEach((v) { media!.add(new MediaSet.fromJson(v)); });
}
if (json['rewardRunnerUp'] != null) {
rewardRunnerUp = <RewardRunnerUp>[];
json['rewardRunnerUp'].forEach((v) { rewardRunnerUp!.add(new RewardRunnerUp.fromJson(v)); });
}
if (json['rewardWinner'] != null) {
rewardWinner = <RewardWinner>[];
json['rewardWinner'].forEach((v) { rewardWinner!.add(new RewardWinner.fromJson(v)); });
}
if (json['users'] != null) {
users = <OpenChallengesResultUsers>[];
json['users'].forEach((v) { users!.add(new OpenChallengesResultUsers.fromJson(v)); });
}
if (json['posts'] != null) {
posts = <OpenChallengesResponseResultPosts>[];
postsForFameLink = <Result>[];
json['posts'].forEach((v) { posts!.add(new OpenChallengesResponseResultPosts.fromJson(v)); });
json['posts'].forEach((v) { postsForFameLink!.add(new Result.fromJson(v)); });
}

if(json['rating'] != null){
rating = AddRatingResponseResult.fromJson(json['rating']);
}
for1 = json['for'] != null ? json['for'].cast<String>():[];
percentCompleted = json['percentCompleted'];
participantsCount = json['participantsCount'];
reward = json['reward'];
challengeCompleteAt = json['challengeCompleteAt'];
if (json['winner'] != null) {
winner = <Winner>[];
json['winner'].forEach((v) { winner!.add(new Winner.fromJson(v)); });
}
bannerImage = json['images'] != null ? json['images'].cast<String>():[];
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
  data['hashTag'] = this.hashTag;
  data['isDeleted'] = this.isDeleted;
  data['createdAt'] = this.createdAt;
  data['updatedAt'] = this.updatedAt;
  data['giftCoins'] = this.giftCoins;
  if (this.rewardRunnerUp != null) {
    data['rewardRunnerUp'] =
        this.rewardRunnerUp!.map((v) => v.toJson()).toList();
  }
  if (this.rewardWinner != null) {
    data['rewardWinner'] = this.rewardWinner!.map((v) => v.toJson()).toList();
  }
  if (this.users != null) {
    data['users'] = this.users!.map((v) => v.toJson()).toList();
  }
  if (this.posts != null) {
    data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    data['posts'] = this.postsForFameLink!.map((v) => v.toJson()).toList();
  }
  if(this.rating != null){
    data['rating'] = this.rating!.toJson();
  }
  data['percentCompleted'] = this.percentCompleted;
  data['participantsCount'] = this.participantsCount;
  data['reward'] = this.reward;
  data['challengeCompleteAt'] = this.challengeCompleteAt;
  if (this.winner != null) {
    data['winner'] = this.winner!.map((v) => v.toJson()).toList();
  }

  return data;
}



}
class MediaSet {
  String?  path;
  String? type;

  MediaSet(
      {this.path,
        this.type});

  MediaSet.fromJson(Map<String, dynamic> json) {
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
class Sponsor {
  String? id;
  String? name;
  String? profileImage;
  String? profileImageType;

  Sponsor({this.id, this.name,this.profileImage,this.profileImageType});

  Sponsor.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
class RewardWinner {
  String? giftName;
  dynamic giftValue;
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

class OpenChallengesResultUsers {
  String? sId;
  String? name;
  String? type;

  OpenChallengesResultUsers({this.sId, this.name, this.type});

  OpenChallengesResultUsers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

// class Posts {
//   String sId;
//   String description;
//   String district;
//   String state;
//   String country;
//   int likes0Count;
//   int likes1Count;
//   int likes2Count;
//   int commentsCount;
//   String createdAt;
//   String updatedAt;
//   User user;
//   List<WinnerTitle> winnerTitle;
//   List<Challenges> challenges;
//   bool followStatus;
//   Null likeStatus;
//   List<Media> media;
//
//   Posts({this.sId, this.description, this.district, this.state, this.country, this.likes0Count, this.likes1Count, this.likes2Count, this.commentsCount, this.createdAt, this.updatedAt, this.user, this.winnerTitle, this.challenges, this.followStatus, this.likeStatus, this.media});
//
//   Posts.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     description = json['description'];
//     district = json['district'];
//     state = json['state'];
//     country = json['country'];
//     likes0Count = json['likes0Count'];
//     likes1Count = json['likes1Count'];
//     likes2Count = json['likes2Count'];
//     commentsCount = json['commentsCount'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     if (json['winnerTitle'] != null) {
//       winnerTitle = <WinnerTitle>[];
//       json['winnerTitle'].forEach((v) { winnerTitle.add(new WinnerTitle.fromJson(v)); });
//     }
//     if (json['challenges'] != null) {
//       challenges = <Challenges>[];
//       json['challenges'].forEach((v) { challenges.add(new Challenges.fromJson(v)); });
//     }
//     followStatus = json['followStatus'];
//     likeStatus = json['likeStatus'];
//     if (json['media'] != null) {
//       media = <Media>[];
//       json['media'].forEach((v) { media.add(new Media.fromJson(v)); });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['description'] = this.description;
//     data['district'] = this.district;
//     data['state'] = this.state;
//     data['country'] = this.country;
//     data['likes0Count'] = this.likes0Count;
//     data['likes1Count'] = this.likes1Count;
//     data['likes2Count'] = this.likes2Count;
//     data['commentsCount'] = this.commentsCount;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     if (this.user != null) {
//       data['user'] = this.user.toJson();
//     }
//     if (this.winnerTitle != null) {
//       data['winnerTitle'] = this.winnerTitle.map((v) => v.toJson()).toList();
//     }
//     if (this.challenges != null) {
//       data['challenges'] = this.challenges.map((v) => v.toJson()).toList();
//     }
//     data['followStatus'] = this.followStatus;
//     data['likeStatus'] = this.likeStatus;
//     if (this.media != null) {
//       data['media'] = this.media.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class UserData {
  String? sId;
  String? name;
  String? type;
  String? username;
  String? dob;
  String? bio;
  String? profession;
  String? profileImage;

  UserData({this.sId, this.name, this.type, this.username, this.dob, this.bio, this.profession, this.profileImage});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    username = json['username'];
    dob = json['dob'];
    bio = json['bio'];
    profession = json['profession'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['username'] = this.username;
    data['dob'] = this.dob;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class WinnerTitle {
  String? sId;
  String? name;
  int? likesCount;

  WinnerTitle({this.sId, this.name, this.likesCount});

  WinnerTitle.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    likesCount = json['likesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['likesCount'] = this.likesCount;
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

// class Media {
//   String path;
//   String type;
//
//   Media({this.path, this.type});
//
//   Media.fromJson(Map<String, dynamic> json) {
//     path = json['path'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['path'] = this.path;
//     data['type'] = this.type;
//     return data;
//   }
// }

class Winner {
  String? sId;
  String? name;
  String? type;
  String? country;
  String? profileImage;
  int? likes1Count;
  int? likes2Count;
  int? likesCount;
  int? totalHearts;
  int? position;

  Winner({this.sId, this.name, this.type, this.country, this.profileImage, this.likes1Count, this.likes2Count, this.likesCount, this.totalHearts, this.position});

  Winner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    country = json['country'];
    profileImage = json['profileImage'];
    likes1Count = json['likes1Count'];
    likes2Count = json['likes2Count'];
    likesCount = json['likesCount'];
    totalHearts = json['totalHearts'];
    position = json['Position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['country'] = this.country;
    data['profileImage'] = this.profileImage;
    data['likes1Count'] = this.likes1Count;
    data['likes2Count'] = this.likes2Count;
    data['likesCount'] = this.likesCount;
    data['totalHearts'] = this.totalHearts;
    data['Position'] = this.position;
    return data;
  }
}
class OpenChallengesResponseResultPosts {


  String? Id;
  String? description;
  String? district;
  String? state;
  String? country;
  int? likes0Count;
  int? likes1Count;
  int? likes2Count;
  int? commentsCount;
  String? createdAt;
  String? updatedAt;
  OpenChallengesResponseResultPostsUser? user;
  List<OpenChallengesResponseResultPostsWinnerTitle?>? winnerTitle;
  List<OpenChallengesResponseResultPostsChallenges?>? challenges;
  String? followStatus;
  String? likeStatus;
  List<OpenChallengesResponseResultPostsMedia?>? media;

  OpenChallengesResponseResultPosts({
    this.Id,
    this.description,
    this.district,
    this.state,
    this.country,
    this.likes0Count,
    this.likes1Count,
    this.likes2Count,
    this.commentsCount,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.winnerTitle,
    this.challenges,
    this.followStatus,
    this.likeStatus,
    this.media,
  });
  OpenChallengesResponseResultPosts.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    description = json['description']?.toString();
    district = json['district']?.toString();
    state = json['state']?.toString();
    country = json['country']?.toString();
    likes0Count = json['likes0Count']?.toInt();
    likes1Count = json['likes1Count']?.toInt();
    likes2Count = json['likes2Count']?.toInt();
    commentsCount = json['commentsCount']?.toInt();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    user = (json['user'] != null) ? OpenChallengesResponseResultPostsUser.fromJson(json['user']) : null;
    if (json['winnerTitle'] != null) {
      final v = json['winnerTitle'];
      final arr0 = <OpenChallengesResponseResultPostsWinnerTitle>[];
      v.forEach((v) {
        arr0.add(OpenChallengesResponseResultPostsWinnerTitle.fromJson(v));
      });
      winnerTitle = arr0;
    }
    if (json['challenges'] != null) {
      final v = json['challenges'];
      final arr0 = <OpenChallengesResponseResultPostsChallenges>[];
      v.forEach((v) {
        arr0.add(OpenChallengesResponseResultPostsChallenges.fromJson(v));
      });
      challenges = arr0;
    }
    followStatus = json['followStatus']?.toString();
    likeStatus = json['likeStatus']?.toString();
    if (json['media'] != null) {
      final v = json['media'];
      final arr0 = <OpenChallengesResponseResultPostsMedia>[];
      v.forEach((v) {
        arr0.add(OpenChallengesResponseResultPostsMedia.fromJson(v));
      });
      media = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['description'] = description;
    data['district'] = district;
    data['state'] = state;
    data['country'] = country;
    data['likes0Count'] = likes0Count;
    data['likes1Count'] = likes1Count;
    data['likes2Count'] = likes2Count;
    data['commentsCount'] = commentsCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (winnerTitle != null) {
      final v = winnerTitle;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['winnerTitle'] = arr0;
    }
    if (challenges != null) {
      final v = challenges;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['challenges'] = arr0;
    }
    data['followStatus'] = followStatus;
    data['likeStatus'] = likeStatus;
    if (media != null) {
      final v = media;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['media'] = arr0;
    }
    return data;
  }
}
class OpenChallengesResponseResultPostsUser {
/*
{
  "_id": "63fcc0d6dbc4fa3dbb872c8d",
  "name": "naznin",
  "type": "individual",
  "username": "naznin_27960845",
  "dob": "1993-09-10T00:00:00.000Z",
  "bio": "i am backend developer",
  "profession": "developer",
  "profileImage": "famelinks-75fdfee3-78a0-4300-a087-a678711fc0f8-xs",
  "profileImageType": "avatar"
}
*/

  String? Id;
  String? name;
  String? type;
  String? username;
  String? dob;
  String? bio;
  String? profession;
  String? profileImage;
  String? profileImageType;

  OpenChallengesResponseResultPostsUser({
    this.Id,
    this.name,
    this.type,
    this.username,
    this.dob,
    this.bio,
    this.profession,
    this.profileImage,
    this.profileImageType,
  });
  OpenChallengesResponseResultPostsUser.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    name = json['name']?.toString();
    type = json['type']?.toString();
    username = json['username']?.toString();
    dob = json['dob']?.toString();
    bio = json['bio']?.toString();
    profession = json['profession']?.toString();
    profileImage = json['profileImage']?.toString();
    profileImageType = json['profileImageType']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['name'] = name;
    data['type'] = type;
    data['username'] = username;
    data['dob'] = dob;
    data['bio'] = bio;
    data['profession'] = profession;
    data['profileImage'] = profileImage;
    data['profileImageType'] = profileImageType;
    return data;
  }
}
class OpenChallengesResponseResultPostsWinnerTitle {
/*
{
  "_id": "63fcc0d6dbc4fa3dbb872c80",
  "name": "naznin",
  "likesCount": 7
}
*/

  String? Id;
  String? name;
  int? likesCount;

  OpenChallengesResponseResultPostsWinnerTitle({
    this.Id,
    this.name,
    this.likesCount,
  });
  OpenChallengesResponseResultPostsWinnerTitle.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    name = json['name']?.toString();
    likesCount = json['likesCount']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['name'] = name;
    data['likesCount'] = likesCount;
    return data;
  }
}
class OpenChallengesResponseResultPostsChallenges {
/*
{
  "_id": "63da38dfbfe057aff8fde710",
  "hashTag": "glowingSkin"
}
*/

  String? Id;
  String? hashTag;

  OpenChallengesResponseResultPostsChallenges({
    this.Id,
    this.hashTag,
  });
  OpenChallengesResponseResultPostsChallenges.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    hashTag = json['hashTag']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['hashTag'] = hashTag;
    return data;
  }
}

class OpenChallengesResponsePostsChallenges {
/*
{
  "_id": "63da38dfbfe057aff8fde710",
  "hashTag": "glowingSkin"
}
*/

  String? Id;
  String? hashTag;

  OpenChallengesResponsePostsChallenges({
    this.Id,
    this.hashTag,
  });
  OpenChallengesResponsePostsChallenges.fromJson(Map<String, dynamic> json) {
    Id = json['_id']?.toString();
    hashTag = json['hashTag']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = Id;
    data['hashTag'] = hashTag;
    return data;
  }
}
class OpenChallengesResponseResultPostsMedia {
/*
{
  "path": "famelinks-7911887f-c74a-4bc0-8241-ed4dd645377d",
  "type": "closeUp"
}
*/

  String? path;
  String? type;

  OpenChallengesResponseResultPostsMedia({
    this.path,
    this.type,
  });
  OpenChallengesResponseResultPostsMedia.fromJson(Map<String, dynamic> json) {
    path = json['path']?.toString();
    type = json['type']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['path'] = path;
    data['type'] = type;
    return data;
  }
}