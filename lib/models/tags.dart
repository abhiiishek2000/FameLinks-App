class TagsModel {
  List<Tags>? result;
  String? message;
  bool? success;

  TagsModel({this.result, this.message, this.success});

  TagsModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Tags>[];
      json['result'].forEach((v) {
        result!.add(new Tags.fromJson(v));
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

class Tags {
  String? sId;
  String? username;

  Tags({this.sId, this.username});

  Tags.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    return data;
  }
}