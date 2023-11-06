import 'package:famelink/models/MyFunLinksResponse.dart';

class FunLinksSongPostModel {
  Result? result;
  String? message;
  bool? success;

  FunLinksSongPostModel({this.result, this.message, this.success});

  FunLinksSongPostModel.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Result {
  List<MyFunLinksResult>? data;
  bool? isSaved;

  Result({this.data, this.isSaved});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyFunLinksResult>[];
      json['data'].forEach((v) { data!.add(new MyFunLinksResult.fromJson(v)); });
    }
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['isSaved'] = this.isSaved;
    return data;
  }
}
