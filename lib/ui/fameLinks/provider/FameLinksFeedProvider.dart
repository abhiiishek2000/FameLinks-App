import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/otherUserProfile/model/FameLinkUserProfileModel.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:native_ads_flutter/native_ads.dart';

import '../../../databse/currentvideo.dart';
import '../../../databse/fetchlocaldata.dart';
import '../../../models/CommentAddResponse.dart';
import '../../../models/CommentListResponse.dart';
import '../../../models/userUpdateResponse.dart';
import '../../../util/registerDialog.dart';
import '../../latest_profile/ProfileFameLinksModel.dart';

class FameLinksFeedProvider extends ChangeNotifier {
  bool loading = false;
  bool isOnPageTurning = false;
  bool isOnPageHorizontalTurning = false;
  String? followStatus;
  int current = 0;
  PageController? pageController;
  PageController? funLinksPageController;
  PageController? followLinksPageController;
  TextEditingController reportPostController = new TextEditingController();
  PageController? smoothPageController;
  PageController? myController;
  CommentResult? commentResult;
  List<Comment> commentRepliesList = [];
  List<Comment> commentList = [];
  int commentPage = 1;
  int commentRepliesPage = 1;
  int index = 0;
  int page = 1;
  int tabpos = 0;
  static bool isProfileUI = false;
  bool onClickPageImage = false;
  bool likeStatus = false;
  bool? likeStatusHalf;
  bool? likeStatusNun;
  bool isMute = true;
  ApiProvider _api = ApiProvider();
  String postSingleValue = "";
  String? ids;
  TextEditingController commentController = new TextEditingController();
  TextEditingController replayController = new TextEditingController();
  bool detailShow = false;
  List<ProfileFameLinksModelResult> profileFameLinksList =
      <ProfileFameLinksModelResult>[];
  List<FameLinkUserProfileModelResult> feedList =
      <FameLinkUserProfileModelResult>[];
  var avtarImage;
  var profileImage;
  var noImage;
  String? profileFameLinksImage;
  bool? isRegistered;

  getcurrentindex() async {
    int? cindex = await Currentvideo().getvideoindex("currentindexfame") ?? 0;
    print("Current $cindex");
    Future.delayed(Duration(seconds: 1), () {
      // myController!.jumpToPage(cindex!);
      //  notifyListeners();
    });
  }

  getFamlink() async {
    loading = true;
    var result1 = await Fetchlocaldata().famlinklocal();
    if (result1 != null) {
      print("localdata123  ${result1.result!.length}.");
      loading = false;
      getcurrentindex();

      notifyListeners();
    } else {
      getFameLinkFeedData();
    }
  }

  getMe() async {
    await getFameLinkFeedData();
  }

  getlocal() async {
    await getFamlink();
  }

