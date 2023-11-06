import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/providers/AuthProvider/auth_provider.dart';
import 'package:famelink/ui/FamelinkprofileWhitemode/ProfileFameLink.dart';
import 'package:famelink/ui/homedial/ui/editUserProfile.dart';
import 'package:famelink/ui/profile_UI/model/AvtarModel.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PhotoImageScreen extends StatefulWidget {
  String? getRunScreen = "";
  String? runtypes;
  String? name;
  String? pro;
  String? bio;
  String? username;
  String? district;
  String? state;
  String? country;
  String? dob;
  String? Selectedgender;

  PhotoImageScreen({
    this.getRunScreen,
    this.name,
    this.runtypes,
    this.pro,
    this.bio,
    this.username,
    this.district,
    this.state,
    this.country,
    this.dob,
    this.Selectedgender,
  });

  PhotoImageScreenState createState() => PhotoImageScreenState();
}

class PhotoImageScreenState extends State<PhotoImageScreen> {
  final ApiProvider _api = ApiProvider();
  List<AvtarModelResult> avtarModelResult = <AvtarModelResult>[];
  File? profileImageFile;
  XFile? image;
  CameraController? controller;
  List<CameraDescription>? cameras;
  PermissionStatus _permissionStatus = PermissionStatus.granted;
  Permission? _permission;

  @override
  void initState() {
    // TODO: implement initState
    loadCamera();
    print("rrrrrrrrrrrrrrrrrrrr+=======${widget.name}");
    //camera();
    getAvatarAPI();
    print(widget.runtypes.toString() + " ddddddddddddddddddd");
    super.initState();
  }

  // Future<void> requestPermission(Permission permission) async {
  //
  //   final status = await permission.request();
  //   setState(() {
  //     print("=======$status");
  //     _permissionStatus = status;
  //     print(_permissionStatus);
  //   });
  // }

