class ChallengeSlider {
  List<BannerImage>? result;
  String? message;
  bool? success;

  ChallengeSlider({this.result, this.message, this.success});

  ChallengeSlider.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <BannerImage>[];
      json['result'].forEach((v) {
        result!.add(new BannerImage.fromJson(v));
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

class BannerImage {
  String? media;
  String? type;
  String? id;
  bool? isImpression = false;

  BannerImage({this.media, this.type});

  BannerImage.fromJson(Map<String, dynamic> json) {
    media = json['media'];
    type = json['type'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media'] = this.media;
    data['type'] = this.type;
    data['_id'] = this.id;
    return data;
  }
}
