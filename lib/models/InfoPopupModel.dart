class InfoPopupModel {
  String? message;
  bool? success;
  bool? showPopUp;
  List<PopUpData>? result;

  InfoPopupModel({this.message, this.success,this.showPopUp, this.result});

  InfoPopupModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    showPopUp = json['showPopUp'];
    success = json['success'];
    if (json['result'] != null) {
      result = <PopUpData>[];
      json['result'].forEach((v) {
        result!.add(new PopUpData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['isFirstLogin'] = this.showPopUp;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopUpData {
  String? data;
  String? image;
  String? video;

  PopUpData({this.data, this.image, this.video});

  PopUpData.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    image = json['image'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['image'] = this.image;
    data['video'] = this.video;
    return data;
  }
}
