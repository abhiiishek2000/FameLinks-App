

class FunlinksMusicModel {
  List<FunlinksMusicModelResult>? result;
  String? message;
  bool? success;

  FunlinksMusicModel({this.result, this.message, this.success});

  FunlinksMusicModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FunlinksMusicModelResult>[];
      json['result'].forEach((v) {
        result!.add(new FunlinksMusicModelResult.fromJson(v));
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

class FunlinksMusicModelResult {
  String? sId;
  String? music;
  String? by;
  String? name;
  String? duration;
  String? addedBy;
  Null thumbnail;
  bool? isSaved;

  FunlinksMusicModelResult(
      {this.sId,
        this.music,
        this.by,
        this.name,
        this.duration,
        this.addedBy,
        this.thumbnail,
        this.isSaved});

  FunlinksMusicModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    music = json['music'];
    by = json['by'];
    name = json['name'];
    duration = json['duration'];
    addedBy = json['addedBy'];
    thumbnail = json['thumbnail'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['music'] = this.music;
    data['by'] = this.by;
    data['name'] = this.name;
    data['duration'] = this.duration;
    data['addedBy'] = this.addedBy;
    data['thumbnail'] = this.thumbnail;
    data['isSaved'] = this.isSaved;
    return data;
  }
}