  getFameLinkFeedData({bool? paginate}) async {
    loading = true;
    if (paginate == true) {
      famePagination++;
    } else {
      famePagination = 1;
    }
    var result = await _api.getFameLinksProfile(famePagination);
    if (result != null) {
      print('Length of feed=>${result.result!.length}');
      feedList.addAll(result.result!);
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  restrictUser(String userid) async {
    for (int i = 0; i < feedList.length; i++) {
      if (feedList[i].id == userid) {
        feedList.removeAt(i);
      }
    }
    notifyListeners();
  }

  newpostavailable(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('New Post Available'),
      action: SnackBarAction(
        label: 'Click hare',
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("fameFeedPage");
          getFameLinkFeedData(paginate: true);
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  blocktUser(String userid) async {
    for (int i = 0; i < feedList.length; i++) {
      if (feedList[i].id == userid) {
        feedList.removeAt(i);
      }
    }
    notifyListeners();
  }

  Future getFollowStatus(String id) async {
    for(var i =0; i< feedList.length; i++){
      if(feedList[i].user!.id == id){
        feedList[i].followStatus = 'Following';
      }
    }
    notifyListeners();
    var result = await _api.getFoloowStatusAPI(id);
    print(result['message']);
    followStatus = result['message'];
    if (result['success'] == true) {}
  }

  deeplinkshare(String id) async {
    // followLinkLoading = true;
    // var data = await napi.getSharefollowlink(id, null);
    // if (data != null) {
    //   followLinkUserProfileModel = data;
    //   print("localdata123  ${data.result!.length}.");
    //   followLinkLoading = false;
    // }
  }

  Future getUnFollowStatus(String id) async {
    for(var i =0; i< feedList.length; i++){
      if(feedList[i].user!.id == id){
        feedList[i].followStatus = 'Follow';
      }
    }
    notifyListeners();
    var result = await _api.getUnFoloowStatusAPI(id);
    print(result['message']);
    followStatus = result['message'];
    if (result['success'] == true) {}
  }

  changeLoadingStatus(bool value) {
    loading = value;
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

  void deletePost(int index) {
    print("delete post $index");
    feedList.removeAt(index);
    notifyListeners();
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

  bool get getIsProfileUI {
    return isProfileUI;
  }

  void changeIsProfileUI(bool value) {
    isProfileUI = value;
    notifyListeners();
  }

  bool get getOnClickPageImage {
    return onClickPageImage;
  }

  void changeOnClickPageImage(bool value) {
    onClickPageImage = value;
    notifyListeners();
  }

  int famePagination = 0;

  void likeHeart(
      int? i, int findData, BuildContext context, bool isRegistered) async {
    if (isRegistered == false) {
      registerDialog(context);
    } else {
      if (findData == 2) {
        if (i == 2) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          if (feedList[getIndex].likeStatus == 1) {
            feedList[getIndex].likes1Count =
                feedList[getIndex].likes1Count! - 1;
          }
          feedList[getIndex].likeStatus = 2;
          feedList[getIndex].likes2Count = feedList[getIndex].likes2Count! + 1;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${feedList[getIndex].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              feedList[getIndex].likeStatus = null;
            }
          });
        } else if (i == null) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          feedList[getIndex].likes2Count = feedList[getIndex].likes2Count! - 1;
          feedList[getIndex].likeStatus = null;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${feedList[getIndex].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              feedList[getIndex].likeStatus = 2;
            }
          });
        }
      } else if (findData == 1) {
        if (i == 1) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          if (feedList[getIndex].likeStatus == 2) {
            feedList[getIndex].likes2Count =
                feedList[getIndex].likes2Count! - 1;
          }
          feedList[getIndex].likeStatus = 2;
          feedList[getIndex].likes1Count = feedList[getIndex].likes1Count! + 1;
          feedList[getIndex].likeStatus = 1;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${feedList[getIndex].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              feedList[getIndex].likeStatus = null;
            }
          });
        } else if (i == null) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          feedList[getIndex].likes1Count = feedList[getIndex].likes1Count! - 1;
          feedList[getIndex].likeStatus = null;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${feedList[getIndex].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              feedList[getIndex].likeStatus = 1;
            }
          });
        }
      } else if (findData == 0) {
        if (i == 0) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          if (feedList[getIndex].likeStatus == 2) {
            feedList[getIndex].likes2Count =
                feedList[getIndex].likes2Count! - 1;
          } else if (feedList[getIndex].likeStatus == 1) {
            feedList[getIndex].likes1Count =
                feedList[getIndex].likes1Count! - 1;
          }
          feedList[getIndex].likes0Count = feedList[getIndex].likes0Count! + 1;
          feedList[getIndex].likeStatus = 0;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${feedList[getIndex].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              feedList[getIndex].likeStatus = null;
            }
          });
        } else if (i == null) {
          Map<String, dynamic> map = {
            "status": i != null ? i.toString() : null,
          };
          feedList[getIndex].likes0Count = feedList[getIndex].likes0Count! - 1;
          feedList[getIndex].likeStatus = null;
          notifyListeners();
          Api.post.call(context,
              method: "media/famelinks/like/media/${feedList[getIndex].id}",
              param: map,
              isLoading: false, onResponseSuccess: (Map object) {
            var result = LikesResponse.fromJson(object);
            if (result.success == true) {
            } else {
              feedList[getIndex].likeStatus = 0;
            }
          });
        }
      }
    }
  }

  Future getCommentData(
      BuildContext context, String type, String postId,{bool ?isPaginate}) async {
    if(isPaginate==true){
      commentPage++;
    }else{
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

  Future addComment(BuildContext context, String type, String postId,
      Map<String, String> params) async {
    Api.post.call(context,
        method: "media/$type/comment/$postId",
        param: params,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = UserUpdatedResponse.fromJson(object);
      Constants.toastMessage(msg: result.message);
      commentController.text = '';
      getCommentData(context, type, postId);
    });
  }

  void deleteComment(
      BuildContext context, String type, Comment comment, int index) async {
    Api.delete.call(context,
        method: "media/$type/comment/${comment.sId}",
        param: {}, onResponseSuccess: (Map object) {
      commentList.removeAt(index);
      commentResult!.count = commentResult!.count! -1;
      notifyListeners();
    });
  }

  Future getCommentReplies(BuildContext context, String commentId,{bool? isPaginate}) async {
    if(isPaginate==true){
      commentRepliesPage++;
    }else{
      commentRepliesList.clear();
      commentRepliesPage=1;
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
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? data = prefs.getStringList("profilepicfamelink");
  //   print("profilepicfamelink $data");
  //   if (data != null) {
  //     if (data![0] == "avatar") {
  //       profileFameLinksImage = await Filecache().getcache(data![1]).toString();
  //     } else {
  //       profileFameLinksImage = await Filecache().getcache(data![2]).toString();
  //     }
  //   }
  //   print("profilepicfamelinkofline $profileFameLinksImage");
  //   notifyListeners();
  // }

  getFameLinksProfileDetails() async {
    print("profilepicfamelink ");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ids = await DatabaseProvider().getUserId();
    isRegistered = await DatabaseProvider().getisRegistered();
    notifyListeners();
    var result = await _api.getFameLinkProfileAPI(ids!);
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
      profileFameLinksList.addAll(result.result!);
      if (profileFameLinksList[0].profileImageType != null) {
        if (profileFameLinksList[0].profileImageType == "avatar") {
          profileFameLinksImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFameLinksList[0].profileImage}";
          notifyListeners();
        } else if (profileFameLinksList[0].profileImageType == "image") {
          profileFameLinksImage =
              "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFameLinksList[0].profileImage}";
          notifyListeners();
        }
      }
      //
      // List<String> data = [
      //   profileFameLinksList[0].profileImageType.toString(),
      //   "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFameLinksList[0].profileImage}",
      //   "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFameLinksList[0].profileImage}"
      // ];

      // Filecache().savecache(
      //     "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${profileFameLinksList[0].profileImage}");
      // Filecache().savecache(
      //     "${ApiProvider.s3UrlPath}/${ApiProvider.profile}/${profileFameLinksList[0].profileImage}");
      // prefs.setStringList("profilepicfamelink", data);
      // getlocalprofilepic();
    }
  }
}
