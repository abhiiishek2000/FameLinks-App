class StoreModel {
  List<Store>? result;
  String? message;
  bool? success;

  StoreModel({this.result, this.message, this.success});

  StoreModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <Store>[];
      json['result'].forEach((v) {
        result!.add(new Store.fromJson(v));
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

class Store {
  String? sId;
  List<Media>? images;
  String? description;
  String? district;
  String? state;
  String? country;
  String? purchaseUrl;
  String? buttonName;
  String? name;
  dynamic hashTag;
  int? price;
  int? commentsCount;
  String? createdAt;
  String? updatedAt;
  List<User>? user;

  Store(
      {this.sId,
      this.images,
      this.description,
      this.district,
      this.state,
      this.country,
      this.purchaseUrl,
      this.buttonName,
      this.name,
      this.hashTag,
      this.price,
      this.commentsCount,
      this.createdAt,
      this.updatedAt,
      this.user});

  Store.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['media'] != null) {
      images = <Media>[];
      json['media'].forEach((v) {
        images!.add(new Media.fromJson(v));
      });
    }
    description = json['description'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    purchaseUrl = json['purchaseUrl'];
    buttonName = json['buttonName'];
    name = json['name'];
    hashTag = json['hashTag'];
    price = json['price'];
    commentsCount = json['commentsCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.images != null) {
      data['media'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['purchaseUrl'] = this.purchaseUrl;
    data['buttonName'] = this.buttonName;
    data['name'] = this.name;
    data['hashTag'] = this.hashTag;
    data['price'] = this.price;
    data['commentsCount'] = this.commentsCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
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

class User {
  String? sId;
  String? name;
  String? type;
  String? username;
  String? dob;
  String? bio;
  String? profession;
  String? profileImage;
  String? profileImageType;

  User(
      {this.sId,
      this.name,
      this.type,
      this.username,
      this.dob,
      this.bio,
      this.profession,
      this.profileImage,
      this.profileImageType});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    username = json['username'];
    dob = json['dob'];
    bio = json['bio'];
    profession = json['profession'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
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
    data['profileImageType'] = this.profileImageType;
    return data;
  }
}