  void _toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = controller!.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = cameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      controller = CameraController(newDescription, ResolutionPreset.max);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print('camera not available');
    }
  }

  void loadCamera() async {
    var permission = await Permission.camera.status;
    print("=======$permission");
    if (permission.isDenied) {
      print("=======Granted");
      final status = await Permission.camera.request();
      cameras = await availableCameras();
      CameraDescription newDescription;
      newDescription = cameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
      if (newDescription != null) {
        controller = CameraController(newDescription, ResolutionPreset.max);
        controller!.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }

      //requestPermission(_permission);
    } else {
      cameras = await availableCameras();
      CameraDescription newDescription;
      newDescription = cameras!.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
      if (newDescription != null) {
        controller = CameraController(newDescription, ResolutionPreset.max);
        controller!.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          //iconTheme: IconThemeData(),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 5, right: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new TabBar(
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.black,
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  tabs: [
                    new Tab(
                      child: Text(
                        "Photo",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Tab(
                      child: Text(
                        "Avatar",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ClickPhoto(),
            setAvtar(),
          ],
        ),
      ),
    );
  }

  void uploadPic(type, {name}) async {
    dynamic result;

    if (type == 'image') {
      result = await _api.userIndicator(
        isProfileUpdates: 'updateProfile',
        profileFile: profileImageFile!,
        types: (widget.runtypes.toString() == '0')
            ? "famelinks"
            : (widget.runtypes.toString() == '3')
                ? "joblinks"
                : (widget.runtypes.toString() == '1')
                    ? "funlinks"
                    : (widget.runtypes.toString() == '2')
                        ? "followlinks"
                        : "No Select",
      );
    } else {
      result = await _api.userIndicator(
        isProfileUpdates: 'updateProfile',
        avatarImage: name,
        types: (widget.runtypes.toString() == '0')
            ? "famelinks"
            : (widget.runtypes.toString() == '3')
                ? "joblinks"
                : (widget.runtypes.toString() == '1')
                    ? "funlinks"
                    : (widget.runtypes.toString() == '2')
                        ? "followlinks"
                        : "No Select",
      );
    }

    if (result != null) {
      if (result == true) {
        setState(() {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileFameLinkWhitemode(
                runSelectPhase: int.parse(widget.runtypes.toString()),
              ),
            ),
          );
        });
      }
    }

    // SharedPreferences prefs;
    // String token = prefs.getString("token");
    // String id = prefs.getString("id");
    // String urls = "users/profile/" + types.toString() + "/" + id.toString()+'?page=1';

    // Map<String, dynamic> params;

    // if(type == 'image'){
    //     var headers = {
    //     'Authorization': token.toString(),
    //   };
    //   var request = http.MultipartRequest('PATCH', Uri.parse("https://userapi.budlinks.in/v2/${urls}"));
    //   request.fields.addAll({
    //     'profileImageType': type
    //   });
    //   request.files.add(await http.MultipartFile.fromPath('profileImage', profileImageFile.path));
    //   request.headers.addAll(headers);
    //   http.Response response = await http.Response.fromStream(await request.send());

    //   if(response.statusCode == 200){
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => ProfileFameLink(
    //           runSelectPhase: int.parse(widget.runtypes.toString()),
    //         ),
    //       ),
    //     );
    //   }
    // }else{

    // }

    // params = {
    //           'profileImage': name.split('/').last,
    //           'profileImageType':'avatar'
    //         };
    //         Response response = await dio.patch(
    //           urls,
    //           data: FormData.fromMap(params),
    //           options: Options(
    //             headers: {
    //               HttpHeaders.authorizationHeader: token,
    //               HttpHeaders.acceptHeader: '*/*',
    //               // HttpHeaders.contentTypeHeader: "application/json",
    //             },
    //           ),
    //         )
  }

  Widget ClickPhoto() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                if (widget.getRunScreen.toString() == 'banner') {
                  FormData formData = FormData.fromMap({});
                  formData.files.addAll([
                    MapEntry("media",
                        await MultipartFile.fromFile(profileImageFile!.path)),
                  ]);
                  Api.uploadPost.call(context,
                      method: "users/banner/upload",
                      param: formData, onResponseSuccess: (Map object) {
                    Navigator.pop(context);
                    var snackBar = SnackBar(
                      content: Text('Uploaded'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                } else if (widget.getRunScreen.toString() ==
                    "editProfileImage") {
                  uploadPic('image');
                } else if (widget.getRunScreen.toString() == "editProfile") {
                  setState(() {
                    //EditUserProfileState.isProfileUpdate = true;
                    //EditUserProfileState.selectAvatar = "_";
                    EditUserProfileState.selectAvatarType = "file";
                    EditUserProfileState.selectImageFilePath =
                        profileImageFile!;
                  });
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUserProfile(
                        bio: widget.bio!,
                        country: widget.country!,
                        district: widget.district!,
                        state: widget.state!,
                        dob: widget.dob!,
                        imageType: "image",
                        imageTypeFromEdit: "editImage",
                        name: widget.name!,
                        profession: widget.pro!,
                        isProfileUpdate: true,
                        userName: widget.username.toString(),
                        runType: int.parse(widget.runtypes.toString()),
                      ),
                    ),
                  );
                  debugPrint("0------- dISTI ${widget.district}");
                  debugPrint("0------- State ${widget.state}");
                  debugPrint("0------- country ${widget.country}");
                } else if (widget.getRunScreen.toString() == "editImage") {
                  // setState(() {
                  //   HomeDialState.selectAvatar = "tyuiop";
                  //   HomeDialState.selectImageFile =
                  //       File(profileImageFile.path);
                  //   HomeDialState.selectAvatarStatus = "localfile";
                  //
                  // });
                  // debugPrint("111-111-111-111-111- ${HomeDialState.selectAvatar}");
                  // debugPrint("111-111-111-111-111- ${HomeDialState.selectImageFile.path}");
                  // debugPrint("111-111-111-111-111- ${HomeDialState.selectAvatarStatus}");
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileFameLinkWhitemode(
                        runSelectPhase: int.parse(widget.runtypes.toString()),
                      ),
                    ),
                  );
                } else if (widget.runtypes.toString() == "register") {
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .selectProfilePic(profileImageFile!);
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .selectAvatarPicStatus("localfile");

                  // Navigator.pop(context);
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: 30,
                width: 90,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Upload.png"))),
                child: Center(
                    child: Text(
                  "Upload",
                  style: GoogleFonts.nunitoSans(fontSize: 16),
                )),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        AspectRatio(
          aspectRatio: 1 / 0.9,
          child: profileImageFile == null
              ? controller != null && controller!.value.isInitialized
                  ? ClipRect(
                      child: Transform.scale(
                        scale: 1 / 0.6,
                        child: Center(
                          child: CameraPreview(controller!),
                        ),
                      ),
                    )
                  : Container()
              : Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: ClipRect(
                    child: Transform.scale(
                      scale: 1 / 0.6,
                      child: Center(
                        child: Image.file(
                          profileImageFile!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
        ),

        // Container(
        //         height: 256,
        //         width: 256,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             color: Colors.black),
        //         child: Image.file(
        //           File(profileImageFile.path),
        //           fit: BoxFit.fill,
        //         )),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _toggleCameraLens();
                  });
                },
                child: Image.asset(
                  'assets/icons/camerarotation.png',
                  height: 40,
                  width: 40,
                ),
                // child: Container(
                //   height: 55.h,
                //   width: 55.w,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: lightGray,
                //   ),
                //   child: Icon(Icons.cameraswitch, color: Colors.black,)
                // ),
              ),
              InkWell(
                onTap: () {
                  onTakePictureButtonPressed();
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/imageCapture.png",
                      height: 60,
                      width: 60,
                    ),
                    Text(
                      "Capture",
                      style: GoogleFonts.nunitoSans(
                          fontStyle: FontStyle.italic, fontSize: 12),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  gallary();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.black45),
                          image: DecorationImage(
                              image: AssetImage("assets/images/add.png"))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Gallary",
                        style: GoogleFonts.nunitoSans(
                            fontStyle: FontStyle.italic, fontSize: 12))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget setAvtar() {
    return avtarModelResult.length == 0
        ? Container()
        : GridView.builder(
            itemCount: avtarModelResult.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if (widget.getRunScreen.toString() == "editProfileImage") {
                    uploadPic('avatar',
                        name: avtarModelResult[index].name.toString());
                  } else if (widget.getRunScreen == "editProfile") {
                    setState(() {
                      //EditUserProfileState.isProfileUpdate = true;
                      EditUserProfileState.selectAvatar =
                          avtarModelResult[index].name.toString();
                      EditUserProfileState.selectAvatarType = "avatar";
                    });
                    debugPrint(
                        "1-1-1-1-1-1-1-1 SetAvatar ${avtarModelResult[index].name.toString()}");
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserProfile(
                          bio: widget.bio!,
                          country: widget.country!,
                          district: widget.district!,
                          state: widget.state!,
                          dob: widget.dob!,
                          imagUrl: avtarModelResult[index].name.toString(),
                          imageType: "avatar",
                          imageTypeFromEdit: "editAvatar",
                          name: widget.name!,
                          profession: widget.pro!,
                          isProfileUpdate: true,
                          userName: widget.username.toString(),
                          runType: int.parse(widget.runtypes.toString()),
                        ),
                      ),
                    );
                  } else if (widget.getRunScreen.toString() == "editImage") {
                    // setState(() {
                    //   HomeDialState.selectAvatar =
                    //       avtarModelResult[index].name.toString();
                    //   HomeDialState.selectAvatarStatus = "localAvatar";
                    //
                    // });
                    // debugPrint("111-111-111-111-111- ${HomeDialState.selectAvatar}");
                    // debugPrint("111-111-111-111-111- ${HomeDialState.selectImageFile.path}");
                    // debugPrint("111-111-111-111-111- ${HomeDialState.selectAvatarStatus}");
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileFameLinkWhitemode(
                          runSelectPhase: int.parse(widget.runtypes.toString()),
                        ),
                      ),
                    );
                  } else if (widget.runtypes == "register") {
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .selectAvatarPic(
                            avtarModelResult[index].name.toString());
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .selectAvatarPicStatus("localAvatar");
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    "${ApiProvider.s3UrlPath}/${ApiProvider.avatar}/${avtarModelResult[index].name}",
                    fit: BoxFit.fill,
                    width: 100,
                    height: 100,
                  ),
                ),
              );
            },
          );
  }

  Future<List<AvtarModel>?> getAvatarAPI() async {
    var result = await _api.getAvtarData();
    if (result != null) {
      setState(() {
        if (result.success.toString() == 'true') {
          print(result.avtarResult);
          avtarModelResult.addAll(result.avtarResult!);
          // return avatarModelResult;
        } else {
          Constants.toastMessage(msg: result.message!);
          // return avtarModelResult!;
        }
      });
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController cameraController = controller!;
    if (cameraController == null || !cameraController.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      //_showCameraException(e);
      return null;
    }
  }

  void onTakePictureButtonPressed() {
    //requestPermission(_permission);
    takePicture().then((XFile? file) {
      profileImageFile = File(file!.path);
      if (profileImageFile != null) {
        _cropImage().then((value) async {
          Constants.profileImage = await MultipartFile.fromFile(
              profileImageFile!.path,
              filename: "${File(file.path).path.split('/').last}");
          setState(() {
            profileImageFile = value;
          });
        });
      }
      if (file != null) {
        print('Picture saved to ${file.path}');
      }
    });
  }

  Future<File?> _cropImage() async {
    return await ImageCropper().cropImage(
        //  cropStyle: CropStyle.circle,
        maxHeight: 200,
        maxWidth: 200,
        sourcePath: profileImageFile!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        // != null
        //     ? [
        //         CropAspectRatioPreset.square,
        //         CropAspectRatioPreset.ratio3x2,
        //         CropAspectRatioPreset.original,
        //         CropAspectRatioPreset.ratio4x3,
        //         CropAspectRatioPreset.ratio16x9
        //       ]
        //     : [
        //         CropAspectRatioPreset.original,
        //         CropAspectRatioPreset.square,
        //         CropAspectRatioPreset.ratio3x2,
        //         CropAspectRatioPreset.ratio4x3,
        //         CropAspectRatioPreset.ratio5x3,
        //         CropAspectRatioPreset.ratio5x4,
        //         CropAspectRatioPreset.ratio7x5,
        //         CropAspectRatioPreset.ratio16x9
        //       ],
        androidUiSettings: AndroidUiSettings(
            showCropGrid: true,
            // cropFrameStrokeWidth: 200,
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
  }

  // Future<void> stopCamera() async {
  //   final CameraController cameraController = controller;
  //
  //   if (cameraController == null || !cameraController.value.isRecordingVideo) {
  //     return null;
  //   }
  //
  //   try {
  //     return cameraController.stopImageStream();
  //   } on CameraException catch (e) {
  //     return null;
  //   }
  // }

  void gallary() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      profileImageFile = File(image!.path);
      if (profileImageFile != null) {
        _cropImage().then((value) async {
          Constants.profileImage = await MultipartFile.fromFile(
              profileImageFile!.path,
              filename: "${File(image.path).path.split('/').last}");
          setState(() {
            profileImageFile = value;
          });
        });
      }
    });
  }
}
