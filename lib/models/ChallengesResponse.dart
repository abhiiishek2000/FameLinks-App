class ChallengesResponse {
  List<Challenges>? result;
  String? message;
  bool? success;

  ChallengesResponse({this.result, this.message, this.success});

  ChallengesResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['result'] != null) {
      result = <Challenges>[];
      json['result'].forEach((v) {
        result!.add(new Challenges.fromJson(v));
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

class Challenges {
  String? sId;
  String? name;

  String? description;

  String? startDate;

  String? hashTag;

  Challenges(
      {this.sId,
        this.name,
        this.description,
        this.startDate,this.hashTag
        });

  Challenges.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    name = json['name'];
    startDate = json['startDate'];
    hashTag = json['hashTag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['hashTag'] = this.hashTag;
    return data;
  }
}
