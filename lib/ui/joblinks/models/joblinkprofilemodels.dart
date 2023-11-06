/// result : [{"_id":"643e3bbbfc54e8539f849ac5","name":"","bio":"","profession":"","profileImage":"famelinks-7b05e1b6-53e8-4498-bea4-45979363f974","profileImageType":"image","greetText":"","greetVideo":"","masterUser":{"_id":"643e3bbbfc54e8539f849acc","district":"varanasi","state":"uttar pradesh","country":"uttar pradesh","continent":"asia","profileImage":"famelinks-cc776509-f0c5-42f2-9499-c8fce58a9586-xs","profileImageType":"image","fameCoins":20,"username":"@amar"},"faces":{"interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"pune","state":"maharashtra","country":"india"}],"interestCat":[{"jobName":"Photo Shoots","jobCategory":["Print Ad Shoot, Digital Media, Corporator"]},{"jobName":"Video Shoots","jobCategory":["Ad Shoot, Song Shoot, Short Films, Documentary Shoot"]}],"height":{"foot":5,"inch":4},"weight":45,"bust":33,"waist":35,"hip":31,"eyeColor":"brown","complexion":"fair"},"crew":{"experienceLevel":"experienced","workExperience":"2 years","achievements":"achieve two awards in developement","interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"thane","state":"maharashtra","country":"india"}],"interestCat":[{"jobName":"Makeup","jobCategory":null},{"jobName":"Hair Stylist","jobCategory":null}]},"posts":[{"_id":"64804cf3a9af92feb067323f","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-6d2346b2-9005-40bd-8535-9fbcc09ad31c"},{"_id":"6471ab6a151f9aafcb42db32","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-193a0f9e-6947-451b-994a-42eee53db863"},{"_id":"6476c2f471fffa80221a81d3","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-ac529873-edff-4241-9be5-71e59308838f"},{"_id":"647eefc9a9af92feb066e977","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-65ee4b01-153e-414e-a342-fd90a3ff6943"},{"_id":"6455f0ac2a5ae28d349a706f","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-d4d24c1b-7d01-4095-91b2-3f139a2cc98c"},{"_id":"6455f2072a5ae28d349a7187","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-5e9c8d2b-737d-470c-bd13-de9f72a55eb9"}],"hired":0,"shortlisted":0,"applied":0,"chats":0,"unreadChats":0,"saved":0,"chatId":"6458eccc2a5ae28d349aa3c3"}]
/// message : "joblinks user profile fetched"
/// success : true

class Joblinkprofilemodels {
  Joblinkprofilemodels({
    this.result,
    this.message,
    this.success,
  });

  Joblinkprofilemodels.fromJson(dynamic json) {
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }
  List<Result>? result;
  String? message;
  bool? success;
  Joblinkprofilemodels copyWith({
    List<Result>? result,
    String? message,
    bool? success,
  }) =>
      Joblinkprofilemodels(
        result: result ?? this.result,
        message: message ?? this.message,
        success: success ?? this.success,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['success'] = success;
    return map;
  }
}

