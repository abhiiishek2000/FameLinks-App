/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

OpenChallengesResponse openChallengesResponseFromJson(String str) => OpenChallengesResponse.fromJson(json.decode(str));

String openChallengesResponseToJson(OpenChallengesResponse data) => json.encode(data.toJson());

class OpenChallengesResponse {
    OpenChallengesResponse({
        required this.result,
        required this.success,
        required this.message,
    });

    List<Result> result;
    bool success;
    String message;

    factory OpenChallengesResponse.fromJson(Map<dynamic, dynamic> json) => OpenChallengesResponse(
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        success: json["success"],
        message: json["message"],
    );

    Map<dynamic, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "success": success,
        "message": message,
    };
}

class Result {
    Result({
        required this.totalPost,
        required this.createdAt,
        required this.participantsCount,
        required this.isDeleted,
        required this.createdBy,
        required this.id,
        required this.totalImpressions,
        required this.totalParticipants,
        required this.type,
        required this.posts,
        required this.hashTag,
        required this.updatedAt,
    });

    int totalPost;
    DateTime createdAt;
    int participantsCount;
    bool isDeleted;
    List<CreatedBy> createdBy;
    String id;
    int totalImpressions;
    int totalParticipants;
    ResultType type;
    List<Post> posts;
    String hashTag;
    DateTime updatedAt;

