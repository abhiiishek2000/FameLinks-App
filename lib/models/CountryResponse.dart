class CountryResponse {
  String? message;
  bool? success;
  Result? result;

  CountryResponse({this.result, this.message, this.success});

  CountryResponse.fromJson(Map<String, dynamic> json) {
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
  List<String>? countries;

  Result(
      {this.countries});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <String>[];
      json['countries'].forEach((v) {
        countries!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v).toList();
    }
    return data;
  }
}
