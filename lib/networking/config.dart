import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:famelink/common/common_routing.dart';
import 'package:famelink/main.dart';
import 'package:famelink/media_compression_provider.dart';
import 'package:famelink/models/ChallengesResponse.dart';
import 'package:famelink/models/ChatMessageModel.dart';
import 'package:famelink/models/ChatUserModel.dart';
import 'package:famelink/models/CommentAddResponse.dart';
import 'package:famelink/models/CommentListResponse.dart';
import 'package:famelink/models/ConversationModel.dart';
import 'package:famelink/models/CountryModel.dart';
import 'package:famelink/models/CountryResponse.dart';
import 'package:famelink/models/DistrictResponse.dart';
import 'package:famelink/models/FunLinksResponse.dart';
import 'package:famelink/models/LocationResponse.dart';
import 'package:famelink/models/MyFunLinksResponse.dart';
import 'package:famelink/models/OpenChallengesResponse.dart';
import 'package:famelink/models/Profile_Model.dart';
import 'package:famelink/models/StateResponse.dart';
import 'package:famelink/models/UsernameCheckModel.dart';
import 'package:famelink/models/contestant_model.dart';
import 'package:famelink/models/famelink_model.dart';
import 'package:famelink/models/famelinks_model.dart';
import 'package:famelink/models/follow_response.dart';
import 'package:famelink/models/funlinks_songs_model.dart';
import 'package:famelink/models/google_login_model.dart';
import 'package:famelink/models/likes_model.dart';
import 'package:famelink/models/my_challenges_response.dart';
import 'package:famelink/models/my_followers_model.dart';
import 'package:famelink/models/notification_model.dart';
import 'package:famelink/models/oneuser_response.dart';
import 'package:famelink/models/otp_model.dart';
import 'package:famelink/models/register_response.dart';
import 'package:famelink/models/search_model.dart';
import 'package:famelink/models/store_model.dart';
import 'package:famelink/models/tags.dart';
import 'package:famelink/models/unfollow_service.dart';
import 'package:famelink/models/upcoming_challenges_model.dart';
import 'package:famelink/models/update_contest_model.dart';
import 'package:famelink/models/userUpdateResponse.dart';
import 'package:famelink/nativeads/Nativeadsapp.dart';
import 'package:famelink/ui/homedial/model/CheckUserNameModel.dart';
import 'package:famelink/ui/homedial/model/HomeScreenModel.dart';
import 'package:famelink/ui/homedial/model/RegistrationModel.dart';
import 'package:famelink/ui/joblinks/models/JobCategoriesModel.dart';
import 'package:famelink/ui/latest_profile/CollabProfileModel.dart';
import 'package:famelink/ui/latest_profile/ProfileFameLinksModel.dart';
import 'package:famelink/ui/latest_profile/ProfileFollowLinksModel.dart';
import 'package:famelink/ui/latest_profile/ProfileFunLinksModel.dart';
import 'package:famelink/ui/latest_profile/StoreProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/OtherFameLinksModel.dart';
import 'package:famelink/ui/otherUserProfile/model/FameLinkUserProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/FollowLinkUserProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/FunLinkUserProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/GetParticularUserProfileModel.dart';
import 'package:famelink/ui/otherUserProfile/model/OtherUserProfileFollowLinksModel.dart';
import 'package:famelink/ui/otherUserProfile/model/OtherUserProfileFunLinksModel.dart';
import 'package:famelink/ui/otherUserProfile/model/OtherUserProfileFunlinksPostModel.dart';
import 'package:famelink/ui/profile_UI/model/AvtarModel.dart';
import 'package:famelink/ui/upload/modelClass/FunlinksMusicModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../databse/localdata.dart';
import '../models/Followsuggestionsmodel.dart';
import '../models/RecommendationModel.dart';
import '../models/followlinkExploresayhi.dart';

class ApiProvider {
  static final ApiProvider _api = ApiProvider._internal();
  static final String appName = "FameLinks";
  static final String baseUrl = "https://userapi.famelinks.app/v2/";
  static final String loginUrl = "https://login.famelinks.app/v2/";
  static final String baseUrl2 = "https://userapi.famelinks.app/v3/";
  static final String shareUrl = "https://userapi.famelinks.app/";
  static dynamic s3UrlPath;
  static dynamic famelinks;
  static dynamic followlinks;
  static dynamic profile;
  static dynamic funlinks;
  static dynamic funlinksMusic;
  static dynamic avatar;
  static dynamic joblinks;
  static dynamic challenges;
  static dynamic cluboffer;
  static dynamic trendz;

