class DistrictResponse {
  String? message;
  bool? success;
  Result? result;

  DistrictResponse({this.result, this.message, this.success});

  DistrictResponse.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
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
  List<String>? districts;

  Result(
      {this.districts});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['districts'] != null) {
      districts = <String>[];
      json['districts'].forEach((v) {
        districts!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.districts != null) {
      data['districts'] = this.districts!.map((v) => v).toList();
    }
    return data;
  }
}
