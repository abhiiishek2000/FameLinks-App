class HallOfFameModel {
  Result? result;
  String? message;
  bool? success;

  HallOfFameModel({this.result, this.message, this.success});

  HallOfFameModel.fromJson(Map<dynamic, dynamic> json) {
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
  Winner? winner;
  Winner? runnerUp1;
  Winner? runnerUp2;

  Result({this.winner, this.runnerUp1, this.runnerUp2});

  Result.fromJson(Map<String, dynamic> json) {
    winner =
    json['winner'] != null ? new Winner.fromJson(json['winner']) : null;
    runnerUp1 = json['runnerUp1'] != null
        ? new Winner.fromJson(json['runnerUp1'])
        : null;
    runnerUp2 = json['runnerUp2'] != null
        ? new Winner.fromJson(json['runnerUp2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.winner != null) {
      data['winner'] = this.winner!.toJson();
    }
    if (this.runnerUp1 != null) {
      data['runnerUp1'] = this.runnerUp1!.toJson();
    }
    if (this.runnerUp2 != null) {
      data['runnerUp2'] = this.runnerUp2!.toJson();
    }
    return data;
  }
}

class Winner {
  WinnerTitles? winnerTitles;
  String? name;
  String? username;
  String? sId;
  String? profileImage;

  Winner({this.winnerTitles, this.name, this.username, this.sId, this.profileImage});

  Winner.fromJson(Map<String, dynamic> json) {
    winnerTitles = json['winnerTitles'] != null
        ? new WinnerTitles.fromJson(json['winnerTitles'])
        : null;
    name = json['name'];
    username = json['username'];
    sId = json['_id'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.winnerTitles != null) {
      data['winnerTitles'] = this.winnerTitles!.toJson();
    }
    data['name'] = this.name;
    data['username'] = this.username;
    data['_id'] = this.sId;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class WinnerTitles {
  String? title;
  String? date;
  String? category;

  WinnerTitles({this.title, this.date, this.category});

  WinnerTitles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['category'] = this.category;
    return data;
  }
}
