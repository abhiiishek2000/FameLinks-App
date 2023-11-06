import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/my_followers_model.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databse/currentvideo.dart';
import '../../../databse/fetchlocaldata.dart';
import '../../../models/CommentAddResponse.dart';
import '../../../models/CommentListResponse.dart';
import '../../../models/Profile_Model.dart';
import '../../../models/likes_model.dart';
import '../../../networking/config.dart';
import '../../../networking/newconfig.dart';
import '../../../util/constants.dart';
import '../../../util/registerDialog.dart';
import '../../latest_profile/ProfileFollowLinksModel.dart';
import '../../otherUserProfile/model/FollowLinkUserProfileModel.dart';

class FollowLinksFeedProvider extends ChangeNotifier {
  bool check = false;

  bool followLinkLoading = false;
  var avtarImage;
  var profileImage;
  var noImage;
  int current = 0;
  bool isOnPageTurning = false;
  bool isOnPageHorizontalTurning = false;
  int index = 0;
  static bool isProfileUI = false;
  bool likeStatus = false;
  bool? likeStatusHalf;
  bool? likeStatusNun;
  TextEditingController commentController = new TextEditingController();
  TextEditingController replayController = new TextEditingController();
  CommentResult? commentResult;
  List<Comment> commentRepliesList = [];
  List<Comment> commentList = [];
  int commentPage = 1;
  int commentRepliesPage = 1;
  bool detailShow = false;
  final ApiProvider _api = ApiProvider();
  NewApiProvider napi = NewApiProvider();
  int suggestionsPage = 1;
  List<MyFollowersResult> mySuggestionsResult = <MyFollowersResult>[];
  ProfileResponse? myInfoResponse;
  bool? isRegistered;
  String? ids;
  String? profileFollowLinksImage;
  List<ProfileFollowLinksModelResult> profileFollowLinksList =
      <ProfileFollowLinksModelResult>[];
  PageController? smoothPageController;
  PageController? myController;
  List<FollowLinksResult> followLinkList = <FollowLinksResult>[];

  getFollowlocal() async {
    followLinkLoading = true;
    var data = await Fetchlocaldata().follwlinklocal();
    if (data != null) {
      followLinkLoading = false;
      getcurrentindex();
      notifyListeners();
    } else {
      print("apicall");
      getFollowLinkFeedData();
    }
  }

  deeplinkshare(String id) async {
    followLinkLoading = true;
    var data = await napi.getSharefollowlink(id, null);
    if (data != null) {
      print("localdata123  ${data.result!.length}.");
      followLinkLoading = false;
    }
  }

  getcurrentindex() async {
    int cindex = await Currentvideo().getvideoindex("currentindexfollow") ?? 0;
    print("Current $cindex");
    Future.delayed(Duration(seconds: 1), () {
      myController!.jumpToPage(cindex!);
    });
  }

  getFollowLinkFeedData({bool? paginate}) async {
    followLinkLoading = true;

    var result = await _api.getFollowLinksProfile(1);
    if (result != null) {
      print('Length of followLinkFeed=>${result.result!.length}');
      followLinkList.addAll(result.result!);
      followLinkLoading = false;
      notifyListeners();
    } else {
      followLinkLoading = false;
      notifyListeners();
    }
  }

  newpostavailable(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('New Post Available'),
      action: SnackBarAction(
        label: 'Click hare',
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("followFeedPage");
          getFollowLinkFeedData(paginate: true);
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool get getCheck {
    return check;
  }

  void changeCheck(bool value) {
    check = value;
    notifyListeners();
  }

  bool get getIsProfileUI {
    return isProfileUI;
  }

  void changeIsProfileUI(bool value) {
    isProfileUI = value;
    notifyListeners();
  }

  String get getAvtarImage {
    return avtarImage;
  }

  void changeAvtarImage(String? value) {
    avtarImage = value;
    notifyListeners();
  }

  String get getProfileImage {
    return profileImage;
  }

  void changeProfileImage(String? value) {
    profileImage = value;
    notifyListeners();
  }

  String get getNoImage {
    return noImage;
  }

  void changeNoImage(String? value) {
    noImage = value;
    notifyListeners();
  }

  bool get getIsOnPageTurning {
    return isOnPageTurning;
  }

  void changeOnPageTurning(bool value) {
    isOnPageTurning = value;
    notifyListeners();
  }

  bool get getIsOnPageHorizontalTurning {
    return isOnPageHorizontalTurning;
  }

  void changeOnPageHorizontalTurning(bool value) {
    isOnPageHorizontalTurning = value;
    notifyListeners();
  }

  int get getCurrent {
    return current;
  }

  void changeCurrent(int value) {
    current = value;
    notifyListeners();
  }

  int get getIndex {
    return index;
  }

  void changeIndex(int value, bool? check) {
    index = value;
    if (check == true) {
      notifyListeners();
    }
  }

  bool get getLikeStatus {
    return likeStatus;
  }

  bool get getLikeStatusNun {
    return likeStatusNun!;
  }

  void changeLikeStatusNun(bool value) {
    likeStatusNun = value;
    notifyListeners();
  }

  void deletePost(int index) {
    followLinkList.removeAt(index);
    notifyListeners();
  }

  Future getCommentData(BuildContext context, String type, String postId,
      {bool? isPaginate}) async {
    if (isPaginate == true) {
      commentPage++;
    } else {
      commentList.clear();
      commentPage = 1;
    }

    Map<String, String> map = {"page": commentPage.toString()};
    Api.get.call(context, method: "media/$type/comment/$postId", param: map,
        onResponseSuccess: (Map object) {
      var result = CommentListResponse.fromJson(object);
      if (result.success == true) {
        print("==${result.message}");
      }
      commentResult = result.result;
      commentList.addAll(result.result!.data!);
      notifyListeners();
    });
  }

  Future addComment(BuildContext context, String type, String postId,
      Map<String, dynamic> params) async {
    Api.post.call(context,
        method: "media/$type/comment/$postId?page=1",
        param: params,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = UserUpdatedResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);
      commentController.text = '';
      getCommentData(context, type, postId);
    });
  }

