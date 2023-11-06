class FunLinksSongs {
  List<ResultSongs>? result;
  String? message;
  bool? success;

  FunLinksSongs({this.result, this.message, this.success});

  FunLinksSongs.fromJson(Map<dynamic,dynamic> json) {
    if (json['result'] != null) {
      result = <ResultSongs>[];
      json['result'].forEach((v) {
        result!.add(new ResultSongs.fromJson(v));
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

class ResultSongs {
  String? id;
  String? song;
  String? by;
  String? name;
  String? thumbnail;
  String? duration;
  bool? isPlay = false;
  bool? isSaved = false;

  ResultSongs(
      {this.song,this.by,this.name,this.thumbnail,this.duration,this.isPlay,this.isSaved});

  ResultSongs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    song = json['music'];
    by = json['by'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['music'] = this.song;
    data['by'] = this.by;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['duration'] = this.duration;
    data['isPlay'] = this.isPlay;
    data['isSaved'] = this.isSaved;
    return data;
  }
}
