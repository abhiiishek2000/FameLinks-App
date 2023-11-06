import 'dart:convert';

/// result : [{"path":"famelinks-06a9c078-9461-4042-bbf1-d7107cf32678","name":"Abhishekh Kumar","type":"famelinks"},{"path":"famelinks-09bcede2-0904-4cd9-bdd4-76520de9604c","name":"naznin_followlinks","type":"followlinks"},{"path":"famelinks-21053b44-c2e6-4f21-acae-e20e2dacd64a","name":"Abhishek Kumar","type":"followlinks"},{"path":"famelinks-21053b44-c2e6-4f21-acae-e20e2dacd64a","name":"Kalyan Follow","type":"followlinks"}]
/// message : "Welcome videos Fetched successfully"
/// success : true

FollowlinkExploresayhi followlinkExploresayhiFromJson(String str) =>
    FollowlinkExploresayhi.fromJson(json.decode(str));
String followlinkExploresayhiToJson(FollowlinkExploresayhi data) =>
    json.encode(data.toJson());

class FollowlinkExploresayhi {
  FollowlinkExploresayhi({
    this.result,
    this.message,
    this.success,
  });

  FollowlinkExploresayhi.fromJson(dynamic json) {
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
  FollowlinkExploresayhi copyWith({
    List<Result>? result,
    String? message,
    bool? success,
  }) =>
      FollowlinkExploresayhi(
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

/// path : "famelinks-06a9c078-9461-4042-bbf1-d7107cf32678"
/// name : "Abhishekh Kumar"
/// type : "famelinks"

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    this.path,
    this.name,
    this.type,
  });

  Result.fromJson(dynamic json) {
    path = json['path'];
    name = json['name'];
    type = json['type'];
  }
  String? path;
  String? name;
  String? type;
  Result copyWith({
    String? path,
    String? name,
    String? type,
  }) =>
      Result(
        path: path ?? this.path,
        name: name ?? this.name,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = path;
    map['name'] = name;
    map['type'] = type;
    return map;
  }
}
