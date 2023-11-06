class StoreProfile {
  List<StoreM>? result;
  String? message;
  bool? success;

  StoreProfile({this.result, this.message, this.success});

  StoreProfile.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <StoreM>[];
      json['result'].forEach((v) {
        result!.add(new StoreM.fromJson(v));
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

class StoreM {
  String? sId;
  String? name;
  String? bio;
  String? profileImage;
  List<Null>? restrictedList;
  bool? isRegistered;
  bool? isBlocked;
  bool? isDeleted;
  String? url;
  List<String>? bannerMedia;
  String? profileImageType;
  MasterUser? masterUser;
  List<Products>? products;
  List<Null>? trendzsSponsored;
  String? followStatus;
  List<String>? visits;
  List<Null>? urlVisits;
  String? chatId;

  StoreM(
      {this.sId,
      this.name,
      this.bio,
      this.profileImage,
      this.restrictedList,
      this.isRegistered,
      this.isBlocked,
      this.isDeleted,
      this.url,
      this.bannerMedia,
      this.profileImageType,
      this.masterUser,
      this.products,
      this.trendzsSponsored,
      this.followStatus,
      this.visits,
      this.urlVisits,
      this.chatId});

  StoreM.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    profileImage = json['profileImage'];
    // if (json['restrictedList'] != null) {
    //   restrictedList = <Null>[];
    //   json['restrictedList'].forEach((v) {
    //     restrictedList.add(new Null.fromJson(v));
    //   });
    // }
    isRegistered = json['isRegistered'];
    isBlocked = json['isBlocked'];
    isDeleted = json['isDeleted'];
    url = json['url'];
    bannerMedia = json['bannerMedia'].cast<String>();
    profileImageType = json['profileImageType'];
    masterUser = json['masterUser'] != null
        ? new MasterUser.fromJson(json['masterUser'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    // if (json['trendzsSponsored'] != null) {
    //   trendzsSponsored = <Null>[];
    //   json['trendzsSponsored'].forEach((v) {
    //     trendzsSponsored.add(new Null.fromJson(v));
    //   });
    // }
    // followStatus = json['followStatus'];
    // if (json['visits'] != null) {
    //   visits = <Null>[];
    //   json['visits'].forEach((v) {
    //     visits.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['urlVisits'] != null) {
    //   urlVisits = <Null>[];
    //   json['urlVisits'].forEach((v) {
    //     urlVisits.add(new Null.fromJson(v));
    //   });
    // }
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['profileImage'] = this.profileImage;
    // if (this.restrictedList != null) {
    //   data['restrictedList'] =
    //       this.restrictedList.map((v) => v.toJson()).toList();
    // }
    data['isRegistered'] = this.isRegistered;
    data['isBlocked'] = this.isBlocked;
    data['isDeleted'] = this.isDeleted;
    data['url'] = this.url;
    data['bannerMedia'] = this.bannerMedia;
    data['profileImageType'] = this.profileImageType;
    if (this.masterUser != null) {
      data['masterUser'] = this.masterUser!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    // if (this.trendzsSponsored != null) {
    //   data['trendzsSponsored'] =
    //       this.trendzsSponsored.map((v) => v.toJson()).toList();
    // }
    // data['followStatus'] = this.followStatus;
    // if (this.visits != null) {
    //   data['visits'] = this.visits.map((v) => v.toJson()).toList();
    // }
    // if (this.urlVisits != null) {
    //   data['urlVisits'] = this.urlVisits.map((v) => v.toJson()).toList();
    // }
    data['chatId'] = this.chatId;
    return data;
  }
}

class MasterUser {
  String? sId;
  String? district;
  String? state;
  String? country;
  String? continent;
  String? profileImage;
  String? profileImageType;
  int? fameCoins;
  String? username;

  MasterUser(
      {this.sId,
      this.district,
      this.state,
      this.country,
      this.continent,
      this.profileImage,
      this.profileImageType,
      this.fameCoins,
      this.username});

  MasterUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    fameCoins = json['fameCoins'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['continent'] = this.continent;
    data['profileImage'] = this.profileImage;
    data['profileImageType'] = this.profileImageType;
    data['fameCoins'] = this.fameCoins;
    data['username'] = this.username;
    return data;
  }
}

class Products {
  String? sId;
  List<String>? media;

  Products({this.sId, this.media});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    media = json['media'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['media'] = this.media;
    return data;
  }
}
