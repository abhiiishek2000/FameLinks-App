import 'dart:convert';
/// result : [{"_id":"63fcc0d6dbc4fa3dbb872c8d","name":"naznin","type":"individual","district":"akola","state":"maharashtra","country":"india","profileImage":"famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs","profileImageType":"image","followedBy":[{"_id":"643e6442fc54e8539f84a231","name":"Ashish"},{"_id":"6415628cfc36f43902f14831","name":"Kalyan"}]},{"_id":"643ebd29fc54e8539f84bd78","name":"Pratham R","type":"individual","district":"chennai","state":"tamil nadu","country":"tamil nadu","profileImage":null,"profileImageType":"","followedBy":[]},{"_id":"62f0e14803f501c993a7364c","name":"famelinksOfficialBrand","type":"brand","district":"pune","state":"maharashtra","country":"india","profileImage":"famelinks-cc924b66-9041-40d0-9839-3a69d03386f8-xs","profileImageType":"image","followedBy":[{"_id":"643e6442fc54e8539f84a231","name":"Ashish"},{"_id":"642479c7fc36f43902f1af3e","name":null}]},{"_id":"643a461efc54e8539f846e50","name":"Raghvi","type":"individual","district":"hamirpur","state":"himachal pradesh","country":"himachal pradesh","profileImage":null,"profileImageType":"","followedBy":[{"_id":"643e6442fc54e8539f84a231","name":"Ashish"}]},{"_id":"64242575fc36f43902f19fac","name":"Anirud","type":"individual","district":"malerkotla","state":"punjab","country":"punjab","profileImage":null,"profileImageType":"","followedBy":[{"_id":"642479c7fc36f43902f1af3e","name":null},{"_id":"643e6442fc54e8539f84a231","name":"Ashish"}]}]
/// message : "Suggestions Fetched"
/// success : true

Followsuggestionsmodel followsuggestionsmodelFromJson(String str) => Followsuggestionsmodel.fromJson(json.decode(str));
String followsuggestionsmodelToJson(Followsuggestionsmodel data) => json.encode(data.toJson());
class Followsuggestionsmodel {
  Followsuggestionsmodel({
      this.result, 
      this.message, 
      this.success,});

  Followsuggestionsmodel.fromJson(dynamic json) {
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
Followsuggestionsmodel copyWith({  List<Result>? result,
  String? message,
  bool? success,
}) => Followsuggestionsmodel(  result: result ?? this.result,
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

/// _id : "63fcc0d6dbc4fa3dbb872c8d"
/// name : "naznin"
/// type : "individual"
/// district : "akola"
/// state : "maharashtra"
/// country : "india"
/// profileImage : "famelinks-8909e42d-612d-40bc-9867-f2b32218a5fe-xs"
/// profileImageType : "image"
/// followedBy : [{"_id":"643e6442fc54e8539f84a231","name":"Ashish"},{"_id":"6415628cfc36f43902f14831","name":"Kalyan"}]

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      this.id, 
      this.name, 
      this.type, 
      this.district, 
      this.state, 
      this.country, 
      this.profileImage, 
      this.profileImageType, 
      this.followedBy,});

  Result.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    type = json['type'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    profileImage = json['profileImage'];
    profileImageType = json['profileImageType'];
    if (json['followedBy'] != null) {
      followedBy = [];
      json['followedBy'].forEach((v) {
        followedBy?.add(FollowedBy.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? type;
  String? district;
  String? state;
  String? country;
  String? profileImage;
  String? profileImageType;
  List<FollowedBy>? followedBy;
Result copyWith({  String? id,
  String? name,
  String? type,
  String? district,
  String? state,
  String? country,
  String? profileImage,
  String? profileImageType,
  List<FollowedBy>? followedBy,
}) => Result(  id: id ?? this.id,
  name: name ?? this.name,
  type: type ?? this.type,
  district: district ?? this.district,
  state: state ?? this.state,
  country: country ?? this.country,
  profileImage: profileImage ?? this.profileImage,
  profileImageType: profileImageType ?? this.profileImageType,
  followedBy: followedBy ?? this.followedBy,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['district'] = district;
    map['state'] = state;
    map['country'] = country;
    map['profileImage'] = profileImage;
    map['profileImageType'] = profileImageType;
    if (followedBy != null) {
      map['followedBy'] = followedBy?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "643e6442fc54e8539f84a231"
/// name : "Ashish"

FollowedBy followedByFromJson(String str) => FollowedBy.fromJson(json.decode(str));
String followedByToJson(FollowedBy data) => json.encode(data.toJson());
class FollowedBy {
  FollowedBy({
      this.id, 
      this.name,});

  FollowedBy.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;
FollowedBy copyWith({  String? id,
  String? name,
}) => FollowedBy(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}