/// _id : "643e3bbbfc54e8539f849ac5"
/// name : ""
/// bio : ""
/// profession : ""
/// profileImage : "famelinks-7b05e1b6-53e8-4498-bea4-45979363f974"
/// profileImageType : "image"
/// greetText : ""
/// greetVideo : ""
/// masterUser : {"_id":"643e3bbbfc54e8539f849acc","district":"varanasi","state":"uttar pradesh","country":"uttar pradesh","continent":"asia","profileImage":"famelinks-cc776509-f0c5-42f2-9499-c8fce58a9586-xs","profileImageType":"image","fameCoins":20,"username":"@amar"}
/// faces : {"interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"pune","state":"maharashtra","country":"india"}],"interestCat":[{"jobName":"Photo Shoots","jobCategory":["Print Ad Shoot, Digital Media, Corporator"]},{"jobName":"Video Shoots","jobCategory":["Ad Shoot, Song Shoot, Short Films, Documentary Shoot"]}],"height":{"foot":5,"inch":4},"weight":45,"bust":33,"waist":35,"hip":31,"eyeColor":"brown","complexion":"fair"}
/// crew : {"experienceLevel":"experienced","workExperience":"2 years","achievements":"achieve two awards in developement","interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"thane","state":"maharashtra","country":"india"}],"interestCat":[{"jobName":"Makeup","jobCategory":null},{"jobName":"Hair Stylist","jobCategory":null}]}
/// posts : [{"_id":"64804cf3a9af92feb067323f","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-6d2346b2-9005-40bd-8535-9fbcc09ad31c"},{"_id":"6471ab6a151f9aafcb42db32","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-193a0f9e-6947-451b-994a-42eee53db863"},{"_id":"6476c2f471fffa80221a81d3","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-ac529873-edff-4241-9be5-71e59308838f"},{"_id":"647eefc9a9af92feb066e977","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-65ee4b01-153e-414e-a342-fd90a3ff6943"},{"_id":"6455f0ac2a5ae28d349a706f","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-d4d24c1b-7d01-4095-91b2-3f139a2cc98c"},{"_id":"6455f2072a5ae28d349a7187","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-5e9c8d2b-737d-470c-bd13-de9f72a55eb9"}]
/// hired : 0
/// shortlisted : 0
/// applied : 0
/// chats : 0
/// unreadChats : 0
/// saved : 0
/// chatId : "6458eccc2a5ae28d349aa3c3"

class Result {
  Result({
    this.id,
    this.name,
    this.bio,
    this.profession,
    this.profileImage,
    this.profileImageType,
    this.greetText,
    this.greetVideo,
    this.masterUser,
    this.faces,
    this.crew,
    this.posts,
    this.hired,
    this.shortlisted,
    this.applied,
    this.chats,
    this.unreadChats,
    this.saved,
    this.chatId,
  });

  Result.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    bio = json['bio'];
    profession = json['profession'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    greetText = json['greetText'];
    greetVideo = json['greetVideo'];
    masterUser = json['masterUser'] != null
        ? MasterUser.fromJson(json['masterUser'])
        : null;
    faces = json['faces'] != null ? Faces.fromJson(json['faces']) : null;
    crew = json['crew'] != null ? Crew.fromJson(json['crew']) : null;
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
    hired = json['hired'];
    shortlisted = json['shortlisted'];
    applied = json['applied'];
    chats = json['chats'];
    unreadChats = json['unreadChats'];
    saved = json['saved'];
    chatId = json['chatId'];
  }
  String? id;
  String? name;
  String? bio;
  String? profession;
  String? profileImage;
  String? profileImageType;
  String? greetText;
  String? greetVideo;
  MasterUser? masterUser;
  Faces? faces;
  Crew? crew;
  List<Posts>? posts;
  num? hired;
  num? shortlisted;
  num? applied;
  num? chats;
  num? unreadChats;
  num? saved;
  String? chatId;
  Result copyWith({
    String? id,
    String? name,
    String? bio,
    String? profession,
    String? profileImage,
    String? profileImageType,
    String? greetText,
    String? greetVideo,
    MasterUser? masterUser,
    Faces? faces,
    Crew? crew,
    List<Posts>? posts,
    num? hired,
    num? shortlisted,
    num? applied,
    num? chats,
    num? unreadChats,
    num? saved,
    String? chatId,
  }) =>
      Result(
        id: id ?? this.id,
        name: name ?? this.name,
        bio: bio ?? this.bio,
        profession: profession ?? this.profession,
        profileImage: profileImage ?? this.profileImage,
        profileImageType: profileImageType ?? this.profileImageType,
        greetText: greetText ?? this.greetText,
        greetVideo: greetVideo ?? this.greetVideo,
        masterUser: masterUser ?? this.masterUser,
        faces: faces ?? this.faces,
        crew: crew ?? this.crew,
        posts: posts ?? this.posts,
        hired: hired ?? this.hired,
        shortlisted: shortlisted ?? this.shortlisted,
        applied: applied ?? this.applied,
        chats: chats ?? this.chats,
        unreadChats: unreadChats ?? this.unreadChats,
        saved: saved ?? this.saved,
        chatId: chatId ?? this.chatId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['bio'] = bio;
    map['profession'] = profession;
    map['profileImage'] = profileImage;
    map['profileImageType'] = profileImageType;
    map['greetText'] = greetText;
    map['greetVideo'] = greetVideo;
    if (masterUser != null) {
      map['masterUser'] = masterUser?.toJson();
    }
    if (faces != null) {
      map['faces'] = faces?.toJson();
    }
    if (crew != null) {
      map['crew'] = crew?.toJson();
    }
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    map['hired'] = hired;
    map['shortlisted'] = shortlisted;
    map['applied'] = applied;
    map['chats'] = chats;
    map['unreadChats'] = unreadChats;
    map['saved'] = saved;
    map['chatId'] = chatId;
    return map;
  }
}

