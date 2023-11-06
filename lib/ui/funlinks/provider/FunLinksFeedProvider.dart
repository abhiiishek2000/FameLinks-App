import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/CommentAddResponse.dart';
import 'package:famelink/models/CommentListResponse.dart';
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../databse/currentvideo.dart';
import '../../../databse/fetchlocaldata.dart';
import '../../../models/userUpdateResponse.dart';
import '../../../networking/newconfig.dart';
import '../../../util/constants.dart';
import '../../Famelinkprofile/function/famelinkFun.dart';
import '../../otherUserProfile/model/FunLinkUserProfileModel.dart' as funre;

class FunLinksFeedProvider extends ChangeNotifier {
  int funFeedPage = 0;
  bool check = false;
  int index = 0;
  int page = 1;
  int tabpos = 0;
  int current = 0;
  bool isOnPageTurning = false;
  bool isOnPageHorizontalTurning = false;
  bool isNavigationOn = false;
  bool funLinkLoading = false;
  bool isProfileUI = false;
  bool onClickPageImage = false;
  final ApiProvider _api = ApiProvider();
  NewApiProvider napi = NewApiProvider();
  TextEditingController commentController = new TextEditingController();
  TextEditingController replayController = new TextEditingController();
  CommentResult? commentResult;
  List<Comment> commentRepliesList = [];
  List<Comment> commentList = [];
  int commentPage = 1;
  int commentRepliesPage = 1;
  bool detailShow = false;
  bool? isRegistered;
  String? ids;
  var avtarImage;
  var profileImage;
  String? profileFunLinksImage;
  var noImage;
  PageController? smoothPageController;
  PageController? myController;
  List<funre.Result> funLinksList = <funre.Result>[];

  getFundata() async {
    funLinkLoading = true;
    var data = await Fetchlocaldata().funlinklocal();
    print("funlinklocaldata $data");
    if (data != null) {
      funLinkLoading = false;
      getcurrentindex();
      notifyListeners();
    } else {
      getFunLinkFeedData();
    }
  }

  deeplinkshare(String id) async {
    funLinkLoading = true;
    var data = await napi.getSharefunlink(id, null);
    if (data != null) {
      print("localdata123  ${data.result!.length}.");
      funLinkLoading = false;
    }
  }

  getcurrentindex() async {
    int? cindex = await Currentvideo().getvideoindex("currentindexfun") ?? 0;
    print("Current $cindex");
    Future.delayed(Duration(seconds: 1), () {
      myController!.jumpToPage(cindex!);
      //   notifyListeners();
    });
  }