  void commentLike(
      BuildContext context, Comment comment, String type, int index) async {
    Map<String, dynamic> map = {
      "status": comment.likeStatus != null ? null : "3",
    };
    Api.post.call(context,
        method: "media/$type/like/comment/${comment.sId}",
        param: map,
        isLoading: false, onResponseSuccess: (Map object) {
      commentList[index].likeStatus = comment.likeStatus != null ? null : 3;
      commentList[index].likesCount = comment.likeStatus != null
          ? comment.likesCount != null
              ? comment.likesCount! + 1
              : 1
          : comment.likesCount != null
              ? comment.likesCount! - 1
              : 0;
      notifyListeners();
    });
  }

  void deleteComment(
      BuildContext context, String type, Comment comment, int index) async {
    Api.delete.call(context,
        method: "media/$type/comment/${comment.sId}",
        param: {}, onResponseSuccess: (Map object) {
      commentList.removeAt(index);
      commentResult!.count = commentResult!.count! - 1;
      notifyListeners();
    });
  }

  Future getCommentReplies(BuildContext context, String commentId,
      {bool? isPaginate}) async {
    if (isPaginate == true) {
      commentRepliesPage++;
    } else {
      commentRepliesPage = 1;
      commentRepliesList.clear();
    }
    Api.get.call(context,
        method: "media/famelinks/comment/$commentId/replies",
        param: {"page": commentRepliesPage.toString()},
        isLoading: false, onResponseSuccess: (Map object) {
      var result = CommentListResponse.fromJson(object);
      commentResult = result.result;
      commentRepliesList.addAll(result.result!.data!);
      notifyListeners();
    });
  }

