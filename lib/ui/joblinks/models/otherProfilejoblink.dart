/// result : [{"_id":"63fcc0d6dbc4fa3dbb872c86","name":"naznin joblinks","bio":"","profession":"","profileImage":null,"profileImageType":"","greetText":"","greetVideo":"","profileFaces":[{"interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"}],"interestCat":[],"height":{"foot":5,"inch":4},"weight":45,"bust":33,"waist":35,"hip":31,"eyeColor":"brown","complexion":"fair"}],"profileCrew":[{"experienceLevel":"experienced","workExperience":"2 years","achievements":"achieve two awards in developement","interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"thane","state":"maharashtra","country":"india"}],"interestCat":[{"_id":"64a6466a4d602ad0089ee81c","jobName":"Photographer","jobCategory":null},{"_id":"64a648999039244005454f40","jobName":"Designer","jobCategory":null}]}],"masterUser":{"_id":"63fcc0d6dbc4fa3dbb872c8d","district":"akola","state":"maharashtra","country":"india","continent":"asia","dob":"1993-09-10T00:00:00.000Z","profileImage":"famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs","profileImageType":"image","fameCoins":10,"username":"naznin_27960845"},"ambassador":"","posts":[{"_id":"640b431d9f9151a8c50c1e3c","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-f50794fd-1f84-497f-afa9-a81639d85a1e"},{"_id":"63ff0b7debccee8e597dd149","closeUp":"famelinks-a1d43c86-3857-4ef4-8ad9-464be713fdb8","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"640042c6ebccee8e597defe7","closeUp":"famelinks-32713900-5672-48f2-9753-d25f904e34cd","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"64057736ebccee8e597e209c","closeUp":"famelinks-395a1354-bd11-48cc-ae8a-d0d042861238","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"63ff0048ebccee8e597dcc7d","closeUp":"famelinks-b9b215d4-5c23-4ebd-ba1f-ff140c409896","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"645611662a5ae28d349a7a5f","closeUp":"famelinks-8babc1ea-234e-4be5-b8fd-338f808caf67","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"6446680322f371817388640e","closeUp":"famelinks-f74e101f-554f-4562-a8bd-e85f1af75afd","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"64789b7271fffa80221aab3a","closeUp":"famelinks-27ca11ae-4a5f-40e2-a0c6-4dcaeb38abd2","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"640576e2ebccee8e597e2002","closeUp":"famelinks-3ccbd4ee-187e-4db0-b66c-b0d5987c392a","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"6401cd16ebccee8e597df9c7","closeUp":"famelinks-bd5d010e-b714-4dd3-aed3-bedcd50a8ba1","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null}],"followers":10,"trendzSet":[],"titlesWon":[],"totalJobs":1,"invitationStatus":false,"Invites":0,"hired":0,"followStatus":"Follow","collabs":0,"chatId":"6458eccc2a5ae28d349aa3c3"}]
/// message : "joblinks user profile fetched"
/// success : true

class OtherProfilejoblink {
  OtherProfilejoblink({
    this.result,
    this.message,
    this.success,
  });