  getFunLinkFeedData({bool? paginate}) async {
    funLinkLoading = true;
    if (paginate == true) {
      funFeedPage++;
    } else {
      funFeedPage = 1;
    }
    var result = await _api.getFunLinksProfile(funFeedPage);
    if (result != null) {
      print('Length of funLinkFeed=>${result.result!.length}');
      funLinksList.addAll(result.result!);
      funLinkLoading = false;
      notifyListeners();
    } else {
      funLinkLoading = false;
      notifyListeners();
    }
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

  bool get getIsNavigationOn {
    return isNavigationOn;
  }

  void changeIsNavigationOn(bool value) {
    isNavigationOn = value;
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

  bool get getIsProfileUI {
    return isProfileUI;
  }

  void changeIsProfileUI(bool value) {
    isProfileUI = value;
    notifyListeners();
  }

  void deletePost(int index) {
    funLinksList.removeAt(index);
    notifyListeners();
  }

  bool get getOnClickPageImage {
    return onClickPageImage;
  }

  void changeOnClickPageImage(bool value) {
    onClickPageImage = value;
    notifyListeners();
  }

  Future getFollowStatus(String id) async {
    for (var i = 0; i < funLinksList.length; i++) {
      if (funLinksList[i].user!.id == id) {
        funLinksList[i].followStatus = 'Following';
      }
    }
    notifyListeners();
    var result = await _api.getFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  Future getUnFollowStatus(String id) async {
    for (var i = 0; i < funLinksList.length; i++) {
      if (funLinksList[i].user!.id == id) {
        funLinksList[i].followStatus = 'Follow';
      }
    }
    notifyListeners();
    var result = await _api.getUnFoloowStatusAPI(id);
    print(result['message']);
    if (result['success'] == true) {}
  }

  likeFunLinks(int? i, BuildContext context) async {
    if (i == null) {
      Map<String, dynamic> map = {
        "status": null,
      };
      funLinksList[getIndex].likeStatus = null;
      funLinksList[getIndex].likesCount =
          funLinksList[getIndex].likesCount! - 1;

      notifyListeners();

      Api.post.call(context,
          method: "media/funlinks/like/media/${funLinksList[getIndex].id}",
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
      funLinksList[getIndex].likeStatus = 2;
      funLinksList[getIndex].likesCount =
          funLinksList[getIndex].likesCount! + 1;
      notifyListeners();
      Api.post.call(context,
          method: "media/funlinks/like/media/${funLinksList[getIndex].id}",
          param: map,
          isLoading: false, onResponseSuccess: (Map object) {
        var result = LikesResponse.fromJson(object);
        if (result.success == true) {
        } else {}
      });
    }
  }

  newpostavailable(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('New Post Available'),
      action: SnackBarAction(
        label: 'Click hare',
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("funFeedPage");
          getFunLinkFeedData(paginate: true);
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  restrictUser(String userid) async {
    for (int i = 0; i < funLinksList.length; i++) {
      if (funLinksList[i].id == userid) {
        funLinksList.removeAt(i);
      }
    }
    notifyListeners();
  }

  blocktUser(String userid) async {
    for (int i = 0; i < funLinksList.length; i++) {
      if (funLinksList[i].id == userid) {
        funLinksList.removeAt(i);
      }
    }
    notifyListeners();
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

  // getlocalprofilepic() async {
  //   print("profilepicfunlink");
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? data = prefs.getStringList("profilepicfunlink");
  //   if (data != null) {
  //     if (data![0] == "avatar") {
  //       profileFunLinksImage = await Filecache().getcache(data![1]).toString();
  //     } else {
  //       profileFunLinksImage = await Filecache().getcache(data![2]).toString();
  //     }
  //   }
  //   notifyListeners();
  // }
  FameLinkFun fameLinkFun = FameLinkFun();
  getFunLinksProfileDetails() async {
    //getlocalprofilepic();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isRegistered = sharedPreferences.getBool("isRegistered");
    ids = sharedPreferences.getString("id");
    notifyListeners();
    var result = await _api.getFunLinkProfileAPI(ids);
    DatabaseProvider().getProfileImage().then((value) {
      avtarImage = value;
      notifyListeners();
    });
    DatabaseProvider().getProfileImage().then((value) {
      profileImage = value;
      notifyListeners();
    });
    DatabaseProvider().getProfileImage().then((value) {
      noImage = value;
      notifyListeners();
    });

    if (result != null) {
      fameLinkFun.profileFunLinksList.addAll(result.result!);
      if (fameLinkFun.profileFunLinksList[0].profileImageType != null) {
        if (fameLinkFun.profileFunLinksList[0].profileImageType == "avatar") {
          profileFunLinksImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${fameLinkFun.profileFunLinksList[0].profileImage}";
          notifyListeners();
        } else if (fameLinkFun.profileFunLinksList[0].profileImageType ==
            "image") {
          profileFunLinksImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${fameLinkFun.profileFunLinksList[0].profileImage}";
        }
        // List<String> data = [
        //   profileFunLinksList[0].profileImageType.toString(),
        //   "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFunLinksList[0].profileImage}",
        //   "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFunLinksList[0].profileImage}"
        // ];
        //
        // Filecache().savecache(
        //     "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFunLinksList[0].profileImage}");
        // Filecache().savecache(
        //     "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFunLinksList[0].profileImage}");
        //
        // sharedPreferences.setStringList("profilepicfunlink", data);
        // getlocalprofilepic();
        notifyListeners();
      }
    }
  }
}
