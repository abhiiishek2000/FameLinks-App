import 'package:famelink/dio/api/api.dart';
import 'package:famelink/models/my_followers_model.dart';
import 'package:famelink/networking/config.dart';
import 'package:flutter/material.dart';

class FollowingProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider();

  List<MyFollowersResult> myFollowersResult = [];

  List<MyFollowersResult> mySuggestionsResult = [];

  List<MyFollowersResult> myFollowingResult = [];

  int followersPage = 1;
  int followingPage = 1;
  int suggestionsPage = 1;
  ScrollController followersScrollController = ScrollController();
  ScrollController followingScrollController = ScrollController();
  ScrollController suggestionsScrollController = ScrollController();

  void followers(BuildContext context, String id,
      {required bool isPaginate}) async {
    if (isPaginate) {
      followersPage++;
    } else {
      myFollowersResult.clear();
      followersPage = 1;
    }
    Map<String, dynamic> param = {"page": followersPage.toString()};

    Api.get.call(context, method: "users/$id/followers", param: param,
        onResponseSuccess: (Map<dynamic, dynamic> object) {
      var result = MyFollowersResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFollowersResult.addAll(result.result!);
        notifyListeners();
      } else {
        followersPage--;
      }
    });
  }

  void following(BuildContext context, String id,
      {required bool isPaginate}) async {
    if (isPaginate) {
      followingPage++;
    } else {
      myFollowingResult.clear();
      followingPage = 1;
    }
    Map<String, dynamic> param = {
      "page": followingPage.toString(),
    };

    Api.get.call(context,
        method: "users/$id/followees",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = MyFollowersResponse.fromJson(object);
      if (result.result!.length > 0) {
        myFollowingResult.addAll(result.result!);
        notifyListeners();
      } else {
        followingPage--;
      }
    });
  }

  void suggestions(BuildContext context) async {
    Map<String, dynamic> param = {
      "page": suggestionsPage.toString(),
    };
    mySuggestionsResult.clear();

    Api.get.call(context,
        method: "users/follow/suggestions",
        param: param,
        isLoading: false, onResponseSuccess: (Map object) {
      var result = MyFollowersResponse.fromJson(object);
      if (result.result!.length > 0) {
        mySuggestionsResult.addAll(result.result!);
        notifyListeners();
      } else {
        suggestionsPage--;
      }
    });
  }

  void removeFollower(BuildContext context, int index) async {
    Api.delete.call(context,
        method: "users/removeFollower/${myFollowersResult[index].id}",
        param: {}, onResponseSuccess: (Map object) {
      myFollowersResult.removeAt(index);
      notifyListeners();
    });
  }

  void followUser(BuildContext context, int index) async {
    Api.post.call(context,
        method: "users/follow/${myFollowersResult[index].id}",
        param: {}, onResponseSuccess: (Map object) {
      myFollowersResult[index].followStatus = "Following";
      myFollowingResult.add(myFollowersResult[index]);
      notifyListeners();
    });
  }

  void followUserForFollowing(BuildContext context, int index) async {
    Api.post.call(context,
        method: "users/follow/${myFollowingResult[index].id}",
        param: {}, onResponseSuccess: (Map object) {
      myFollowingResult[index].followStatus = "Follow";
      notifyListeners();
    });
  }

  void unFollowUser(BuildContext context, int index) async {
    Api.delete.call(context,
        method: "users/unfollow/${myFollowingResult[index].id}",
        param: {}, onResponseSuccess: (Map object) {
      myFollowingResult[index].followStatus = "Following";
      notifyListeners();
    });
  }

  void suggestionFollowChangeStatus(BuildContext context, int index) async {
    if (mySuggestionsResult[index].followStatus == "") {
      Api.delete.call(context,
          method: "users/unfollow/${mySuggestionsResult[index].id}",
          param: {}, onResponseSuccess: (Map object) {
        myFollowingResult.add(mySuggestionsResult[index]);
        notifyListeners();
      });
    } else {
      Api.post.call(context,
          method: "users/follow/${mySuggestionsResult[index].id}",
          param: {}, onResponseSuccess: (Map object) {
        myFollowingResult.insert(0, mySuggestionsResult[index]);
        mySuggestionsResult[index].followStatus = "Follow";
        notifyListeners();
        Future.delayed(Duration(seconds: 2), () {
          mySuggestionsResult.removeAt(index);
          notifyListeners();
        });
      });
    }
  }
}
