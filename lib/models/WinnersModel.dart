import 'package:famelink/models/famelinks_model.dart';

class WinnersModel {
  List<WinnersResult>? result;
  String? message;
  bool? success;

  WinnersModel({this.result, this.message, this.success});

  WinnersModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <WinnersResult>[];
      json['result'].forEach((v) {
        result!.add(new WinnersResult.fromJson(v));
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

class WinnersResult {
  String? sId;
  String? name;
  String? description;
  String? reward;
  String? startDate;
  String? type;
  List<String>? forGender;
  List<String>? mediaPreference;
  String? updatedAt;
  int? requiredImpressions;
  int? totalImpressions;
  String? createdAt;
  String? endDate;
  List<String>? images;
  List<Winner>? winner;
  List<Result>? posts;
  List<Sponsor>? sponsor;
  int? participantsCount;

  WinnersResult(
      {this.sId,
      this.name,
      this.sponsor,
      this.description,
      this.reward,
      this.startDate,
      this.type,
      this.forGender,
      this.mediaPreference,
      this.updatedAt,
      this.requiredImpressions,
      this.totalImpressions,
      this.createdAt,
      this.endDate,
      this.images,
      this.posts,
      this.winner,
      this.participantsCount});

  WinnersResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    reward = json['reward'];
    startDate = json['startDate'];
    type = json['type'];
    forGender = json['for'].cast<String>();
    mediaPreference = json['mediaPreference'].cast<String>();
    updatedAt = json['updatedAt'];
    requiredImpressions = json['requiredImpressions'];
    totalImpressions = json['totalImpressions'];
    createdAt = json['createdAt'];
    endDate = json['endDate'];
    images = json['images'].cast<String>();
    if (json['winner'] != null) {
      winner = <Winner>[];
      json['winner'].forEach((v) {
        winner!.add(new Winner.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = <Result>[];
      json['posts'].forEach((v) {
        posts!.add(new Result.fromJson(v));
      });
    }
    if (json['sponsor'] != null) {
      sponsor = <Sponsor>[];
      json['sponsor'].forEach((v) {
        sponsor!.add(new Sponsor.fromJson(v));
      });
    }
    participantsCount = json['participantsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['reward'] = this.reward;
    data['startDate'] = this.startDate;
    data['type'] = this.type;
    data['for'] = this.forGender;
    data['mediaPreference'] = this.mediaPreference;
    data['updatedAt'] = this.updatedAt;
    data['requiredImpressions'] = this.requiredImpressions;
    data['totalImpressions'] = this.totalImpressions;
    data['createdAt'] = this.createdAt;
    data['endDate'] = this.endDate;
    data['images'] = this.images;
    if (this.winner != null) {
      data['winner'] = this.winner!.map((v) => v.toJson()).toList();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    if (this.sponsor != null) {
      data['sponsor'] = this.sponsor!.map((v) => v.toJson()).toList();
    }
    data['participantsCount'] = this.participantsCount;
    return data;
  }
}



class Winner {
  String? sId;
  String? name;
  String? type;
  String? country;
  String? profileImage;
  int? likesCount;

  Winner(
      {this.sId, this.name, this.country, this.profileImage, this.likesCount});

  Winner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    country = json['country'];
    profileImage = json['profileImage'];
    likesCount = json['likesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['country'] = this.country;
    data['profileImage'] = this.profileImage;
    data['likesCount'] = this.likesCount;
    return data;
  }
}
class Sponsor {
  String? name;
  String? id;

  Sponsor(
      {this.name,this.id});

  Sponsor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