    factory Result.fromJson(Map<dynamic, dynamic> json) => Result(
        totalPost: json["totalPost"],
        createdAt: DateTime.parse(json["createdAt"]),
        participantsCount: json["participantsCount"],
        isDeleted: json["isDeleted"],
        createdBy: List<CreatedBy>.from(json["createdBy"].map((x) => CreatedBy.fromJson(x))),
        id: json["_id"],
        totalImpressions: json["totalImpressions"],
        totalParticipants: json["totalParticipants"],
        type: resultTypeValues.map[json["type"]]!,
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        hashTag: json["hashTag"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "totalPost": totalPost,
        "createdAt": createdAt.toIso8601String(),
        "participantsCount": participantsCount,
        "isDeleted": isDeleted,
        "createdBy": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "_id": id,
        "totalImpressions": totalImpressions,
        "totalParticipants": totalParticipants,
        "type": resultTypeValues.reverse[type],
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "hashTag": hashTag,
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class CreatedBy {
    CreatedBy({
        required this.name,
        required this.id,
    });

    Name name;
    String id;

    factory CreatedBy.fromJson(Map<dynamic, dynamic> json) => CreatedBy(
        name: nameValues.map[json["name"]]!,
        id: json["_id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "_id": id,
    };
}

enum Name { GLOU, KALYAN_FUN, NAZNIN_FUNLINKS }

final nameValues = EnumValues({
    "glou": Name.GLOU,
    "Kalyan Fun": Name.KALYAN_FUN,
    "naznin funlinks": Name.NAZNIN_FUNLINKS
});

class Post {
    Post({
        required this.country,
        required this.challenges,
        required this.followStatus,
        required this.description,
        required this.media,
        required this.musicName,
        required this.tags,
        required this.likesCount,
        required this.createdAt,
        required this.commentsCount,
        required this.district,
        required this.id,
        required this.state,
        required this.user,
        required this.updatedAt,
        this.musicId,
        this.likeStatus,
    });

    Country country;
    List<Challenge> challenges;
    FollowStatus followStatus;
    String description;
    List<Media> media;
    MusicName musicName;
    List<Tag> tags;
    int likesCount;
    DateTime createdAt;
    int commentsCount;
    String district;
    String id;
    Country state;
    User user;
    DateTime updatedAt;
    String? musicId;
    int? likeStatus;

    factory Post.fromJson(Map<dynamic, dynamic> json) => Post(
        country: countryValues.map[json["country"]]!,
        challenges: List<Challenge>.from(json["challenges"].map((x) => Challenge.fromJson(x))),
        followStatus: followStatusValues.map[json["followStatus"]]!,
        description: json["description"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        musicName: musicNameValues.map[json["musicName"]]!,
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        likesCount: json["likesCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        commentsCount: json["commentsCount"],
        district: json["district"],
        id: json["_id"],
        state: countryValues.map[json["state"]]!,
        user: User.fromJson(json["user"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        musicId: json["musicId"],
        likeStatus: json["likeStatus"],
    );

    Map<dynamic, dynamic> toJson() => {
        "country": countryValues.reverse[country],
        "challenges": List<dynamic>.from(challenges.map((x) => x.toJson())),
        "followStatus": followStatusValues.reverse[followStatus],
        "description": description,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "musicName": musicNameValues.reverse[musicName],
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "likesCount": likesCount,
        "createdAt": createdAt.toIso8601String(),
        "commentsCount": commentsCount,
        "district": district,
        "_id": id,
        "state": countryValues.reverse[state],
        "user": user.toJson(),
        "updatedAt": updatedAt.toIso8601String(),
        "musicId": musicId,
        "likeStatus": likeStatus,
    };
}

class Challenge {
    Challenge({
        required this.id,
        required this.hashTag,
    });

    String id;
    String hashTag;

    factory Challenge.fromJson(Map<dynamic, dynamic> json) => Challenge(
        id: json["_id"],
        hashTag: json["hashTag"],
    );

    Map<dynamic, dynamic> toJson() => {
        "_id": id,
        "hashTag": hashTag,
    };
}

enum Country { UTTAR_PRADESH, MAHARASHTRA, INDIA }

final countryValues = EnumValues({
    "india": Country.INDIA,
    "maharashtra": Country.MAHARASHTRA,
    "uttar pradesh": Country.UTTAR_PRADESH
});

enum FollowStatus { FOLLOW, FOLLOWING }

final followStatusValues = EnumValues({
    "Follow": FollowStatus.FOLLOW,
    "Following": FollowStatus.FOLLOWING
});

class Media {
    Media({
        required this.path,
        required this.type,
    });

    String path;
    MediaType type;

    factory Media.fromJson(Map<dynamic, dynamic> json) => Media(
        path: json["path"],
        type: mediaTypeValues.map[json["type"]]!,
    );

    Map<dynamic, dynamic> toJson() => {
        "path": path,
        "type": mediaTypeValues.reverse[type],
    };
}

enum MediaType { VIDEO }

final mediaTypeValues = EnumValues({
    "video": MediaType.VIDEO
});

enum MusicName { EMPTY, MY_MUSIC_TEST_AMAR }

final musicNameValues = EnumValues({
    "": MusicName.EMPTY,
    "my music test amar": MusicName.MY_MUSIC_TEST_AMAR
});

class Tag {
    Tag({
        required this.tagId,
        required this.accepted,
        required this.id,
    });

    String tagId;
    bool accepted;
    String id;

    factory Tag.fromJson(Map<dynamic, dynamic> json) => Tag(
        tagId: json["tagId"],
        accepted: json["accepted"],
        id: json["_id"],
    );

    Map<dynamic, dynamic> toJson() => {
        "tagId": tagId,
        "accepted": accepted,
        "_id": id,
    };
}

class User {
    User({
        this.profession,
        this.name,
        this.bio,
        required this.id,
        this.profileImage,
        required this.type,
        required this.profileImageType,
    });

    Profession? profession;
    Name? name;
    String? bio;
    String id;
    ProfileImage? profileImage;
    UserType type;
    ProfileImageType profileImageType;

    factory User.fromJson(Map<dynamic, dynamic> json) => User(
        profession: professionValues.map[json["profession"]]!,
        name: nameValues.map[json["name"]]!,
        bio: json["bio"],
        id: json["_id"],
        profileImage: profileImageValues.map[json["profileImage"]]!,
        type: userTypeValues.map[json["type"]]!,
        profileImageType: profileImageTypeValues.map[json["profileImageType"]]!,
    );

    Map<dynamic, dynamic> toJson() => {
        "profession": professionValues.reverse[profession],
        "name": nameValues.reverse[name],
        "bio": bio,
        "_id": id,
        "profileImage": profileImageValues.reverse[profileImage],
        "type": userTypeValues.reverse[type],
        "profileImageType": profileImageTypeValues.reverse[profileImageType],
    };
}

enum Profession { EMPTY, ACTOR, DEVELOPER }

final professionValues = EnumValues({
    "Actor": Profession.ACTOR,
    "developer": Profession.DEVELOPER,
    "": Profession.EMPTY
});

enum ProfileImage { FAMELINKS_864_F0_BD6_FD35_47_C4_96_D8_DF37_A6_C3719_E, FAMELINKS_21_BD74_B2_849741_DF_9_B89_2_FFC69_E8510_B, FAMELINKS_5981_FF8_F_7_CBE_47_A0_AF0_C_61_F29_EACA4_CC }

final profileImageValues = EnumValues({
    "famelinks-21bd74b2-8497-41df-9b89-2ffc69e8510b": ProfileImage.FAMELINKS_21_BD74_B2_849741_DF_9_B89_2_FFC69_E8510_B,
    "famelinks-5981ff8f-7cbe-47a0-af0c-61f29eaca4cc": ProfileImage.FAMELINKS_5981_FF8_F_7_CBE_47_A0_AF0_C_61_F29_EACA4_CC,
    "famelinks-864f0bd6-fd35-47c4-96d8-df37a6c3719e": ProfileImage.FAMELINKS_864_F0_BD6_FD35_47_C4_96_D8_DF37_A6_C3719_E
});

enum ProfileImageType { IMAGE, EMPTY, AVATAR }

final profileImageTypeValues = EnumValues({
    "avatar": ProfileImageType.AVATAR,
    "": ProfileImageType.EMPTY,
    "image": ProfileImageType.IMAGE
});

enum UserType { INDIVIDUAL }

final userTypeValues = EnumValues({
    "individual": UserType.INDIVIDUAL
});

enum ResultType { FUNLINKS }

final resultTypeValues = EnumValues({
    "funlinks": ResultType.FUNLINKS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
