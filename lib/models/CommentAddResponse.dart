class CommentAddResponse {
  String? message;
  bool? success;

  CommentAddResponse({this.message, this.success});

  CommentAddResponse.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}
