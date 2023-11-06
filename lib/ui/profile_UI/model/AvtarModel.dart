
class AvtarModel {
  List<AvtarModelResult>? avtarResult;
  String? message;
  bool? success;

  AvtarModel({this.avtarResult, this.message, this.success});

  AvtarModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      avtarResult = <AvtarModelResult>[];
      json['result'].forEach((v) {
        avtarResult!.add(new AvtarModelResult.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avtarResult != null) {
      data['result'] = this.avtarResult!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class AvtarModelResult {
  String? sId;
  String? name;

  AvtarModelResult({this.sId, this.name});

  AvtarModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}