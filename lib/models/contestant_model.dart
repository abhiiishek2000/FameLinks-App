class ContestantResponse {
  List<Result>? result;
  String? message;
  bool? success;

  ContestantResponse({this.result, this.message, this.success});

  ContestantResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
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

class Result {
  String? sId;
  String? name;
  String? type;
  String? district;
  String? state;
  String? country;
  String? gender;
  String? ageGroup;
  List<Media>? images;

  Result(
      {this.sId,
        this.name,
        this.district,
        this.state,
        this.country,
        this.gender,
        this.ageGroup,
        this.images});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    gender = json['gender'];
    ageGroup = json['ageGroup'];
    if (json['media'] != null) {
      images = <Media>[];
      json['media'].forEach((v) {
        images!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['gender'] = this.gender;
    data['ageGroup'] = this.ageGroup;
    if (this.images != null) {
      data['media'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  String? image;
  int? likesCount;

  Media(
      {this.image,
        this.likesCount});

  Media.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    likesCount = json['likesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['likesCount'] = this.likesCount;
    return data;
  }
}