  OtherProfilejoblink.fromJson(dynamic json) {
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
  OtherProfilejoblink copyWith({
    List<Result>? result,
    String? message,
    bool? success,
  }) =>
      OtherProfilejoblink(
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

/// _id : "63fcc0d6dbc4fa3dbb872c86"
/// name : "naznin joblinks"
/// bio : ""
/// profession : ""
/// profileImage : null
/// profileImageType : ""
/// greetText : ""
/// greetVideo : ""
/// profileFaces : [{"interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"}],"interestCat":[],"height":{"foot":5,"inch":4},"weight":45,"bust":33,"waist":35,"hip":31,"eyeColor":"brown","complexion":"fair"}]
/// profileCrew : [{"experienceLevel":"experienced","workExperience":"2 years","achievements":"achieve two awards in developement","interestedLoc":[{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"thane","state":"maharashtra","country":"india"}],"interestCat":[{"_id":"64a6466a4d602ad0089ee81c","jobName":"Photographer","jobCategory":null},{"_id":"64a648999039244005454f40","jobName":"Designer","jobCategory":null}]}]
/// masterUser : {"_id":"63fcc0d6dbc4fa3dbb872c8d","district":"akola","state":"maharashtra","country":"india","continent":"asia","dob":"1993-09-10T00:00:00.000Z","profileImage":"famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs","profileImageType":"image","fameCoins":10,"username":"naznin_27960845"}
/// ambassador : ""
/// posts : [{"_id":"640b431d9f9151a8c50c1e3c","closeUp":null,"medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":"famelinks-f50794fd-1f84-497f-afa9-a81639d85a1e"},{"_id":"63ff0b7debccee8e597dd149","closeUp":"famelinks-a1d43c86-3857-4ef4-8ad9-464be713fdb8","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"640042c6ebccee8e597defe7","closeUp":"famelinks-32713900-5672-48f2-9753-d25f904e34cd","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"64057736ebccee8e597e209c","closeUp":"famelinks-395a1354-bd11-48cc-ae8a-d0d042861238","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"63ff0048ebccee8e597dcc7d","closeUp":"famelinks-b9b215d4-5c23-4ebd-ba1f-ff140c409896","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"645611662a5ae28d349a7a5f","closeUp":"famelinks-8babc1ea-234e-4be5-b8fd-338f808caf67","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"6446680322f371817388640e","closeUp":"famelinks-f74e101f-554f-4562-a8bd-e85f1af75afd","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"64789b7271fffa80221aab3a","closeUp":"famelinks-27ca11ae-4a5f-40e2-a0c6-4dcaeb38abd2","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"640576e2ebccee8e597e2002","closeUp":"famelinks-3ccbd4ee-187e-4db0-b66c-b0d5987c392a","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null},{"_id":"6401cd16ebccee8e597df9c7","closeUp":"famelinks-bd5d010e-b714-4dd3-aed3-bedcd50a8ba1","medium":null,"long":null,"pose1":null,"pose2":null,"additional":null,"video":null}]
/// followers : 10
/// trendzSet : []
/// titlesWon : []
/// totalJobs : 1
/// invitationStatus : false
/// Invites : 0
/// hired : 0
/// followStatus : "Follow"
/// collabs : 0
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
    this.profileFaces,
    this.profileCrew,
    this.masterUser,
    this.ambassador,
    this.posts,
    this.followers,
    this.trendzSet,
    this.titlesWon,
    this.totalJobs,
    this.invitationStatus,
    this.invites,
    this.hired,
    this.followStatus,
    this.collabs,
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
    if (json['profileFaces'] != null) {
      profileFaces = [];
      json['profileFaces'].forEach((v) {
        profileFaces?.add(ProfileFaces.fromJson(v));
      });
    }
    if (json['profileCrew'] != null) {
      profileCrew = [];
      json['profileCrew'].forEach((v) {
        profileCrew?.add(ProfileCrew.fromJson(v));
      });
    }
    masterUser = json['masterUser'] != null
        ? MasterUser.fromJson(json['masterUser'])
        : null;
    ambassador = json['ambassador'];
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
    followers = json['followers'];
    if (json['trendzSet'] != null) {
      trendzSet = [];
      json['trendzSet'].forEach((v) {
        trendzSet?.add((v));
      });
    }
    if (json['titlesWon'] != null) {
      titlesWon = [];
      json['titlesWon'].forEach((v) {
        titlesWon?.add((v));
      });
    }
    totalJobs = json['totalJobs'];
    invitationStatus = json['invitationStatus'];
    invites = json['Invites'];
    hired = json['hired'];
    followStatus = json['followStatus'];
    collabs = json['collabs'];
    chatId = json['chatId'];
  }
  String? id;
  String? name;
  String? bio;
  String? profession;
  dynamic profileImage;
  String? profileImageType;
  String? greetText;
  String? greetVideo;
  List<ProfileFaces>? profileFaces;
  List<ProfileCrew>? profileCrew;
  MasterUser? masterUser;
  String? ambassador;
  List<Posts>? posts;
  num? followers;
  List<dynamic>? trendzSet;
  List<dynamic>? titlesWon;
  num? totalJobs;
  bool? invitationStatus;
  num? invites;
  num? hired;
  String? followStatus;
  num? collabs;
  String? chatId;
  Result copyWith({
    String? id,
    String? name,
    String? bio,
    String? profession,
    dynamic profileImage,
    String? profileImageType,
    String? greetText,
    String? greetVideo,
    List<ProfileFaces>? profileFaces,
    List<ProfileCrew>? profileCrew,
    MasterUser? masterUser,
    String? ambassador,
    List<Posts>? posts,
    num? followers,
    List<dynamic>? trendzSet,
    List<dynamic>? titlesWon,
    num? totalJobs,
    bool? invitationStatus,
    num? invites,
    num? hired,
    String? followStatus,
    num? collabs,
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
        profileFaces: profileFaces ?? this.profileFaces,
        profileCrew: profileCrew ?? this.profileCrew,
        masterUser: masterUser ?? this.masterUser,
        ambassador: ambassador ?? this.ambassador,
        posts: posts ?? this.posts,
        followers: followers ?? this.followers,
        trendzSet: trendzSet ?? this.trendzSet,
        titlesWon: titlesWon ?? this.titlesWon,
        totalJobs: totalJobs ?? this.totalJobs,
        invitationStatus: invitationStatus ?? this.invitationStatus,
        invites: invites ?? this.invites,
        hired: hired ?? this.hired,
        followStatus: followStatus ?? this.followStatus,
        collabs: collabs ?? this.collabs,
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
    if (profileFaces != null) {
      map['profileFaces'] = profileFaces?.map((v) => v.toJson()).toList();
    }
    if (profileCrew != null) {
      map['profileCrew'] = profileCrew?.map((v) => v.toJson()).toList();
    }
    if (masterUser != null) {
      map['masterUser'] = masterUser?.toJson();
    }
    map['ambassador'] = ambassador;
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    map['followers'] = followers;
    if (trendzSet != null) {
      map['trendzSet'] = trendzSet?.map((v) => v.toJson()).toList();
    }
    if (titlesWon != null) {
      map['titlesWon'] = titlesWon?.map((v) => v.toJson()).toList();
    }
    map['totalJobs'] = totalJobs;
    map['invitationStatus'] = invitationStatus;
    map['Invites'] = invites;
    map['hired'] = hired;
    map['followStatus'] = followStatus;
    map['collabs'] = collabs;
    map['chatId'] = chatId;
    return map;
  }
}

/// _id : "640b431d9f9151a8c50c1e3c"
/// closeUp : null
/// medium : null
/// long : null
/// pose1 : null
/// pose2 : null
/// additional : null
/// video : "famelinks-f50794fd-1f84-497f-afa9-a81639d85a1e"

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

/// _id : "63fcc0d6dbc4fa3dbb872c8d"
/// district : "akola"
/// state : "maharashtra"
/// country : "india"
/// continent : "asia"
/// dob : "1993-09-10T00:00:00.000Z"
/// profileImage : "famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs"
/// profileImageType : "image"
/// fameCoins : 10
/// username : "naznin_27960845"

class MasterUser {
  MasterUser({
    this.id,
    this.district,
    this.state,
    this.country,
    this.continent,
    this.dob,
    this.profileImage,
    this.profileImageType,
    this.fameCoins,
    this.username,
  });

  MasterUser.fromJson(dynamic json) {
    id = json['_id'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    continent = json['continent'];
    dob = json['dob'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    fameCoins = json['fameCoins'];
    username = json['username'];
  }
  String? id;
  String? district;
  String? state;
  String? country;
  String? continent;
  String? dob;
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
    String? dob,
    String? profileImage,
    String? profileImageType,
    num? fameCoins,
    String? username,
  }) =>
      MasterUser(
        id: id ?? this.id,
        district: district ?? this.district,
        state: state ?? this.state,
        country: country ?? this.country,
        continent: continent ?? this.continent,
        dob: dob ?? this.dob,
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
    map['country'] = country;
    map['continent'] = continent;
    map['dob'] = dob;
    map['profileImage'] = profileImage;
    map['profileImageType'] = profileImageType;
    map['fameCoins'] = fameCoins;
    map['username'] = username;
    return map;
  }
}

/// experienceLevel : "experienced"
/// workExperience : "2 years"
/// achievements : "achieve two awards in developement"
/// interestedLoc : [{"district":"mumbai","state":"maharashtra","country":"india"},{"district":"thane","state":"maharashtra","country":"india"}]
/// interestCat : [{"_id":"64a6466a4d602ad0089ee81c","jobName":"Photographer","jobCategory":null},{"_id":"64a648999039244005454f40","jobName":"Designer","jobCategory":null}]

class ProfileCrew {
  ProfileCrew({
    this.experienceLevel,
    this.workExperience,
    this.achievements,
    this.interestedLoc,
    this.interestCat,
  });

  ProfileCrew.fromJson(dynamic json) {
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
  ProfileCrew copyWith({
    String? experienceLevel,
    String? workExperience,
    String? achievements,
    List<InterestedLoc>? interestedLoc,
    List<InterestCat>? interestCat,
  }) =>
      ProfileCrew(
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

/// _id : "64a6466a4d602ad0089ee81c"
/// jobName : "Photographer"
/// jobCategory : null

class InterestCat {
  InterestCat({
    this.id,
    this.jobName,
    this.jobCategory,
  });

  InterestCat.fromJson(dynamic json) {
    id = json['_id'];
    jobName = json['jobName'];
    jobCategory = json['jobCategory'];
  }
  String? id;
  String? jobName;
  dynamic jobCategory;
  InterestCat copyWith({
    String? id,
    String? jobName,
    dynamic jobCategory,
  }) =>
      InterestCat(
        id: id ?? this.id,
        jobName: jobName ?? this.jobName,
        jobCategory: jobCategory ?? this.jobCategory,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['jobName'] = jobName;
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

/// interestedLoc : [{"district":"mumbai","state":"maharashtra","country":"india"}]
/// interestCat : []
/// height : {"foot":5,"inch":4}
/// weight : 45
/// bust : 33
/// waist : 35
/// hip : 31
/// eyeColor : "brown"
/// complexion : "fair"

class ProfileFaces {
  ProfileFaces({
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

  ProfileFaces.fromJson(dynamic json) {
    if (json['interestedLoc'] != null) {
      interestedLoc = [];
      json['interestedLoc'].forEach((v) {
        interestedLoc?.add(InterestedLoc.fromJson(v));
      });
    }
    if (json['interestCat'] != null) {
      interestCat = [];
      json['interestCat'].forEach((v) {
        interestCat?.add((v));
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
  List<dynamic>? interestCat;
  Height? height;
  num? weight;
  num? bust;
  num? waist;
  num? hip;
  String? eyeColor;
  String? complexion;
  ProfileFaces copyWith({
    List<InterestedLoc>? interestedLoc,
    List<dynamic>? interestCat,
    Height? height,
    num? weight,
    num? bust,
    num? waist,
    num? hip,
    String? eyeColor,
    String? complexion,
  }) =>
      ProfileFaces(
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

/// district : "mumbai"
/// state : "maharashtra"
/// country : "india"

class InterestedLoc2 {
  InterestedLoc2({
    this.district,
    this.state,
    this.country,
  });

  InterestedLoc2.fromJson(dynamic json) {
    district = json['district'];
    state = json['state'];
    country = json['country'];
  }
  String? district;
  String? state;
  String? country;
  InterestedLoc2 copyWith({
    String? district,
    String? state,
    String? country,
  }) =>
      InterestedLoc2(
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
