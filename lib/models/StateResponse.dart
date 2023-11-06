class StateResponse {
  String? message;
  bool? success;
  Result? result;

  StateResponse({this.result, this.message, this.success});

  StateResponse.fromJson(Map<String, dynamic> json) {
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
  List<String>? states;

  Result(
      {this.states});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = <String>[];
      json['states'].forEach((v) {
        states!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v).toList();
    }
    return data;
  }
}
