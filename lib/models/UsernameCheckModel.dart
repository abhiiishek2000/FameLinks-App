class UsernameCheckModel {
  UserNameResult? result;
  String? message;
  bool? success;

  UsernameCheckModel({this.result, this.message, this.success});

  UsernameCheckModel.fromJson(Map<dynamic, dynamic> json) {
    result =
    json['result'] != null ? new UserNameResult.fromJson(json['result']) : null;
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

class UserNameResult {
  bool? isAvailable;

  UserNameResult({this.isAvailable});

  UserNameResult.fromJson(Map<String, dynamic> json) {
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAvailable'] = this.isAvailable;
    return data;
  }
}