  final Dio authDio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl,
      connectTimeout: 300000,
      receiveTimeout: 300000,
      headers: <String, dynamic>{
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      responseType: ResponseType.json));
  final Dio dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl,
      connectTimeout: 300000,
      receiveTimeout: 300000,
      headers: <String, dynamic>{
        "Authorization": Constants.token,
      },
      contentType: "multipart/form-data",
      responseType: ResponseType.json));

  final Dio diov3 = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl2,
      connectTimeout: 300000,
      receiveTimeout: 300000,
      headers: <String, dynamic>{
        "Authorization": Constants.token,
      },
      contentType: "multipart/form-data",
      responseType: ResponseType.json));

  factory ApiProvider() {
    return ApiProvider._internal();
  }

  ApiProvider._internal() {
    injectInterceptor();
  }

  injectInterceptor() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers["Authorization"] = prefs!.getString('token');
      print('REQUEST1-${options.path}');
      print('REQUEST2-${options.contentType}');
      print('REQUEST3-${options.uri}');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print('RESPONSE-${response.data}');
      return handler.next(response); // continue
    }, onError: (DioError err, handler) {
      print('ERROR-${err.error}');
      if (_shouldRetry(err)) {
        // TODO: Schedule a retry
        // showAlertDialog(context);
      }
      // Let the error "pass through" if it's not the error we're looking for
      return err.error; // continue
    }));

    authDio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('REQUEST-${options.data}');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print('RESPONSE-${response.data}');
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      print('ERROR-${e.error}');
      return handler.next(e); // continue
    }));
  }

  showAlertDialog(
      BuildContext context, RequestOptions requestOptions, Dio dio) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text("retry", style: TextStyle(color: lightRed)),
      onPressed: () async {
        Navigator.pop(context);
        scheduleRequestRetry(requestOptions, dio);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        "couldn't fetch data, refresh again",
        style: GoogleFonts.nunitoSans(color: black),
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }

  scheduleRequestRetry(RequestOptions requestOptions, Dio dio) async {
    /*StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = Connectivity().onConnectivityChanged.listen(
          (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
            ),
          );
        }
      },
    );*/
    dio.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
    );
    // return responseCompleter.future;
  }

  // Future<LoginResponse?> loginService(map) async {
  //   print("MAP::::${map.toString()}");
  //   Response response =
  //   await authDio.post("users/login", data: jsonEncode(map));
  //   if (response != null) {
  //     return LoginResponse.fromJson(response.data);
  //   }
  //   return null;
  // }

  // Future<LoginResponse?> updateMobile(map) async {
  //   Response response = await dio.post("users/contact",
  //       options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       }),
  //       data: jsonEncode(map));
  //   if (response != null) {
  //     return LoginResponse.fromJson(response.data);
  //   }
  //   return null;
  // }
  //
  // Future<LoginResponse?> updateEmail(map) async {
  //   Response response = await dio.post("users/email",
  //       options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       }),
  //       data: jsonEncode(map));
  //   if (response != null) {
  //     return LoginResponse.fromJson(response.data);
  //   }
  //   return null;
  // }

  Future<LikesResponse?> notifSettingUpdate(map) async {
    print(map);
    Response response = await dio.put("users/settings",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(map));
    if (response != null) {
      return LikesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<LikesResponse?> likesService(
      String mediaId, String type, Map<String, dynamic> map) async {
    debugPrint("LIKEPARAM:::${map.toString()}");
    Response response = await dio.post("media/${type}/like/media/${mediaId}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: map);
    if (response != null) {
      return LikesResponse.fromJson(response.data);
    }
    return null;
  }

  // Future<LikesResponse> funLinksLike(String mediaId,Map<String, dynamic> map) async {
  //   Response response =
  //       await dio.post("media/funlinks/like/media/${mediaId}",options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       }), data: jsonEncode(map));
  //   print(response.data);
  //   if (response != null) {
  //     return LikesResponse.fromJson(response.data);
  //   }
  //   return null;
  // }
  Future<LikesResponse?> likesComment(
      String mediaId, String type, params) async {
    print(jsonEncode(params));
    Response response = await dio.post("media/$type/like/comment/$mediaId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params));
    if (response != null) {
      return LikesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<LikesResponse?> likesFunLinksComment(String mediaId, params) async {
    print(jsonEncode(params));
    Response response = await dio.post("media/funlinks/like/comment/$mediaId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params));
    if (response != null) {
      return LikesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FollowResponse?> removeFollower(String sId) async {
    Response response = await dio.delete(
      "users/removeFollower/$sId",
    );
    if (response != null) {
      return FollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FollowResponse?> followService(String sId) async {
    Response response = await dio.post("users/follow/$sId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      return FollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UnfollowResponse?> unfollowService(String sId) async {
    Response response = await dio.delete("users/unfollow/$sId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<GoogleLoginResponse?> loginWithGoogleService(params) async {
    Response response =
        await authDio.post("users/login/email", data: jsonEncode(params));
    if (response != null) {
      return GoogleLoginResponse.fromJson(response.data);
    }
    return null;
  }

  Future<OtpResponse?> otpService(Map<String, dynamic> map) async {
    Response response = await authDio.post("users/verifyOtp", data: map);
    if (response != null) {
      return OtpResponse.fromJson(response.data);
    }
    return null;
  }

  Future<CountryModel?> getCountryCode() async {
    Response response = await authDio.get("location/country-code");
    if (response != null) {
      return CountryModel.fromJson(response.data);
    }
    return null;
  }

  Future<RegisterResponse?> verifyUpdateOTPMobile(
      Map<String, dynamic> map) async {
    Response response = await dio.post("users/contact/verify", data: map);
    if (response != null) {
      return RegisterResponse.fromJson(response.data);
    }
    return null;
  }

  Future<RegisterResponse?> verifyUpdateOTPEmail(
      Map<String, dynamic> map) async {
    Response response = await dio.post("users/email/verify", data: map);
    if (response != null) {
      return RegisterResponse.fromJson(response.data);
    }
    return null;
  }

  Future<RegisterResponse?> registerService(params) async {
    Response response =
        await dio.put("users/register", data: FormData.fromMap(params));
    print('vvvvvvvvvvvvvvvvvv+$params');
    if (response != null) {
      return RegisterResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> addFeedback(map) async {
    Response response = await dio.post("users/feedback",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(map));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> addRepostFAQ(map) async {
    Response response = await dio.post("users/report/issue",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(map));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> editProfileService(map) async {
    Response response = await dio.put("users/update",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(map));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> updateFameLinksPost(postId, type, map) async {
    Response response = await dio.put("media/$type/$postId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(map));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<HomeScreenModel?> getFameLinkFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString("token");
    try {
      Response response = await dio.get("homepage/feed?page=1",
          options: Options(
            headers: {HttpHeaders.authorizationHeader: token},
            validateStatus: (status) => true,
          ));
      debugPrint('1-1-1-1-1-1 getfunLinksProfile ${response.data.toString()}');

      if (response.statusCode == 200) {
        if (response.data['result'].length > 0) {
          Localdata().sethivedata(response.data, "getFameLinkFeed");

          return HomeScreenModel.fromJson(response.data);
        }
      } else {
        log('Exception from try block');
      }
    } on DioError catch (e) {
      log('Exception from catch block');
    }
    return null;
  }

  Future getFoloowStatusAPI(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map page = {"page": "1"};
    Response response = await dio.post("users/follow/$id",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));

    if (response.data != null) {
      if (response.statusCode == 200) {
        return response.data;
      }
    }
    return null;
  }

  Future getUnFoloowStatusAPI(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map page = {"page": "1"};
    Response response = await dio.delete("users/unfollow/$id",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));

    if (response.data != null) {
      if (response.statusCode == 200) {
        return response.data;
      }
    }
    return null;
  }

  Future<FunlinksMusicModel?> getFunlinksSongsAPI(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get(
        "media/funlinks/songs?page=1&search=${query}",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));

    if (response.data != null) {
      //if(response.statusCode ==200){
      return FunlinksMusicModel.fromJson(response.data);
      //}
    }
    return null;
  }

  Future<TagsModel?> getTagsAPI(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.post("/users/search/tags/$query",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    if (response.data != null) {
      if (response.statusCode == 200) {
        return TagsModel.fromJson(response.data);
      }
    }
    return null;
  }

  List getfameads = [];
  List getfamedata = [];

  Future<GetParticularUserProfileModel?> getParticularUserProfile(
      String id, page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get("media/famelinks/$id?page=$page",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    log("getParticularUserProfile ${response.data.toString()}");

    getfameads.addAll(response.data['result']);

    for (var i = 0; i < getfameads.length; i++) {
      if (i % 6 == 0 && getfameads[i]['media'][0]['type'] != "ads" && i != 0) {
        getfamedata.insert(i, NativeadsApp.adslist);

        getfamedata.add(getfameads[i]);
      } else {
        getfamedata.add(getfameads[i]);
      }
    }

    Map<String, dynamic> data1 = {"result": getfamedata};

    if (response != null) {
      return GetParticularUserProfileModel.fromJson(data1);
    }
    return null;
  }

  List getfunads = [];
  List getfundata = [];

  Future<OtherUserProfileFunlinksPostModel?> getParticularUserProfileFunLinks(
      String id, page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get("media/funlinks/$id?page=${page}",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    log("getParticularUserProfileFunLinks ${response.data.toString()}");
    if (response.data != null) {
      getfunads.addAll(response.data['result']);

      for (var i = 0; i < getfunads.length; i++) {
        if (i % 6 == 0 && getfunads[i]['media'][0]['type'] != "ads" && i != 0) {
          getfundata.insert(i, NativeadsApp.funadslist);

          getfundata.add(getfunads[i]);
        } else {
          getfundata.add(getfunads[i]);
        }
      }

      Map<String, dynamic> data1 = {"result": getfundata};

      return OtherUserProfileFunlinksPostModel.fromJson(data1);
    }
    return null;
  }

  List getfollowads = [];
  List getfollowdata = [];

  Future<OtherUserProfileFunlinksPostModel?>
      getParticularUserProfileFollowLinks(String id, page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get("media/followlinks/$id?page=${page}",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    log("getParticularUserProfileFollowLinks ${response.data.toString()}");

    if (response.data != null) {
      getfollowads.addAll(response.data['result']);

      for (var i = 0; i < getfollowads.length; i++) {
        if (i % 6 == 0 &&
            getfollowads[i]['media'][0]['type'] != "ads" &&
            i != 0) {
          getfollowdata.insert(i, NativeadsApp.funadslist);
          getfollowdata.add(getfollowads[i]);
        } else {
          getfollowdata.add(getfollowads[i]);
        }
      }

      Map<String, dynamic> data1 = {"result": getfollowdata};

      return OtherUserProfileFunlinksPostModel.fromJson(data1);
    }
    return null;
  }

  Future<ProfileFameLinksModel?> getFameLinkProfileAPI(String id,
      {int? pageNo}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    // debugPrint("id----------------------" + id);
    Response response = await dio.get(
        "/users/profile/famelinks/$id?page=${pageNo ?? 1}",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    log("profilefamelink2 ${response.data}");
    if (response.data != null) {
      Localdata().sethivedata(response.data, "profilefamelink");
      return ProfileFameLinksModel.fromJson(response.data);
    }
    return null;
  }

  Future<StoreProfile?> getStoreLinkProfileAPI(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    // debugPrint("id----------------------" + id);
    Response response = await dio.get("/users/profile/storelinks/$id?page=1",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    if (response.data != null) {
      return StoreProfile.fromJson(response.data);
    }
    return null;
  }

  Future<Collabs?> getCollabLinkProfileAPI(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    // debugPrint("id----------------------" + id);
    Response response = await dio.get("/users/profile/collablinks/$id?page=1",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    if (response.data != null) {
      return Collabs.fromJson(response.data);
    }
    return null;
  }

  Future<RecommendationModel?> getAgencyRecommendationAPI(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    // debugPrint("id----------------------" + id);
    Response response = await dio.get("users/agency/$id/recommendations",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    if (response.data != null) {
      return RecommendationModel.fromJson(response.data);
    }
    return null;
  }

  Future<OtherFameLinksModel?> getFameLinkOtherAPI(String id, funindex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    Response response = await dio.get(
        "/users/profile/famelinks/$id?page=$funindex",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    log("11-11-11-11- getFameLinkOtherAPI ${response.data.toString()}");

    if (response.data != null) {
      return OtherFameLinksModel.fromJson(response.data);
    }
    return null;
  }

  Future<StoreModel?> getStoreLinkOtherAPI(String id, page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    Response response = await dio.get("/users/brandOne/$id/products?page=$page",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    if (response.data != null) {
      return StoreModel.fromJson(response.data);
    }
    return null;
  }

  Future<OtherUserProfileFunLinksModel?> getFameLinkOtherAPIFunLinks(
      String id, int? fnindex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print("token $fnindex");
    Response response = await dio.get(
        "/users/profile/funlinks/$id?page=${fnindex ?? 1}",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    debugPrint("11-11-11-11- getFameLinkFeed ${response.data.toString()}");

    if (response.data != null) {
      return OtherUserProfileFunLinksModel.fromJson(response.data);
    }
    return null;
  }

  Future<OtherUserProfileFollowLinksModel?> getFameLinkOtherAPIFollowLinks(
      String id, int foindex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    Response response = await dio.get(
        "/users/profile/followlinks/$id?page=$foindex",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    if (response.data != null) {
      log("followlink club data ${response.data}");
      return OtherUserProfileFollowLinksModel.fromJson(response.data);
    }
    return null;
  }

  Future<ProfileFunLinksModel?> getFunLinkProfileAPI(id, {int? pageNo}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    // String id = prefs.getString("id");
    Response response = await dio.get(
        "/users/profile/funlinks/$id?page=${pageNo ?? 1}",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    print("getFunLinkProfileonline ${response.data}");
    if (response.data != null) {
      Localdata().sethivedata(response.data, "profilefunlink");
      return ProfileFunLinksModel.fromJson(response.data);
    }
    return null;
  }

  Future<ProfileFollowLinksModel?> getFollowLinkProfileAPI(id,
      {int? pageNo}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    print("$id getFollowLinkProfile 234");
    // String id = prefs.getString("id");
    Response response = await dio.get(
        "/users/profile/followlinks/$id?page=${pageNo ?? 1}",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));

    if (response.data != null) {
      Localdata().sethivedata(response.data, "profilefollowlink");

      return ProfileFollowLinksModel.fromJson(response.data);
    }
    return null;
  }

  Future getRequestAPI(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);

    Response response = await dio.post("/users/follow/request/accept/$id",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));

    if (response.data != null) {
      return response.data;
    }
    return null;
  }

  Future accountDelete(String action) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    print(token);
    Map params = {
      "action": action,
    };
    print(params);
    http.Response response = await http.post(
        Uri.parse("https://userapi.budlinks.in/v2/users/account/settings"),
        headers: {"Authorization": token.toString()},
        body: params);

    debugPrint(
        "11-11-11-11- getFameLinkFeed ${response.statusCode.toString()}");
    if (response.body != null) {
      print(response);
      return response.statusCode;
    }
    return null;
  }

  Future<AvtarModel?> getAvtarData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get("avatar",
        options: Options(headers: {HttpHeaders.authorizationHeader: token}));
    debugPrint("11-11-11-11- getFameLinkFeed ${response.data.toString()}");
    debugPrint(
        "11-11-11-11- getFameLinkFeed ${response.statusCode.toString()}");
    debugPrint(
        "11-11-11-11- getFameLinkFeed ${response.statusMessage.toString()}");
    if (response.data != null) {
      return AvtarModel.fromJson(response.data);
    }
    return null;
  }

  Future<LocationResponse?> getLocation(String search) async {
    debugPrint('1-1-1-1-1-1 getLocation 1-1-1-1-1-1');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    debugPrint('1-1-1-1-1-1 getLocation Token ${token.toString()}');
    Response response = await dio.get(
      "location?search=${search}",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    debugPrint('1-1-1-1-1-1 getLocation ${response.statusCode.toString()}');
    debugPrint('1-1-1-1-1-1 getLocation ${response.statusMessage.toString()}');
    debugPrint('1-1-1-1-1-1 getLocation ${response.data.toString()}');
    if (response != null) {
      return LocationResponse.fromJson(response.data);
    }
    return null;
  }

  Future<JobCategoriesModel?> getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get(
      "joblinks/getAllJobCategories",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    if (response != null) {
      return JobCategoriesModel.fromJson(response.data);
    }
    return null;
  }

  Future<ChallengesResponse?> getSearchvalue(String search) async {
    debugPrint('1-1-1-1-1-1 getLocation 1-1-1-1-1-1');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    debugPrint('1-1-1-1-1-1 getLocation Token ${token.toString()}');
    Response response = await dio.get(
      "challenges/search/${search}/famelinks",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    debugPrint('1-1-1-1-1-1 getLocation ${response.statusCode.toString()}');
    debugPrint('1-1-1-1-1-1 getLocation ${response.statusMessage.toString()}');
    debugPrint('1-1-1-1-1-1 getLocation ${response.data.toString()}');
    if (response != null) {
      return ChallengesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<Followsuggestionsmodel?> followexploresuggestion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    debugPrint('1-1-1-1-1-1 getLocation Token ${token.toString()}');
    Response response = await dio.get(
      "users/follow/suggestions?page=1",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    debugPrint(
        '1-1-1-1-1-1 followexploresuggestion ${response.data.toString()}');
    if (response != null) {
      return Followsuggestionsmodel.fromJson(response.data);
    }
    return null;
  }

  Future<FollowlinkExploresayhi?> followexploresayhi() async {
    debugPrint('1-1-1-1-1-1 getLocation 1-1-1-1-1-1');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    debugPrint('1-1-1-1-1-1 getLocation Token ${token.toString()}');
    Response response = await diov3.get(
      "media/welcomeVideo?page=1",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    log('1-1-1-1-1-1 followexploresayhi ${response.data.toString()}');
    if (response != null) {
      return FollowlinkExploresayhi.fromJson(response.data);
    }
    return null;
  }

  Future<CheckUserNameModel?> verifyUserName(String search) async {
    debugPrint('1-1-1-1-1-1 verifyUserName 1-1-1-1-1-1');

    String? token = prefs!.getString("token");
    debugPrint('1-1-1-1-1-1 getLocation Token ${token.toString()}');
    Response response = await dio.get(
      "users/check/username/${search.toString()}",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    debugPrint('1-1-1-1-1-1 getLocation ${response.statusCode.toString()}');
    debugPrint('1-1-1-1-1-1 getLocation ${response.statusMessage.toString()}');
    debugPrint('1-1-1-1-1-1 getLocation ${response.data.toString()}');

    if (response != null) {
      return CheckUserNameModel.fromJson(response.data);
    }
    return null;
  }

  Future<bool?> userIndicator({
    String? name,
    String? professions,
    String? bio,
    String? types,
    File? profileFile,
    dynamic isProfileUpdates,
    String? avatarImage,
  }) async {
    String? token = prefs!.getString("token");
    String? id = prefs!.getString("id");
    String urls =
        "users/profile/" + types.toString() + "/" + id.toString() + '?page=1';
    debugPrint(
        "111-111-111-111-111 UserIndcicator API Calling ${urls.toString()}");
    Map<String, dynamic> params;
    Response response;
    //print(profileFile.path);
    print(avatarImage);
    if (isProfileUpdates == 'updateProfile') {
      if (profileFile != null && profileFile.path != "") {
        print(profileFile.path);
        debugPrint(
            "1111111111111111111111111111-------------------------- When Select File$profileFile ");
        var headers = {
          'Authorization': token.toString(),
        };
        var request = http.MultipartRequest(
            'PATCH', Uri.parse("https://userapi.budlinks.in/v2/${urls}"));
        request.fields.addAll({'profileImageType': 'image'});
        request.files.add(await http.MultipartFile.fromPath(
            'profileImage', profileFile.path));
        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        print("Result: ${response.statusCode}");
        return true;
      } else if (avatarImage != "" && avatarImage != null) {
        print(avatarImage);
        params = {
          'profileImage': avatarImage.split('/').last,
          'profileImageType': 'avatar'
        };
        response = await dio
            .patch(
          urls,
          data: FormData.fromMap(params),
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.acceptHeader: '*/*',
              // HttpHeaders.contentTypeHeader: "application/json",
            },
          ),
        )
            .then((value) {
          debugPrint('1=-1=-1=-1=-1=-1 Then ${value.toString()}');
          return value;
        });
        return true;
      }
    } else if (isProfileUpdates == true) {
      if (profileFile != null && profileFile.path != "") {
        print(profileFile.path);
        debugPrint(
            "1111111111111111111111111111-------------------------- When Select File$profileFile ");
        var headers = {
          'Authorization': token.toString(),
        };
        var request = http.MultipartRequest(
            'PATCH', Uri.parse("https://userapi.budlinks.in/v2/${urls}"));
        request.fields.addAll({
          'name': name.toString(),
          'profession': professions.toString(),
          'bio': bio.toString(),
          'profileImageType': 'image'
        });
        request.files.add(await http.MultipartFile.fromPath(
            'profileImage', profileFile.path));
        request.headers.addAll(headers);
        http.Response response =
            await http.Response.fromStream(await request.send());
        print("Result: ${response.statusCode}");
        return true;
      } else if (avatarImage != "" && avatarImage != null) {
        print(avatarImage);
        params = {
          'name': name.toString(),
          'profession': professions.toString(),
          'bio': bio.toString(),
          'profileImage': avatarImage.split('/').last,
          'profileImageType': 'avatar'
        };
        response = await dio
            .patch(
          urls,
          data: FormData.fromMap(params),
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.acceptHeader: '*/*',
              // HttpHeaders.contentTypeHeader: "application/json",
            },
          ),
        )
            .then((value) {
          debugPrint('1=-1=-1=-1=-1=-1 Then ${value.toString()}');
          return value;
        });
        return true;
      }
    } else {
      params = {
        'name': name.toString(),
        'profession': professions.toString(),
        'bio': bio.toString(),
      };
      response = await dio
          .patch(
        urls,
        data: FormData.fromMap(params),
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
            HttpHeaders.acceptHeader: '*/*',
            // HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      )
          .then((value) {
        debugPrint('1=-1=-1=-1=-1=-1 Then ${value.toString()}');
        return value;
      });
      return true;
    }
  }

  Future addFameLinkAPI(String isWelcomeVideo, File? video, String link,
      BuildContext context, File thumb) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    print(token);
    print("  ${video!.path} ${thumb.path} ");
    var headers = {
      'Authorization': token.toString(),
    };
    var request =
        http.MultipartRequest('POST', Uri.parse("${baseUrl}media/$link"));
    print(request);
    if (link == "followlinks") {
      request.files.add(await http.MultipartFile.fromPath('media', video.path));
      request.files
          .add(await http.MultipartFile.fromPath('thumbnail', thumb!.path));
    } else if (link == "funlinks") {
      request.files.add(await http.MultipartFile.fromPath('video', video.path));
      request.files
          .add(await http.MultipartFile.fromPath('thumbnail', thumb!.path));
    } else {
      request.files.add(await http.MultipartFile.fromPath('video', video.path));
      request.files
          .add(await http.MultipartFile.fromPath('video_tmb', thumb!.path));
    }
    request.headers.addAll(headers);
    request.fields.addAll({
      'isWelcomeVideo': "true",
    });
    http.StreamedResponse response = await request.send();
    print("addFameLinkAPI  ${response.statusCode}");
    print(response.stream);

    if (response != null) {
      return response.statusCode;
    }
    return null;
  }

  Future<int?> updateUser(
      {String? locationState,
      String? locationDistrict,
      String? locationCountry,
      String? dob,
      String? username}) async {
    String? token = prefs!.getString("token");
    String? id = prefs!.getString("id");
    debugPrint('1-1-1-1-1-1 updateUser Token ${token.toString()}');
    debugPrint(
        '1-1-1-1-1-1 updateUser locationDistrict ${locationDistrict.toString()}');
    debugPrint(
        '1-1-1-1-1-1 updateUser locationState ${locationState.toString()}');
    debugPrint(
        '1-1-1-1-1-1 updateUser locationCountry ${locationCountry.toString()}');
    debugPrint('1-1-1-1-1-1 updateUser dob ${dob.toString()}');
    debugPrint('1-1-1-1-1-1 updateUser username ${username.toString()}');
    Map params = {
      "district": locationDistrict,
      "state": locationState,
      "country": locationCountry,
      "dob": dob,
      "username": username,
    };
    try {
      http.Response response = await http.put(
          Uri.parse("https://userapi.budlinks.in/v2/users/update"),
          headers: {"Authorization": token.toString()},
          body: params);

      debugPrint('1-1-1-1-1-1 updateUser ${response.statusCode.toString()}');
      debugPrint('1-1-1-1-1-1 updateUser ${response.request.toString()}');
      debugPrint('1-1-1-1-1-1 updateUser ${response.body.toString()}');
      // debugPrint('1-1-1-1-1-1 updateUser ${response.data.toString()}');
      // debugPrint('1-1-1-1-1-1 updateUser ${response.statusMessage.toString()}');
      // debugPrint('1-1-1-1-1-1 updateUser ${response.data.toString()}');

      if (true) {
        return 1;
      }
      return 0;
    } catch (e) {
      debugPrint('0-0-0-0-0-0-0-0-0-0-0-0-0- updateUser Error ${e.toString()}');
    }
  }

  // Registration
  Future registration({
    BuildContext? context,
    String? name,
    String? gender,
    String? type,
    String? district,
    String? state,
    String? country,
    String? continent,
    String? username,
    String? dob,
    String? imageAvatar,
    String? imageType,
    File? imgFile,
  }) async {
    debugPrint('1-1-1-1-1-1 registration 1-1-1-1-1-1');
    debugPrint('1-1-1-1-1-1 Image Type ${imageType.toString()}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? id = prefs.getString("id");
    Map<String, dynamic> params;
    Response responseData;
    // when default avatar is selected
    if (imageType == 'localAvatar') {
      debugPrint(
          "********************************* Inside Avatar Select Part ********************************* ");
      params = {
        "name": name.toString(),
        "gender": gender.toString(),
        "type": type!.toLowerCase().toString(),
        "district": district.toString(),
        "state": state.toString(),
        "country": country.toString(),
        "continent": continent.toString(),
        "username": username.toString(),
        "dob": dob.toString(),
        "profileImage": imageAvatar,
        "profileImageType": "avatar"
      };
      debugPrint("$params");
      responseData = await dio.put(
        "users/register",
        data: FormData.fromMap(params),
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
            // HttpHeaders.acceptHeader: '*/*',
            // HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      return RegistrationModel.fromJson(responseData.data);
    }
    // else
    //   {
    //   debugPrint("********************************* Inside the File Select Part ********************************* ");
    //   params = {
    //     "name": name.toString(),
    //     "gender": gender.toString(),
    //     "type": type.toLowerCase().toString(),
    //     "district": district.toString(),
    //     "state": state.toString(),
    //     "country": country.toString(),
    //     "continent": continent.toString(),
    //     "username": username.toString(),
    //     "dob": dob.toString(),
    //     "profileImageType":"image"
    //   };
    //   debugPrint("********************************* Params ${params}");
    //   responseData = await dio.put(
    //     "users/register",
    //     data: FormData.fromMap(params),
    //     options: Options(
    //       headers: {
    //         HttpHeaders.authorizationHeader: token,
    //         // HttpHeaders.acceptHeader: '*/*',
    //         // HttpHeaders.contentTypeHeader: "application/json",
    //       },
    //     ),
    //   );
    // }
    else if (imageType.toString().trim() == "localfile") {
      debugPrint(
          "********************************* Inside the File Select Part ********************************* ");
      if (imgFile != null) {
        debugPrint(
            "111111111111----------------------- Inside Image File Select Upload ");
        var headers = {'Authorization': token.toString()};
        var request = http.MultipartRequest(
            'PUT', Uri.parse('https://userapi.budlinks.in/v2/users/register'));
        request.fields.addAll({
          "name": name.toString(),
          "gender": gender.toString(),
          "type": type!.toLowerCase().toString(),
          "district": district.toString(),
          "state": state.toString(),
          "country": country.toString(),
          "continent": continent.toString(),
          "username": username.toString(),
          "dob": dob.toString(),
          "profileImageType": "image"
        });
        print(request.fields);
        request.files.add(
            await http.MultipartFile.fromPath('profileImage', imgFile.path));
        request.headers.addAll(headers);
        var streamedResponse = await request.send();

        var response = await http.Response.fromStream(streamedResponse);
        print(response);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        return RegistrationModel.fromJson(result);
        // http.Response response = await http.Response.fromStream(await request.send());
        // debugPrint(
        //     "11111111111111--------------- Image File ${response.request}");
        // debugPrint(
        //     "11111111111111--------------- Image File ${response.statusCode}");
        // debugPrint(
        //     "11111111111111--------------- Image File ${response.headers}");
        // if (response.statusCode == 200) {
        //
        //   final respStr = await response.stream.bytesToString();
        //   final result = jsonDecode(response.body);
        //   final jsonData = json.decode(response.body);
        //   var map=Map<String, dynamic>.from(jsonData);
        //   debugPrint("111-111-111-111- Response Body ${result.toString()}");
        //   return RegistrationModel.fromJson(jsonData);
        //
        // }
        //
        // else {
        //   print(response.reasonPhrase);
        //
        //
        // }
      }
    } else if (imageType == null) {
      params = {
        "name": name.toString(),
        "gender": gender.toString(),
        "type": type!.toLowerCase().toString(),
        "district": district.toString(),
        "state": state.toString(),
        "country": country.toString(),
        "continent": continent.toString(),
        "username": username.toString(),
        "dob": dob.toString(),
      };
      responseData = await dio.put(
        "users/register",
        data: FormData.fromMap(params),
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
            // HttpHeaders.acceptHeader: '*/*',
            // HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      return RegistrationModel.fromJson(responseData.data);
    }
  }

  Future uploadFameLinksPost(
      List<String> challengeId,
      BuildContext? context,
      String description,
      File closeUp,
      File medium,
      File long,
      File pose1,
      File pose2,
      File additional,
      File video,
      File? videoThumbnail,
      ambassadorTrendz,
      famelinksContest) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    // debugPrint(
    //     "111111111111----------------------- Inside Image File Select Upload${closeUp.path} ");
    debugPrint(
        "111111111111---1-------------------- Inside Image File Select Upload ");
    var headers = {'Authorization': token.toString()};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://userapi.budlinks.in/v2/media/contest'));
    print("challengeId:- $challengeId");
    if (challengeId == null && challengeId == "") {
      request.fields.addAll({
        "description": description,
        "ambassadorTrendz": ambassadorTrendz.toString(),
        "famelinksContest": famelinksContest.toString(),
      });
    } else if (challengeId != null) {
      request.fields.addAll({
        "challengeId": jsonEncode(challengeId),
        "description": description,
        "ambassadorTrendz": ambassadorTrendz.toString(),
        "famelinksContest": famelinksContest.toString(),
      });
    }
    print(request.fields);

    if (closeUp != null && closeUp.path != '') {
      File? result =
          await Provider.of<MediaCompressionProvider>(context!, listen: false)
              .compressImageFile(closeUp);

      request.files
          .add(await http.MultipartFile.fromPath('closeUp', result.path));
      File? thumnail =
          await Provider.of<MediaCompressionProvider>(context, listen: false)
              .getThumbnailImage(closeUp);
      request.files
          .add(await http.MultipartFile.fromPath('closeUp_tmb', thumnail.path));
    }
    if (medium != null && medium.path != '') {
      File? result =
          await Provider.of<MediaCompressionProvider>(context!, listen: false)
              .compressImageFile(medium);
      request.files
          .add(await http.MultipartFile.fromPath('medium', result.path));
      File? thumnail =
          await Provider.of<MediaCompressionProvider>(context, listen: false)
              .getThumbnailImage(medium);
      request.files
          .add(await http.MultipartFile.fromPath('medium_tmb', thumnail.path));
    }
    if (long != null && long.path != '') {
      File? result =
          await Provider.of<MediaCompressionProvider>(context!, listen: false)
              .compressImageFile(long);
      request.files.add(await http.MultipartFile.fromPath('long', result.path));
      File? thumnail =
          await Provider.of<MediaCompressionProvider>(context, listen: false)
              .getThumbnailImage(long);
      request.files
          .add(await http.MultipartFile.fromPath('long_tmb', thumnail.path));
    }
    if (pose1 != null && pose1.path != '') {
      File? result =
          await Provider.of<MediaCompressionProvider>(context!, listen: false)
              .compressImageFile(pose1);
      request.files
          .add(await http.MultipartFile.fromPath('pose1', result.path));
      File? thumnail =
          await Provider.of<MediaCompressionProvider>(context, listen: false)
              .getThumbnailImage(pose1);
      request.files
          .add(await http.MultipartFile.fromPath('pose1_tmb', thumnail.path));
    }
    if (pose2 != null && pose2.path != '') {
      File? result =
          await Provider.of<MediaCompressionProvider>(context!, listen: false)
              .compressImageFile(pose2);
      request.files
          .add(await http.MultipartFile.fromPath('pose2', result.path));
      File? thumnail =
          await Provider.of<MediaCompressionProvider>(context, listen: false)
              .getThumbnailImage(pose2);
      request.files
          .add(await http.MultipartFile.fromPath('pose2_tmb', thumnail.path));
    }
    if (additional != null && additional.path != '') {
      File? result =
          await Provider.of<MediaCompressionProvider>(context!, listen: false)
              .compressImageFile(additional);
      request.files
          .add(await http.MultipartFile.fromPath('additional', result.path));

      File thumnail =
          await Provider.of<MediaCompressionProvider>(context, listen: false)
              .getThumbnailImage(additional);
      request.files.add(
          await http.MultipartFile.fromPath('additional_tmb', thumnail.path));
    }
    if (video != null && video.path != '') {
      request.files.add(await http.MultipartFile.fromPath('video', video.path));
    }
    if (videoThumbnail != null && videoThumbnail.path != '') {
      request.files.add(
          await http.MultipartFile.fromPath('video_tmb', videoThumbnail.path));
    }

    // print(request.fields);
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    debugPrint("11111111111111--------------- Image File ${response.request}");
    debugPrint(
        "11111111111111--------------- Image File ${response.statusCode}");
    debugPrint("11111111111111--------------- Image File ${response.headers}");
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body.toString());
      showSnackBar(
          context: context!,
          message: '${responseJson['message']}',
          isError: false);
      DateTime date = DateTime.now();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          "fameContest",
          famelinksContest.toString() +
              "/" +
              DateFormat('dd-MMM-yyyy').format(date));
      await prefs.setString(
          "ambContest",
          ambassadorTrendz.toString() +
              "/" +
              DateFormat('dd-MMM-yyyy').format(date));

      return 0;
    } else {
      var responseJson = json.decode(response.body.toString());
      showSnackBar(
          context: context!,
          message: '${responseJson['message']}',
          isError: true);
      return 1;
    }
  }

  Future<CountryResponse?> getCountry(String search) async {
    Response response = await dio.get("location/countries?continent=${search}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      return CountryResponse.fromJson(response.data);
    }
    return null;
  }

  Future<StateResponse?> getStates(String search) async {
    Response response = await dio.get("location/states?country=${search}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      return StateResponse.fromJson(response.data);
    }
    return null;
  }

  Future<DistrictResponse?> getDistrict(String search, String state) async {
    Response response =
        await dio.get("location/districts?country=${search}&state=${state}",
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
    if (response != null) {
      return DistrictResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UsernameCheckModel?> checkUsername(String search) async {
    Response response = await dio.get("users/check/username/${search}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      return UsernameCheckModel.fromJson(response.data);
    }
    return null;
  }

  Future<LikesResponse?> upadateProfilePic(map) async {
    Response response = await dio.put("users/profile/image/upload",
        data: FormData.fromMap(map));
    if (response != null) {
      return LikesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UpdateContestResponse?> oneTimeRegisterService(
      Map<String, dynamic> map, dynamic dob) async {
    map = {"contest": json.encode(map), "dob": 25 - 12 - 1995};
    try {
      Response response =
          await dio.put("media/contest", data: FormData.fromMap(map));
      if (response != null)
        return UpdateContestResponse.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response!.data);
      print(e.response!.headers);
    }
  }

  Future<UpdateContestResponse?> updateContestService(
      String desc, String challengeId) async {
    var formData = FormData.fromMap({
      "challengeId": challengeId,
      "description": desc,
      // "isFollowlink":isFollowlink == "followLinks"?true:false,
      "closeUp": Constants.closeUp,
      "medium": Constants.medium,
      "long": Constants.long,
      "pose1": Constants.pose1,
      "pose2": Constants.pose2,
      "additional": Constants.additional,
      "video": Constants.video,
    });
    print("UPLOAD:::${challengeId}");
    try {
      Response response = await dio.post("media/contest", data: formData);
      if (response != null)
        return UpdateContestResponse.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response!.data);
      print(e.response!.headers);
    }
  }

  Future<int> uploadFunLink(
      String? desc,
      List<String?> challengeId,
      String? musicId,
      String? musicName,
      File? video,
      File? audio,
      File? thumbnail,
      BuildContext? context,
      bool? userProfile,
      tags,
      talentCategory) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    //print("============$challengeId");
    var headers = {
      'Authorization': token.toString(),
    };
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("https://userapi.budlinks.in/v2/media/funlinks"));
      if (musicId != null && musicName != null) {
        request.fields.addAll({
          "challenges": jsonEncode(challengeId),
          "musicId": 'null',
          "musicName": musicName,
          "tags": jsonEncode(tags),
          "talentCategory": jsonEncode(talentCategory),
        });
      } else {
        request.fields.addAll({
          'description': desc ?? '',
          "challenges": jsonEncode(challengeId),
          "tags": jsonEncode(tags),
          "talentCategory": jsonEncode(talentCategory),
        });
      }
      print("Result: ${request.fields}");
      request.files
          .add(await http.MultipartFile.fromPath('video', video!.path));
      request.files
          .add(await http.MultipartFile.fromPath('audio', audio!.path));
      if (thumbnail != null) {
        request.files.add(
            await http.MultipartFile.fromPath('thumbnail', thumbnail.path));
      }
      request.headers.addAll(headers);
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body.toString());
        showSnackBar(
            context: context!,
            message: '${responseJson['message']}',
            isError: false);
        if (userProfile == true) {
          gotoProfileFunLinksScreen(context);
        } else {
          gotoFunLinksUserProfileScreen(context);
        }
        return 1;
      } else {
        var responseJson = json.decode(response.body.toString());
        showSnackBar(
            context: context!,
            message: '${responseJson['message']}',
            isError: true);
        print(response.body);
      }
    } catch (e) {
      showSnackBar(
          context: context!, message: '${e.toString()}', isError: true);
    }
    return 0;
  }

  // Future<int> uploadFollowLink(
  //     String desc, String challengeId,  String musicId, File video,BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString("token");
  //   var headers = {
  //     'Authorization': token.toString(),
  //   };
  //   try{
  //     var request = http.MultipartRequest(
  //         'POST', Uri.parse("https://userapi.budlinks.in/v2/media/funlinks"));
  //     if (musicId != null) {
  //       // formData = FormData.fromMap({
  //       //   "challenges": challengeId,
  //       //   "description": desc,
  //       //   "video": Constants.video,
  //       //   "musicId": musicId,
  //       // });
  //       request.fields.addAll({
  //         "challenges": challengeId,
  //         "description": desc,
  //         "musicId": musicId,
  //       });
  //       print("Result: ${request.fields}");
  //       request.files.add(await http.MultipartFile.fromPath('video',video.path ));
  //       request.headers.addAll(headers);
  //       http.Response response = await http.Response.fromStream(await request.send());
  //       if (response.statusCode==200) {
  //         gotoFunLinksUserProfileScreen(context);
  //         return 1;
  //       }
  //     }
  //     else {
  //       request.fields.addAll({
  //         "challenges": challengeId,
  //         "description": desc,
  //       });
  //       print("Result: ${request.fields}");
  //       print("Result: ${video.path}");
  //       request.files.add(await http.MultipartFile.fromPath('video',video.path));
  //       request.headers.addAll(headers);
  //       http.Response response = await http.Response.fromStream(await request.send());
  //       print("Result: ${response.statusCode}");
  //       if (response.statusCode==200) {
  //         gotoFunLinksUserProfileScreen(context);
  //         return 1;
  //       }
  //     }
  //   }catch(e){
  //     debugPrint('0-0-0-0-0-0-0-0-0-0-0-0-0- updateUser Error ${e.toString()}');
  //   }
  //   //print("PARAMS:::${formData}");
  //   // try {
  //   //   Response response = await dio.post("media/funlinks", data: formData, options: Options(headers: {
  //   //     HttpHeaders.authorizationHeader: token,
  //   //   }),);
  //   //   if (response != null)
  //   //     return 0;
  //   // } on DioError catch (e) {
  //   //   print(e.response.data);
  //   //   print(e.response.headers);
  //   // }
  // }

  Future<int?> uploadFollowLink(
      String desc,
      List<String> challengeId,
      List<File> imageList,
      List<File> thumnaiList,
      BuildContext context,
      bool userProfile,
      tags) async {
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse("https://userapi.budlinks.in/v2/media/followlinks"));
      print(request);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      var headers = {
        'Authorization': token.toString(),
      };

      request.fields.addAll({
        "description": desc,
        "challenges": jsonEncode(challengeId),
        "tags": tags == null ? '' : jsonEncode(tags),
      });
      for (var images in imageList) {
        request.files
            .add(await http.MultipartFile.fromPath('media', images.path));
      }
      for (var thumbnails in thumnaiList) {
        request.files.add(
            await http.MultipartFile.fromPath('thumbnail', thumbnails.path));
      }
      request.headers.addAll(headers);
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body.toString());
        showSnackBar(
            context: context,
            message: '${responseJson['message']}',
            isError: false);
        print(response.body);
        if (userProfile == true) {
          gotoProfileFollowLinksScreen(context);
        } else {
          gotoFollowLinksUserProfileScreen(context);
        }
        return 1;
      } else {
        var responseJson = json.decode(response.body.toString());
        showSnackBar(
            context: context,
            message: '${responseJson['message']}',
            isError: true);
        print(response.body);
      }
    } catch (e) {
      // print(e.response!.data);
      // print(e.response!.headers);
    }
  }

  Future<FollowResponse?> verifyProfile() async {
    var formData = FormData.fromMap({
      "video": Constants.video,
    });
    try {
      Response response =
          await dio.post("users/profile/verify", data: formData);
      if (response != null) return FollowResponse.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response!.data);
      print(e.response!.headers);
    }
  }

  //
  // Future<UpdateUserResponse> updateUserService(Map<String, dynamic> map) async {
  //   Response response = await dio.put("users/update", data: map);
  //   if (response != null) {
  //     return UpdateUserResponse.fromJson(response.data);
  //   }
  //   return null;
  // }
  //
  // Future<OneUserResponse> getOneUserService(int userId) async {
  //   Response response = await dio.get("users/$userId");
  //   if (response != null) {
  //     return OneUserResponse.fromJson(response.data);
  //   }
  //   return null;
  // }

  Future<MyNotificationResponse?> getnotificationService(int page) async {
    Response response = await dio.get("users/notifications?page=${page}");
    if (response != null) {
      return MyNotificationResponse.fromJson(response.data);
    }
    return null;
  }

  Future<ProfileResponse?> myProfile(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get(
      "users/me",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    if (response != null) {
      return ProfileResponse.fromJson(response.data);
    }
  }

  Future<ProfileResponse?> myInfoService(String userId) async {
    Response response = await dio.get("users/${userId}");
    if (response != null) {
      return ProfileResponse.fromJson(response.data);
    }
    return null;
  }

  Future<OneUserResponse?> oneUserService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic userId = prefs.getString('userId');
    Response response = await dio.get("users/$userId");
    if (response != null) {
      return OneUserResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FamelinksResponse?> fameLinksService(
      BuildContext context, int page) async {
    Response response = await dio.get("media/famelinks?page=${page}");
    if (response != null) {
      return FamelinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FunLinksResponse?> funLinksService(int page) async {
    Response response = await dio.get("media/funlinks?page=${page}");
    if (response != null) {
      return FunLinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FamelinksResponse?> followLinksService(int page) async {
    Response response = await dio.get("media/followlinks?page=${page}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      return FamelinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<ChallengesResponse?> getChallenges() async {
    Response response = await dio.get("challenges/open/famelinks");
    if (response != null) {
      return ChallengesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<ChallengesResponse?> getFunlinksChallenges() async {
    Response response = await dio.get("challenges/open/funlinks");
    if (response != null) {
      return ChallengesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FamelinksResponse?> getChallenge(String challengeId, int page) async {
    Response response =
        await dio.get("challenges/${challengeId}/famelinks?page=${page}");
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return FamelinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<MyFunLinksResponse?> getFunLinksChallenge(
      String challengeId, int page) async {
    Response response =
        await dio.get("challenges/${challengeId}/funlinks?page=${page}");
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return MyFunLinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<CommentListResponse?> getCommentService(
      String mediaId, String type, int page) async {
    Response response =
        await dio.get("media/${type}/comment/${mediaId}?page=${page}",
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return CommentListResponse.fromJson(response.data);
    }
    return null;
  }

  /*Future<CommentListResponse> getFunLinksComments(String mediaId, int page) async {
    Response response = await dio.get("media/funlinks/comment/${mediaId}?page=${page}");
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return CommentListResponse.fromJson(response.data);
    }
    return null;
  }*/
  Future<CommentListResponse?> getCommentReplies(
      String mediaId, String type, int page) async {
    Response response =
        await dio.get("media/${type}/comment/${mediaId}/replies?page=${page}",
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return CommentListResponse.fromJson(response.data);
    }
    return null;
  }

  /*Future<CommentListResponse> getFunLinksCommentReplies(String mediaId, int page) async {
    Response response = await dio.get("media/funlinks/comment/${mediaId}/replies?page=${page}");
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return CommentListResponse.fromJson(response.data);
    }
    return null;
  }*/
  Future<UnfollowResponse?> deleteComment(String commentId, String type) async {
    Response response = await dio.delete("media/${type}/comment/${commentId}");
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }

  /*Future<UnfollowResponse> deleteFunLinksComment(String commentId) async {
    Response response = await dio.delete("media/funlinks/comment/${commentId}");
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }*/
  Future<UnfollowResponse?> deleteFameLinksMedia(
      String postId, String mediaType) async {
    Response response =
        await dio.delete("media/famelinks/${postId}/${mediaType}",
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UnfollowResponse?> deleteFunLinksPost(
      String postId, BuildContext context) async {
    Response response = await dio.delete("media/funlinks/$postId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      // showSnackBar(context: context, message: response.data['message'], isError: false);
      print("DATA::${response.data.toString()}");
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UnfollowResponse?> deleteFameLinksPost(
      String postId, BuildContext context) async {
    Response response = await dio.delete("media/famelinks/${postId}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UnfollowResponse?> deleteFollowLinksPost(
      String postId, BuildContext context) async {
    Response response = await dio.delete("media/followlinks/${postId}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      //showSnackBar(context: context, message: response.data['message'], isError: false);
      print("DATA::${response.data.toString()}");
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UnfollowResponse?> deleteFollowLinksMedia(
      String postId, String mediaType) async {
    Response response =
        await dio.delete("media/followlinks/${postId}/${mediaType}",
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
    if (response != null) {
      print("DATA::${response.data.toString()}");
      return UnfollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<CommentAddResponse?> addCommentService(
      String mediaId, String type, params) async {
    Response response = await dio.post("media/${type}/comment/${mediaId}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params));
    if (response != null) {
      return CommentAddResponse.fromJson(response.data);
    }
    return null;
  }

  /*Future<CommentAddResponse> addFunLinksComment(String mediaId,params) async {
    Response response = await dio.post("media/funlinks/comment/${mediaId}",options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    }), data: jsonEncode(params));
    if (response != null) {
      return CommentAddResponse.fromJson(response.data);
    }
    return null;
  }*/

  Future<FamelinksResponse?> myFameLinksService(String userId, int page) async {
    Response response = await dio.get("media/famelinks/${userId}?page=${page}");
    if (response != null) {
      return FamelinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FameLinkResponse?> myFameLinkPost(String userId, String type) async {
    Response response = await dio.get("media/${type}/single/${userId}");
    if (response != null) {
      return FameLinkResponse.fromJson(response.data);
    }
    return null;
  }

  Future<MyFunLinksResponse?> otherFunLinksService(
      String userId, int page) async {
    Response response = await dio.get("media/funlinks/${userId}?page=${page}");
    if (response != null) {
      return MyFunLinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FamelinksResponse?> myFollowLinksService(
      String userId, int page) async {
    Response response =
        await dio.get("media/followlinks/${userId}?page=${page}");
    if (response != null) {
      return FamelinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<MyFunLinksResponse?> myFunLinksService(int funLinksPage) async {
    Response response = await dio.get("media/funlinks/me?page=${funLinksPage}");
    if (response != null) {
      return MyFunLinksResponse.fromJson(response.data);
    }
    return null;
  }

  Future<ContestantResponse?> getContestants(
      int page,
      String type,
      String district,
      String state,
      String country,
      String continent,
      String gender,
      String ageGroup) async {
    Response response = await dio.get(
        "users/contestants?page=${page}${type.isEmpty ? "" : "&type=${type}"}${district.isEmpty ? "" : "&district=${district}"}${state.isEmpty ? "" : "&state=${state}"}${country.isEmpty ? "" : "&country=${country}"}${continent.isEmpty ? "" : "&continent=${continent}"}${gender.isEmpty ? "" : "&gender=${gender}"}${ageGroup.isEmpty ? "" : "&ageGroup=${ageGroup}"}");
    if (response != null) {
      return ContestantResponse.fromJson(response.data);
    }
    return null;
  }

  Future<MyChallengesResponse?> myChallengesService() async {
    Response response =
        await dio.get("media/challenges/me?page=${Constants.page}");
    if (response != null) {
      return MyChallengesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> addReportPost(mediaId, params) async {
    Response response = await dio.post("users/report/post/${mediaId}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> addReferCode(params) async {
    print("REFER:::${params.toString()}");
    Response response = await dio.post("refer/apply",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> blockUser(mediaId) async {
    Response response = await dio.post("users/block/${mediaId}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UserUpdatedResponse?> addReportComment(mediaId, params) async {
    Response response = await dio.post("users/report/comment/${mediaId}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params));
    if (response != null) {
      return UserUpdatedResponse.fromJson(response.data);
    }
    return null;
  }

  Future<OpenChallengesResponse?> openChallengesService() async {
    Response response = await dio.get("challenges/dashboard/open");
    if (response != null) {
      return OpenChallengesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<OpenChallengesResponse?> getFunLinksExploreChallenge(page) async {
    Response response =
        await dio.get("challenges/funlinks/explore?page=${page}");
    if (response != null) {
      return OpenChallengesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<UpcomingChallengesResponse?> upcomingChallengesService(
      int page) async {
    Response response =
        await dio.get("challenges/upcoming/famelinks?page=${page}");
    if (response != null) {
      return UpcomingChallengesResponse.fromJson(response.data);
    }
    return null;
  }

  Future<MyFollowersResponse?> myfollowersService(
      String userId, int page) async {
    Response response = await dio.get("users/${userId}/followers?page=${page}");
    if (response != null) {
      return MyFollowersResponse.fromJson(response.data);
    }
    return null;
  }

  Future<ConversationModel?> getChatUser(int page) async {
    Response response = await dio.get("chats/me?page=${page}");
    if (response != null) {
      return ConversationModel.fromJson(response.data);
    }
    return null;
  }

  Future<ChatUserModel?> getChatUserRequests(int page) async {
    Response response = await dio.get("chats/requests?page=${page}");
    if (response != null) {
      return ChatUserModel.fromJson(response.data);
    }
    return null;
  }

  Future<ChatMessageModel?> getChatUserMessages(String chatId, int page) async {
    Response response = await dio.get("chats/${chatId}/messages?page=${page}");
    if (response != null) {
      return ChatMessageModel.fromJson(response.data);
    }
    return null;
  }

  Future<FollowResponse?> acceptChatRequest(String chatId, accept) async {
    var formData = {
      "accept": accept,
    };
    Response response = await dio.patch("chats/requests/${chatId}/action",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: formData);
    if (response != null) {
      return FollowResponse.fromJson(response.data);
    }
    return null;
  }

  Future<SearchResponse?> searchUser(int page, String search) async {
    Response response =
        await dio.get("users/search?page=${page}&search=${search}");
    if (response != null) {
      return SearchResponse.fromJson(response.data);
    }
    return null;
  }

  Future<FunLinksSongs?> getSongs(page) async {
    Response response = await dio.get("media/funlinks/songs?page=${page}");
    if (response != null) {
      return FunLinksSongs.fromJson(response.data);
    }
    return null;
  }

  Future<MyFollowersResponse?> myfollowingService(
      String userId, int page) async {
    Response response = await dio.get("users/${userId}/followees?page=${page}");
    if (response != null) {
      return MyFollowersResponse.fromJson(response.data);
    }
    return null;
  }

  Future<MyFollowersResponse?> mysuggestionsService(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Response response = await dio.get("users/follow/suggestions?page=${page}",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: token,
          },
        ));
    if (response != null) {
      return MyFollowersResponse.fromJson(response.data);
    }
    return null;
  }

// Future<CommentsResponse> commentsService() async {
//   dynamic mediaId = Constants.mediaId;
//   Response response = await dio.get("media/comment/$mediaId?page=1");
//   if (response != null) {
//     return CommentsResponse.fromJson(response.data);
//   }
//   return null;
// }

// Future<OpenChallengesResponse> challengesService() async {
//   Response response = await dio.get("challenges/open");
//   if (response != null) {
//     return OpenChallengesResponse.fromJson(response.data);
//   }
//   return null;
// }
//

//
// Future<FeedbackResponse?> feedBackService(Map<String, dynamic> map) async {
//   Response response = await dio.post("users/feedback", data: map);
//   if (response != null) {
//     return FeedbackResponse.fromJson(response.data);
//   }
//   return null;
// }

  // Get FameLinks Details

  setsharefame(Map<String, dynamic> famelist) {
    mydata.add(famelist);
  }

  bool famenewpost = false;
  List mydata = [];
  List fameads = [];

  Future<FameLinkUserProfileModel?> getFameLinksProfile(int page) async {
    fameads = [];
    mydata = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? famedatelast;
    String? famedatefirst;
    if (prefs.getInt("fameFeedPage") == null) {
      prefs.setInt("fameFeedPage", 1);
      famedatelast = "";
      famedatefirst = "";
    } else {
      famedatefirst =
          "&famelinksfirstDate=${prefs.getString("famelinksfirstDate")}";
      famedatelast =
          "&famelinkslastDate=${prefs.getString("famelinkslastDate")}";
      int? pag = prefs.getInt("fameFeedPage");
      prefs.setInt("fameFeedPage", pag! + 1);
    }
    int? pagination = prefs.getInt("fameFeedPage");
    // int pagination = 1;
    String? token = prefs.getString("token");
    var response = await dio.get(
      "media/famelinks?page=$page",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    log("getFameLinkProfileAPI ${response.data}");
    if (response != null) {
      //log(response.data.toString());
      if (response.data['result'].length > 0) {
        prefs.setString("famelinksfirstDate",
            response.data['result'].last['createdAt'].toString());
        if (pagination == 1) {
          prefs.setString("famelinkslastDate",
              response.data['result'].first['createdAt'].toString());
        }
        Localdata().sethivedata(response.data, "getFameLinksProfile");
      }

      // response.data['result'].forEach((value) {
      //   fameads.add(value);
      // });83

      fameads.addAll(response.data['result']);
      // log("logfameads ${fameads.length}");
      for (var i = 0; i < fameads.length; i++) {
        if (i % 6 == 0 && fameads[i]['media'][0]['type'] != "ads" && i != 0) {
          mydata.insert(i, NativeadsApp.adslist);
          mydata.add(fameads[i]);
        } else {
          mydata.add(fameads[i]);
        }
      }
      log("am123 $mydata");
      Map<String, dynamic> data1 = {"result": mydata};
      //return null;
      return FameLinkUserProfileModel.fromJson(data1);
      // return FameLinkUserProfileModel.fromJson(response.data);
    }
    return null;
  }

  List fundata = [];
  List funads = [];

  Future<FunLinkUserProfileModel?> getFunLinksProfile(int page) async {
    funads = [];
    fundata = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fundate = "";
    String? fundate2 = "";
    if (prefs.getInt("funFeedPage") == null) {
      prefs.setInt("funFeedPage", 1);
      fundate = "";
      fundate2 = "";
    } else {
      fundate = "&funlinksfirstDate=${prefs.getString("fundate")}";
      fundate = "&funlinkslastDate=${prefs.getString("fundate2")}";
      int? pag = prefs.getInt("funFeedPage");
      prefs.setInt("funFeedPage", pag! + 1);
    }
    int? pgination = prefs.getInt("funFeedPage");

    String? token = prefs.getString("token");
    debugPrint('1-1-1-1-1-1 getLocation Token ${token.toString()}');
    Response response = await dio.get(
      "media/funlinks?page=$page ",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    log("getFunLinkProfileAPI ${response.data}");
    if (response.data['result'].length > 0) {
      Localdata().sethivedata(response.data, "getFunLinksProfile");
      prefs.setString(
          "fundate2", response.data['result'].last['createdAt'].toString());
      if (pgination == 1) {
        prefs.setString(
            "fundate", response.data['result'].first['createdAt'].toString());
      }
    }
    funads.addAll(response.data['result']);

    for (var i = 0; i < funads.length; i++) {
      if (i % 6 == 0 && funads[i]['media'][0]['type'] != "ads" && i != 0) {
        fundata.insert(i, NativeadsApp.funadslist);

        fundata.add(funads[i]);
      } else {
        fundata.add(funads[i]);
      }
    }
    log("am123 $fundata");
    Map<String, dynamic> data1 = {"result": fundata};

    return FunLinkUserProfileModel.fromJson(data1);

    //return null;
  }

  List followdata = [];
  List followads = [];

  Future<FollowLinkUserProfileModel?> getFollowLinksProfile(int page) async {
    followads = [];
    followdata = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? followdate = "";
    String? followdate2 = "";
    if (prefs.getInt("followFeedPage") == null) {
      prefs.setInt("followFeedPage", 1);
      followdate = "";
      followdate2 = "";
    } else {
      followdate = "&followlinksfirstDate=${prefs.getString("followdate")}";
      followdate2 = "&followlinkslastDate=${prefs.getString("followdate2")}";
      int? pag = prefs.getInt("followFeedPage");
      prefs.setInt("followFeedPage", pag! + 1);
    }
    int? pgination = prefs.getInt("fameFeedPage");
    // int? pgination = 1;
    String? token = prefs.getString("token");
    debugPrint('1-1-1-1-1-1 getLocation Token ${token.toString()}');
    Response response = await dio.get(
      "media/followlinks?page=$page",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      ),
    );
    log("getFollowLinkProfileAPI ${response.data}");
    if (response.data['result'].length > 0) {
      Localdata().sethivedata(response.data, "getFollowLinksProfile");
      prefs.setString(
          "followdate", response.data['result'].last['createdAt'].toString());
      if (pgination == 1) {
        prefs.setString(
            "followdate2", response.data['result'][0]['createdAt'].toString());
      }
      followads.addAll(response.data['result']);

      for (var i = 0; i < followads.length; i++) {
        if (i % 6 == 0 && followads[i]['media'][0]['type'] != "ads" && i != 0) {
          followdata.insert(i, NativeadsApp.adslist);

          followdata.add(followads[i]);
        } else {
          followdata.add(followads[i]);
        }
      }

      Map<String, dynamic> data1 = {"result": followdata};

      return FollowLinkUserProfileModel.fromJson(data1);
    }
    return null;
  }

// Future<File?> compressAndGetFile(
//     File file,
//     String targetPath,
//     ) async {
//   print("file=$file");
//   print("file=$targetPath");
//
//  // Directory? directory = await getExternalStorageDirectory();
//   //
//   // print("Directory$directory");
//
//   //
//   // final myImagePath = '${directory!.path}/MyImages' ;
//   //
//   // print("newPath$myImagePath");
//   //
//   // final myImgDir = await new Directory(myImagePath).create();
//   // final myImagePath1 = File('${myImgDir.path}/${baseName}') ;
//   // print("newPath=======$myImagePath1");
//   String baseName = basename(targetPath);
//   print(baseName);
//   Directory? directory = await getExternalStorageDirectory();
//   String appDocumentsPath = directory!.path;
//   String filePath = '$appDocumentsPath/image.jpg';
//   print("filePath===========$filePath");
//   var result = await FlutterImageCompress.compressAndGetFile(
//     file.absolute.path,
//     filePath,
//     quality: 88,
//     rotate: 180,
//   );
//     // var result = await FlutterImageCompress.compressAndGetFile(
//     //   file.absolute.path,
//     //   myImagePath1.path,
//     //   quality: 88,
//     //   quality: int.parse(compressionFactor
//     //       .toString()
//     //       .substring(0, compressionFactor.toString().indexOf('.'))),
//     // );
//    // print(file.lengthSync());
//     print("result$result");
//
//     return result;
//
//
//
//
// }

}
