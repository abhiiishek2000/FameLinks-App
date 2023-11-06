class RecommendationModel {
  String? message;
  bool? success;
  List<RecommendationData>? data;

  RecommendationModel({this.message, this.success, this.data});

  RecommendationModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['result'] != null) {
      data = <RecommendationData>[];
      json['result'].forEach((v) {
        data!.add(new RecommendationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendationData {
  String? data;
  String? createdAt;
  String? updatedAt;
  User? user;

  RecommendationData({this.data, this.createdAt, this.updatedAt, this.user});

  RecommendationData.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? type;
  String? bio;
  String? profession;
  String? dob;
  String? profileImage;
  String? username;

  User(
      {this.sId,
        this.name,
        this.type,
        this.bio,
        this.profession,
        this.dob,
        this.profileImage,
        this.username});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name']??'';
    type = json['type']??'';
    bio = json['bio']??'';
    profession = json['profession']??'';
    dob = json['dob']??'';
    profileImage = json['profileImage']??'';
    username = json['username']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['bio'] = this.bio;
    data['profession'] = this.profession;
    data['dob'] = this.dob;
    data['profileImage'] = this.profileImage;
    data['username'] = this.username;
    return data;
  }
}