  void addReplies(BuildContext context, String type, String postId,
      Map<String, dynamic> params, Comment comment) async {
    Api.post.call(context,
        method: "media/$type/comment/$postId",
        param: params,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = CommentAddResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);
      replayController.text = "";
      getCommentData(context, type, postId);

      commentList[index].repliesCount =
          comment.repliesCount != null ? comment.repliesCount! + 1 : 1;
    });
    notifyListeners();
    Navigator.pop(context);
  }

  void deleteReplies(
      BuildContext context, String type, Comment comment, int index) {
    Api.delete.call(context,
        method: "media/$type/comment/${comment.sId}",
        param: {}, onResponseSuccess: (Map object) {
      commentRepliesList.removeAt(index);
      commentList[index].repliesCount = comment.repliesCount != null
          ? comment.repliesCount == 0
              ? 0
              : comment.repliesCount! - 1
          : 0;
      notifyListeners();
    });
  }

  void changeChangeDetailsStatus(bool value) {
    detailShow = value;
    notifyListeners();
  }

  getSuggestions({required bool isPaginate}) async {
    if (isPaginate) {
      suggestionsPage++;
    } else {
      suggestionsPage = 1;
    }
    var result = await _api.mysuggestionsService(suggestionsPage);
    if (result != null) {
      mySuggestionsResult.addAll(result.result!);
      notifyListeners();
    }
  }

  void likeHeart(BuildContext context, int index, int? i, int findData,
      bool isRegistered) async {
    if (isRegistered == false) {
      registerDialog(context);
    } else {
      if (findData == 2) {
        if (i == 2) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          if (followLinkList[index].likeStatus == 1) {
            followLinkList[index].likes1Count =
                followLinkList[index].likes1Count! - 1;
          }
          followLinkList[index].likeStatus = 2;
          followLinkList[index].likes2Count =
              followLinkList[index].likes2Count! + 1;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${followLinkList[index].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              followLinkList[index].likeStatus = null;
            }
          });
        } else if (i == null) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          followLinkList[index].likes2Count =
              followLinkList[index].likes2Count! - 1;
          followLinkList[index].likeStatus = null;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${followLinkList[index].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              followLinkList[index].likeStatus = 2;
            }
          });
        }
      } else if (findData == 1) {
        if (i == 1) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          if (followLinkList[index].likeStatus == 2) {
            followLinkList[index].likes2Count =
                followLinkList[index].likes2Count! - 1;
          }
          followLinkList[index].likeStatus = 2;
          followLinkList[index].likes1Count =
              followLinkList[index].likes1Count! + 1;
          followLinkList[index].likeStatus = 1;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${followLinkList[index].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              followLinkList[index].likeStatus = null;
            }
          });
        } else if (i == null) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          followLinkList[index].likes1Count =
              followLinkList[index].likes1Count! - 1;
          followLinkList[index].likeStatus = null;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${followLinkList[index].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              followLinkList[index].likeStatus = 1;
            }
          });
        }
      } else if (findData == 0) {
        if (i == 0) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          if (followLinkList[index].likeStatus == 2) {
            followLinkList[index].likes2Count =
                followLinkList[index].likes2Count! - 1;
          } else if (followLinkList[index].likeStatus == 1) {
            followLinkList[index].likes1Count =
                followLinkList[index].likes1Count! - 1;
          }
          followLinkList[index].likes0Count =
              followLinkList[index].likes0Count! + 1;
          followLinkList[index].likeStatus = 0;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${followLinkList[index].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              followLinkList[index].likeStatus = null;
              notifyListeners();
            }
          });
        } else if (i == null) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          followLinkList[index].likes0Count =
              followLinkList[index].likes0Count! - 1;
          followLinkList[index].likeStatus = null;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${followLinkList[index].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              followLinkList[index].likeStatus = 0;
              notifyListeners();
            }
          });
        }
      }
    }
  }

  likeFunLinks(BuildContext context, int index, int? i, String type) async {
    if (i == null) {
      Map<String, dynamic> map = {
        "status": null,
      };
      followLinkList[index].likeStatus = null;
      followLinkList[index].likesCount = followLinkList[index].likesCount! - 1;

      notifyListeners();

      Api.post.call(context,
          method: "media/$type/like/media/${followLinkList[index].id}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
        } else {}
      });
    } else {
      Map<String, dynamic> map = {
        "status": i != null ? i.toString() : null,
      };
      followLinkList[index].likeStatus = 2;
      followLinkList[index].likesCount = followLinkList[index].likesCount! + 1;
      notifyListeners();
      Api.post.call(context,
          method: "media/$type/like/media/${followLinkList[index].id}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
        } else {}
      });
    }
  }

  restrictUser(String userid) async {
    for (int i = 0; i < followLinkList.length; i++) {
      if (followLinkList[i].id == userid) {
        followLinkList.removeAt(i);
      }
    }
    notifyListeners();
  }

  blocktUser(String userid) async {
    for (int i = 0; i < followLinkList.length; i++) {
      if (followLinkList[i].id == userid) {
        followLinkList.removeAt(i);
      }
    }
    notifyListeners();
  }

  // getlocalprofilepic() async {
  //   print("profilepicfollowlink");
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? data = prefs.getStringList("profilepicfollowlink");
  //   if (data != null) {
  //     if (data![0] == "avatar") {
  //       avtarImage = await Filecache().getcache(data![1]).toString();
  //     } else {
  //       profileFollowLinksImage =
  //           await Filecache().getcache(data![2]).toString();
  //     }
  //   }
  //   notifyListeners();
  // }

  getFollowLinksProfileDetails() async {
    //getlocalprofilepic();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isRegistered = sharedPreferences.getBool("isRegistered");
    ids = sharedPreferences.getString("id");
    notifyListeners();
    var result = await _api.getFollowLinkProfileAPI(ids);
    if (result != null) {
      profileFollowLinksList.addAll(result.result!);
      if (profileFollowLinksList[0].profileImageType != null) {
        if (profileFollowLinksList[0].profileImageType == "avatar") {
          avtarImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFollowLinksList[0].profileImage}";
          notifyListeners();
        } else if (profileFollowLinksList[0].profileImageType == "image") {
          profileFollowLinksImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFollowLinksList[0].profileImage}";
          notifyListeners();
        }

        // Filecache().savecache(
        //     "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFollowLinksList[0].profileImage}");
        // Filecache().savecache(
        //     "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFollowLinksList[0].profileImage}");
        //
        // List<String> data = [
        //   profileFollowLinksList[0].profileImageType.toString(),
        //   "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFollowLinksList[0].profileImage}",
        //   "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFollowLinksList[0].profileImage}"
        // ];
        //
        // sharedPreferences.setStringList("profilepicfollowlink", data);
        // getlocalprofilepic();
        notifyListeners();
      }
    }
  }

  Future getFollowStatus(String id) async {
    for (var i = 0; i < followLinkList.length; i++) {
      if (followLinkList[i].user!.id == id) {
        followLinkList[i].followStatus = 'Following';
      }
    }
    notifyListeners();
    var result = await _api.getFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  Future getUnFollowStatus(String id) async {
    for (var i = 0; i < followLinkList.length; i++) {
      if (followLinkList[i].user!.id == id) {
        followLinkList[i].followStatus = 'Follow';
      }
    }
    notifyListeners();
    var result = await _api.getUnFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }
}