/// _id : "64804cf3a9af92feb067323f"
/// closeUp : null
/// medium : null
/// long : null
/// pose1 : null
/// pose2 : null
/// additional : null
/// video : "famelinks-6d2346b2-9005-40bd-8535-9fbcc09ad31c"

class Posts {
  Posts({
    this.id,
    this.closeUp,
    this.medium,
    this.long,
    this.pose1,
    this.pose2,
    this.additional,
    this.video,
  });

  Posts.fromJson(dynamic json) {
    id = json['_id'];
    closeUp = json['closeUp'];
    medium = json['medium'];
    long = json['long'];
    pose1 = json['pose1'];
    pose2 = json['pose2'];
    additional = json['additional'];
    video = json['video'];
  }
  String? id;
  dynamic closeUp;
  dynamic medium;
  dynamic long;
  dynamic pose1;
  dynamic pose2;
  dynamic additional;
  String? video;
  Posts copyWith({
    String? id,
    dynamic closeUp,
    dynamic medium,
    dynamic long,
    dynamic pose1,
    dynamic pose2,
    dynamic additional,
    String? video,
  }) =>
      Posts(
        id: id ?? this.id,
        closeUp: closeUp ?? this.closeUp,
        medium: medium ?? this.medium,
        long: long ?? this.long,
        pose1: pose1 ?? this.pose1,
        pose2: pose2 ?? this.pose2,
        additional: additional ?? this.additional,
        video: video ?? this.video,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['closeUp'] = closeUp;
    map['medium'] = medium;
    map['long'] = long;
    map['pose1'] = pose1;
    map['pose2'] = pose2;
    map['additional'] = additional;
    map['video'] = video;
    return map;
  }
}

/// experienceLevel : "experienced"
/// workExperience : "2 years"
/// achievements : "achieve two awards in developement"
/// interestedLoc : [{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"thane","state":"maharashtra","country":"india"}]
/// interestCat : [{"jobName":"Makeup","jobCategory":null},{"jobName":"Hair Stylist","jobCategory":null}]

class Crew {
  Crew({
    this.experienceLevel,
    this.workExperience,
    this.achievements,
    this.interestedLoc,
    this.interestCat,
  });

