class ChallengesModel {
  List<Challenge>? result;
  String? message;
  bool? success;

  ChallengesModel({this.result, this.message, this.success});

  ChallengesModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Challenge>[];
      json['result'].forEach((v) {
        result!.add(new Challenge.fromJson(v));
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

class Challenge {
  String? sId;
  String? description;
  String? district;
  String? state;
  String? country;
  String? video;
  int? commentsCount;
  String? createdAt;
  String? updatedAt;
  int? likesCount;
  List<Media>? media;

  Challenge(
      {this.sId,
        this.description,
        this.district,
        this.state,
        this.country,
        this.video,
        this.commentsCount,
        this.createdAt,
        this.updatedAt,
        this.likesCount,
        this.media});

  Challenge.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    video = json['video'] != null ?json['video'] :'';
    commentsCount = json['commentsCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    likesCount = json['likesCount'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['video'] = this.video;
    data['commentsCount'] = this.commentsCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['likesCount'] = this.likesCount;
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Media {
  String?  path;
  String? type;

  Media(
      {this.path,
        this.type});

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
