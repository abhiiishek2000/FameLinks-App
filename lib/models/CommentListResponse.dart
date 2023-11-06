class CommentListResponse {
  CommentResult? result;
  String? message;
  bool? success;

  CommentListResponse({this.result, this.message, this.success});

  CommentListResponse.fromJson(Map<dynamic, dynamic> json) {
    result =
    json['result'] != null ? new CommentResult.fromJson(json['result']) : null;
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

class CommentResult {
  List<Comment>? data;
  int? count;

  CommentResult({this.data, this.count});

  CommentResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Comment>[];
      json['data'].forEach((v) {
        data!.add(new Comment.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Comment {
  String? sId;
  String? userId;
  String? mediaId;
  String? body;
  int? likesCount;
  int? repliesCount;
  String? createdAt;
  String? updatedAt;
  User? user;
  int? likeStatus;

  Comment(
      {this.sId,
        this.userId,
        this.mediaId,
        this.body,
        this.likesCount,
        this.repliesCount,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.likeStatus});

  Comment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    mediaId = json['mediaId'];
    body = json['body'];
    likesCount = json['likesCount'];
    repliesCount = json['repliesCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    likeStatus = json['likeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['mediaId'] = this.mediaId;
    data['body'] = this.body;
    data['likesCount'] = this.likesCount;
    data['repliesCount'] = this.repliesCount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['likeStatus'] = this.likeStatus;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? type;
  String? profileImage;

  User({this.sId, this.name, this.type, this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
