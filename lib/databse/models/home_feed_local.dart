class HomeFeedLocal {
  bool? isShown;
  String? date;
  HomeFeedLocal(this.date, this.isShown);

  HomeFeedLocal.fromJson(Map<String, dynamic> json) {
    isShown = json['isShown'];
    date = json['date'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isShown'] = this.isShown;
    data['date'] = this.date;
    return data;
  }
}