  Crew.fromJson(dynamic json) {
    experienceLevel = json['experienceLevel'];
    workExperience = json['workExperience'];
    achievements = json['achievements'];
    if (json['interestedLoc'] != null) {
      interestedLoc = [];
      json['interestedLoc'].forEach((v) {
        interestedLoc?.add(InterestedLoc.fromJson(v));
      });
    }
    if (json['interestCat'] != null) {
      interestCat = [];
      json['interestCat'].forEach((v) {
        interestCat?.add(InterestCat.fromJson(v));
      });
    }
  }
  String? experienceLevel;
  String? workExperience;
  String? achievements;
  List<InterestedLoc>? interestedLoc;
  List<InterestCat>? interestCat;
  Crew copyWith({
    String? experienceLevel,
    String? workExperience,
    String? achievements,
    List<InterestedLoc>? interestedLoc,
    List<InterestCat>? interestCat,
  }) =>
      Crew(
        experienceLevel: experienceLevel ?? this.experienceLevel,
        workExperience: workExperience ?? this.workExperience,
        achievements: achievements ?? this.achievements,
        interestedLoc: interestedLoc ?? this.interestedLoc,
        interestCat: interestCat ?? this.interestCat,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['experienceLevel'] = experienceLevel;
    map['workExperience'] = workExperience;
    map['achievements'] = achievements;
    if (interestedLoc != null) {
      map['interestedLoc'] = interestedLoc?.map((v) => v.toJson()).toList();
    }
    if (interestCat != null) {
      map['interestCat'] = interestCat?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// jobName : "Makeup"
/// jobCategory : null

class InterestCat {
  InterestCat({
    this.jobName,
    this.id,
    this.jobCategory,
  });

  InterestCat.fromJson(dynamic json) {
    jobName = json['jobName'];
    id = json['_id'];
    jobCategory = json['jobCategory'];
  }
  String? jobName;
  String? id;
  dynamic jobCategory;
  InterestCat copyWith({
    String? jobName,
    dynamic jobCategory,
  }) =>
      InterestCat(
        jobName: jobName ?? this.jobName,
        id: id ?? this.id,
        jobCategory: jobCategory ?? this.jobCategory,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jobName'] = jobName;
    map['id'] = id;
    map['jobCategory'] = jobCategory;
    return map;
  }
}

/// district : "mumbai"
/// state : "maharashtra"
/// country : "india"

class InterestedLoc {
  InterestedLoc({
    this.district,
    this.state,
    this.country,
  });

  InterestedLoc.fromJson(dynamic json) {
    district = json['district'];
    state = json['state'];
    country = json['country'];
  }
  String? district;
  String? state;
  String? country;
  InterestedLoc copyWith({
    String? district,
    String? state,
    String? country,
  }) =>
      InterestedLoc(
        district: district ?? this.district,
        state: state ?? this.state,
        country: country ?? this.country,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = district;
    map['state'] = state;
    map['country'] = country;
    return map;
  }
}

/// interestedLoc : [{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"pune","state":"maharashtra","country":"india"}]
/// interestCat : [{"jobName":"Photo Shoots","jobCategory":["Print Ad Shoot, Digital Media, Corporator"]},{"jobName":"Video Shoots","jobCategory":["Ad Shoot, Song Shoot, Short Films, Documentary Shoot"]}]
/// height : {"foot":5,"inch":4}
/// weight : 45
/// bust : 33
/// waist : 35
/// hip : 31
/// eyeColor : "brown"
/// complexion : "fair"

class Faces {
  Faces({
    this.interestedLoc,
    this.interestCat,
    this.height,
    this.weight,
    this.bust,
    this.waist,
    this.hip,
    this.eyeColor,
    this.complexion,
  });

  Faces.fromJson(dynamic json) {
    if (json['interestedLoc'] != null) {
      interestedLoc = [];
      json['interestedLoc'].forEach((v) {
        interestedLoc?.add(InterestedLoc.fromJson(v));
      });
    }
    if (json['interestCat'] != null) {
      interestCat = [];
      json['interestCat'].forEach((v) {
        interestCat?.add(InterestCat.fromJson(v));
      });
    }
    height = json['height'] != null ? Height.fromJson(json['height']) : null;
    weight = json['weight'];
    bust = json['bust'];
    waist = json['waist'];
    hip = json['hip'];
    eyeColor = json['eyeColor'];
    complexion = json['complexion'];
  }
  List<InterestedLoc>? interestedLoc;
  List<InterestCat>? interestCat;
  Height? height;
  num? weight;
  num? bust;
  num? waist;
  num? hip;
  String? eyeColor;
  String? complexion;
  Faces copyWith({
    List<InterestedLoc>? interestedLoc,
    List<InterestCat>? interestCat,
    Height? height,
    num? weight,
    num? bust,
    num? waist,
    num? hip,
    String? eyeColor,
    String? complexion,
  }) =>
      Faces(
        interestedLoc: interestedLoc ?? this.interestedLoc,
        interestCat: interestCat ?? this.interestCat,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        bust: bust ?? this.bust,
        waist: waist ?? this.waist,
        hip: hip ?? this.hip,
        eyeColor: eyeColor ?? this.eyeColor,
        complexion: complexion ?? this.complexion,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (interestedLoc != null) {
      map['interestedLoc'] = interestedLoc?.map((v) => v.toJson()).toList();
    }
    if (interestCat != null) {
      map['interestCat'] = interestCat?.map((v) => v.toJson()).toList();
    }
    if (height != null) {
      map['height'] = height?.toJson();
    }
    map['weight'] = weight;
    map['bust'] = bust;
    map['waist'] = waist;
    map['hip'] = hip;
    map['eyeColor'] = eyeColor;
    map['complexion'] = complexion;
    return map;
  }
}

/// foot : 5
/// inch : 4

class Height {
  Height({
    this.foot,
    this.inch,
  });

  Height.fromJson(dynamic json) {
    foot = json['foot'];
    inch = json['inch'];
  }
  num? foot;
  num? inch;
  Height copyWith({
    num? foot,
    num? inch,
  }) =>
      Height(
        foot: foot ?? this.foot,
        inch: inch ?? this.inch,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foot'] = foot;
    map['inch'] = inch;
    return map;
  }
}

/// jobName : "Photo Shoots"
/// jobCategory : ["Print Ad Shoot, Digital Media, Corporator"]

class InterestCats {
  InterestCats({
    this.jobName,
    this.id,
    this.jobCategory,
  });

  InterestCats.fromJson(dynamic json) {
    jobName = json['jobName'];
    id = json['id'];
    jobCategory =
        json['jobCategory'] != null ? json['jobCategory'].cast<String>() : [];
  }
  String? jobName;
  String? id;
  List<String>? jobCategory;
  InterestCat copyWith({
    String? jobName,
    String? id,
    List<String>? jobCategory,
  }) =>
      InterestCat(
        jobName: jobName ?? this.jobName,
        id: id ?? this.id,
        jobCategory: jobCategory ?? this.jobCategory,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jobName'] = jobName;
    map['_id'] = id;
    map['jobCategory'] = jobCategory;
    return map;
  }
}

/// district : "mumbai"
/// state : "maharashtra"
/// country : "india"

class InterestedLocs {
  InterestedLocs({
    this.district,
    this.state,
    this.country,
  });

  InterestedLocs.fromJson(dynamic json) {
    district = json['district'];
    state = json['state'];
    country = json['country'];
  }
  String? district;
  String? state;
  String? country;
  InterestedLoc copyWith({
    String? district,
    String? state,
    String? country,
  }) =>
      InterestedLoc(
        district: district ?? this.district,
        state: state ?? this.state,
        country: country ?? this.country,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['district'] = district;
    map['state'] = state;
    map['country'] = country;
    return map;
  }
}

/// _id : "643e3bbbfc54e8539f849acc"
/// district : "varanasi"
/// state : "uttar pradesh"
/// country : "uttar pradesh"
/// continent : "asia"
/// profileImage : "famelinks-cc776509-f0c5-42f2-9499-c8fce58a9586-xs"
/// profileImageType : "image"
/// fameCoins : 20
/// username : "@amar"

class MasterUser {
  MasterUser({
    this.id,
    this.district,
    this.state,
    this.dob,
    this.country,
    this.continent,
    this.profileImage,
    this.profileImageType,
    this.fameCoins,
    this.username,
  });

  MasterUser.fromJson(dynamic json) {
    id = json['_id'];
    district = json['district'];
    state = json['state'];
    dob = json['dob'];
    country = json['country'];
    continent = json['continent'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    fameCoins = json['fameCoins'];
    username = json['username'];
  }
  String? id;
  String? district;
  String? state;
  String? dob;
  String? country;
  String? continent;
  String? profileImage;
  String? profileImageType;
  num? fameCoins;
  String? username;
  MasterUser copyWith({
    String? id,
    String? district,
    String? state,
    String? country,
    String? continent,
    String? profileImage,
    String? profileImageType,
    num? fameCoins,
    String? username,
  }) =>
      MasterUser(
        id: id ?? this.id,
        district: district ?? this.district,
        state: state ?? this.state,
        dob: dob ?? this.dob,
        country: country ?? this.country,
        continent: continent ?? this.continent,
        profileImage: profileImage ?? this.profileImage,
        profileImageType: profileImageType ?? this.profileImageType,
        fameCoins: fameCoins ?? this.fameCoins,
        username: username ?? this.username,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['district'] = district;
    map['state'] = state;
    map['dob'] = dob;
    map['country'] = country;
    map['continent'] = continent;
    map['profileImage'] = profileImage;
    map['profileImageType'] = profileImageType;
    map['fameCoins'] = fameCoins;
    map['username'] = username;
    return map;
  }
}
