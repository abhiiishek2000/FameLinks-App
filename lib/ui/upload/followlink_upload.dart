import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:famelink/dio/api/api.dart';
import 'package:famelink/media_compression_provider.dart';
import 'package:famelink/models/ChallengesResponse.dart';
import 'package:famelink/models/tags.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/constants.dart';
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:famelink/util/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_compress/video_compress.dart';

class FollowLinkUploadScreen extends StatefulWidget {
  bool? userProfile;

  FollowLinkUploadScreen({this.userProfile});

  @override
  _FollowLinkUploadScreenState createState() => _FollowLinkUploadScreenState();
}

class _FollowLinkUploadScreenState extends State<FollowLinkUploadScreen> {
  final ApiProvider _api = ApiProvider();
  int _value = -1;
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  ValueNotifier<double> _counter = ValueNotifier<double>(0);
  TextEditingController commentController = new TextEditingController();
  TextEditingController songNameController = new TextEditingController();
  TextEditingController challengeController = new TextEditingController();
  TextEditingController channelController = new TextEditingController();
  List<Challenges> challengesList = <Challenges>[];
  List<File> imageList = <File>[];
  List<File> compressedImageList = <File>[];
  List<File> thumbnailList = <File>[];
  List<Challenges> selectedChallengesList = <Challenges>[];
  PageController pageController = PageController(keepPage: true);
  Subscription? _subscription;
  List<Tags> tags = <Tags>[];
  TextEditingController tagName = new TextEditingController();
  String? tagId;

  Future<List<Challenges>> _getChallengesData(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));
    if (query.isNotEmpty) {
      Api.get.call(context,
          method: "challenges/search/${query}/followlinks",
          param: {},
          isLoading: false, onResponseSuccess: (Map object) {
        challengesList.clear();
        var result = ChallengesResponse.fromJson(object);
        challengesList = result.result!;
      });
      return challengesList;
    }
    return challengesList;
  }

  Future<List<Tags>?> getTagsData(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));
    if (query != '' && query != null) {
      var result = await _api.getTagsAPI(query);
      if (result != null) {
        tags.clear();
        setState(() {
          print(result);
          setState(() {
            tags.addAll(result.result!);
          });

          //return tags;
        });
      }
    } else {
      // tags.clear();
      return tags;
    }
  }

  @override
  void dispose() {
    super.dispose();
    //_subscription!.unsubscribe();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Constants.playing = false;
    });
    //imageList.add(null);
    // _subscription = VideoCompress.compressProgress$.subscribe((progress) {
    //   debugPrint('progress: $progress');
    //   _counter.value = progress;
    //   if (progress >= 100) {
    //     progressDialog(false, context);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        toolbarHeight: ScreenUtil().setHeight(61),
        backgroundColor: appBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: "FollowLinks ",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: ScreenUtil().setSp(18))),
          TextSpan(
              text: "Upload",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w700,
                  color: lightRed,
                  fontSize: ScreenUtil().setSp(18))),
        ])),
      ),
      body: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(38), right: ScreenUtil().setWidth(38)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: ScreenUtil().setSp(350),
                decoration: BoxDecoration(
                    color: appBackgroundColor,
                    border: Border.all(color: lightGray)),
                child: Stack(
                  children: [
                    CarouselSlider.builder(
                        itemCount: imageList.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          if (itemIndex == imageList.length - 1 &&
                              imageList[itemIndex] == null) {
                            return InkWell(
                              onTap: () {
                                closeUp();
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                                "assets/icons/svg/upload_banner.svg"),
                                            SizedBox(
                                              height: ScreenUtil().setSp(8),
                                            ),
                                            Text("Upload Photos / Video",
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w400,
                                                    color: lightGray)),
                                            SizedBox(
                                              height: ScreenUtil().setSp(1),
                                            ),
                                            Text(
                                                "(Upload Multiple Image for Scrolling)",
                                                style: GoogleFonts.nunitoSans(
                                                    fontSize:
                                                        ScreenUtil().setSp(10),
                                                    fontWeight: FontWeight.w400,
                                                    color: lightGray)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                _cropImage(imageList[itemIndex])
                                    .then((value) async {
                                  print(value!.path);
                                  setState(() {
                                    imageList.removeAt(itemIndex);
                                    imageList.insert(itemIndex, value);
                                  });
                                });
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration:
                                      BoxDecoration(color: appBackgroundColor),
                                  child: Image.file(
                                    imageList[itemIndex],
                                    fit: BoxFit.contain,
                                  )),
                            );
                          }
                        },
                        options: CarouselOptions(
                          height: ScreenUtil().setSp(422),
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              pageController = PageController(
                                  keepPage: true, initialPage: index);
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: imageList.length,
                          axisDirection: Axis.horizontal,
                          effect: SlideEffect(
                              spacing: 10.0,
                              radius: 3.0,
                              dotWidth: 6.0,
                              dotHeight: 6.0,
                              paintStyle: PaintingStyle.stroke,
                              strokeWidth: 1.5,
                              dotColor: Colors.white,
                              activeDotColor: lightRed),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setSp(7),
              ),
              Text(
                  "Resize to Crop (Anything beyond RED Square is cropped for ever)",
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: black,
                      fontSize: ScreenUtil().setSp(10))),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (imageList.length < 7) {
                      closeUp();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Maximum 7 Images allowed'),
                      ));
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setSp(12),
                        top: ScreenUtil().setSp(12),
                        bottom: ScreenUtil().setSp(12)),
                    child: Text("Select Multiple Images",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w700,
                            color: buttonBlue,
                            fontSize: ScreenUtil().setSp(12))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(22)),
                child: TextFormField(
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(150),
                  ],
                  controller: commentController,
                  minLines: 1,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'What’s Up',
                    labelStyle: GoogleFonts.nunitoSans(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(14)),
                    hintText: 'Say Something....',
                    hintStyle: GoogleFonts.nunitoSans(
                        color: lightGray,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(10)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: buttonBlue,
                      ),
                    ),
                  ),
                ),
              ),
              /* Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                child: Wrap(
                  children: List<Widget>.generate(
                    selectedChallengesList.length,
                    (int index) {
                      return Padding(
                          padding:
                              EdgeInsets.only(right: ScreenUtil().setWidth(5)),
                          child: InputChip(
                            padding: EdgeInsets.all(2.0),
                            label: Text(
                              "#${selectedChallengesList[index].name}",
                              style: TextStyle(color: Colors.black),
                            ),
                            selectedColor: Colors.blue.shade600,
                            onDeleted: () {
                              setState(() {
                                selectedChallengesList.removeAt(index);
                              });
                            },
                          ));
                    },
                  ).toList(),
                ),
              ),*/

              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: TypeAheadFormField<Challenges?>(
                  textFieldConfiguration: TextFieldConfiguration(
                      textAlign: TextAlign.start,
                      controller: channelController,
                      textInputAction: TextInputAction.done,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          color: buttonBlue,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(2),
                              top: ScreenUtil().setHeight(0)),
                          labelText: "# Channel Name",
                          labelStyle: GoogleFonts.roboto(
                              color: lightGray,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)))),
                  suggestionsCallback: (pattern) async {
                    return await _getChallengesData(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return Text("");
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (suggestion) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                  //   bottom: ScreenUtil().setHeight(12),
                ),
                child: TypeAheadFormField<Tags>(
                  textFieldConfiguration: TextFieldConfiguration(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(20),
                      ],
                      textAlign: TextAlign.start,
                      controller: tagName,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {},
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          color: buttonBlue,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(2),
                              top: ScreenUtil().setHeight(0)),
                          labelText: "@ Agency Collabs / Brands / Users",
                          labelStyle: GoogleFonts.roboto(
                              color: lightGray,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)))),
                  suggestionsCallback: (pattern) async {
                    // return await getTagsData(pattern);
                    await getTagsData(pattern);
                    return tags;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.username!,
                        style: GoogleFonts.roboto(
                            color: darkGray,
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    );
                  },
                  // transitionBuilder: (context, suggestionsBox, controller) {
                  //   // return suggestionsBox;
                  // },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      this.tags.clear();
                      this.tags.add(suggestion);
                      tagName.text = suggestion.username!;
                      tagId = suggestion.sId;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: TypeAheadFormField<Challenges?>(
                  textFieldConfiguration: TextFieldConfiguration(
                      textAlign: TextAlign.start,
                      controller: challengeController,
                      textInputAction: TextInputAction.done,
                      style: GoogleFonts.nunitoSans(
                          fontSize: ScreenUtil().setSp(12),
                          color: buttonBlue,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(2),
                              top: ScreenUtil().setHeight(0)),
                          labelText: "Club Offer Code",
                          labelStyle: GoogleFonts.roboto(
                              color: lightGray,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)))),
                  suggestionsCallback: (pattern) async {
                    return await _getChallengesData(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion!.hashTag!,
                        style: GoogleFonts.roboto(
                            color: darkGray,
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(12)),
                      ),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      this.selectedChallengesList.clear();
                      this.selectedChallengesList.add(suggestion!);
                      challengeController.text = suggestion.hashTag!;
                    });
                  },
                ),
              ),
              /* Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  style: GoogleFonts.nunitoSans(
                      fontSize: ScreenUtil().setSp(12),
                      color: buttonBlue,
                      fontWeight: FontWeight.w400),
                  controller: songNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(2),
                        top: ScreenUtil().setHeight(0)),
                    hintText: 'Tag Users',
                    hintStyle: GoogleFonts.nunitoSans(
                        color: lightGray,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(12)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: darkGray),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: lightRed),
                    ),
                  ),
                ),
              ),*/
              Consumer<MediaCompressionProvider>(
                  builder: (context, provider, child) {
                return provider.isLoading
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CircularProgressIndicator(),
                      ))
                    : UploadButton(
                        text: 'Upload',
                        onPressed: () async {
                          // print('--------${widget.userProfile}');
                          if (imageList.length == 1 && imageList[0] == null ||
                              imageList.length == 0) {
                            var snackBar = SnackBar(
                              content: Text('Select Photos or Video'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            await _uploadContestData();
                          }
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void progressDialog(bool isLoading, BuildContext context) {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Colors.black,
      content: Container(
          color: Colors.black,
          height: 60.0,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Compressing",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                SizedBox(height: 8),
                ValueListenableBuilder<double>(
                  builder:
                      (BuildContext? context, double? value, Widget? child) {
                    // This builder will only get called when the _counter
                    // is updated.
                    return LinearPercentIndicator(
                      lineHeight: 10.0,
                      percent: value! / 100,
                      backgroundColor: Colors.white,
                      progressColor: Colors.black26,
                    );
                  },
                  valueListenable: _counter,
                  // The child parameter is most helpful if the child is
                  // expensive to build and does not depend on the value from
                  // the notifier.
                ),
                SizedBox(height: 15),
              ],
            ),
          )),
      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
    );
    if (!isLoading) {
      Navigator.of(context).pop();
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog;
          });
    }
  }

  Future<void> _uploadContestData() async {
    if (imageList.isNotEmpty) {
      showSnackBar(context: context, message: "Compressing...", isError: false);
      for (var rawFile in imageList) {
        await Provider.of<MediaCompressionProvider>(context, listen: false)
            .compressImageFile(rawFile)
            .then((value) {
          compressedImageList.add(value);
        });
        await Provider.of<MediaCompressionProvider>(context, listen: false)
            .getThumbnailImage(rawFile)
            .then((compressed) {
          thumbnailList.add(compressed);
        });
        setState(() {});
      }

      showSnackBar(context: context, message: "Compressed", isError: false);
    }
    List<String> idList = [];
    if (challengeController.text.isNotEmpty) {
      idList.add(challengeController.text);
    }
    List tagList = [];
    if (tags.length != 0) {
      tagList.add(tags[0].sId);
    }

    Map map = {
      "description": commentController.text,
      "channelname": channelController.text,
      "challengeId": idList,
      "image": compressedImageList,
      'thumbnail': thumbnailList,
      "context": context,
      "profile": widget.userProfile,
      "tags": tagList,
    };

    Navigator.pop(context, map);
    // var result= _api.uploadFollowLink(commentController.text,idList,imageList,context,widget.userProfile);
    // if (result.toString() == '1') {

    //   if(widget.userProfile == true){
    //     return Navigator.pushAndRemoveUntil<void>(
    //       context,
    //       MaterialPageRoute<void>(builder: (BuildContext context) =>  ProfileFameLink(runSelectPhase: 2,)),
    //       ModalRoute.withName('/'),
    //     );
    //   }else{
    //     return  Navigator.pushAndRemoveUntil<void>(
    //       context,
    //       MaterialPageRoute<void>(builder: (BuildContext context) =>  FollowLinksUserProfile()),
    //       ModalRoute.withName('/'),
    //     );

    //   }
    // setState(() {
    //   Navigator.pushAndRemoveUntil<void>(
    //     context,
    //     MaterialPageRoute<void>(builder: (BuildContext context) =>  FollowLinksUserProfile()),
    //     ModalRoute.withName('/'),
    //   );
    //   // Navigator.pushReplacement(
    //   //     context,
    //   //     MaterialPageRoute(
    //   //         builder: (context) =>
    //   //             FollowLinksUserProfile()));
    // });
    // }
  }

  Future closeUp() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () async {
                      try {
                        final List<XFile>? pickedFile =
                            await ImagePicker().pickMultiImage();
                        if (pickedFile == null)
                          return;
                        else {
                          if (pickedFile.length + imageList.length > 7) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Maximum 7 Images allowed'),
                            ));
                          } else {
                            for (XFile? file in pickedFile) {
                              File closeUpImageFile = File(file!.path);
                              imageList.add(closeUpImageFile);
                            }
                            if (imageList.length < 7) {
                              //imageList.add(null);
                            }
                          }
                        }
                        // imageList.removeAt(imageList.length-1);

                        setState(() {});
                        // File closeUpImageFile = File(pickedFile.path);
                        // _cropImage(closeUpImageFile).then((value) async {
                        //   print(value.path);
                        //   setState(() {
                        //     closeUpImageFile = value;
                        //     imageList.add(value);
                        //   });
                        // });
                      } on PlatformException catch (e) {
                        print('FAILED $e');
                      }
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);
                      if (image == null) return;
                      File closeUpImageFile = File(image.path);
                      _cropImage(closeUpImageFile).then((value) async {
                        if (value != null) {
                          print("followimagepath ${value.path}");
                          imageList.removeAt(imageList.length - 1);
                          setState(() {
                            closeUpImageFile = value;
                            imageList.add(value);
                          });
                          if (imageList.length < 7) {
                            //imageList.add(null);
                          }
                          // MultipartFile closeUp = await MultipartFile.fromFile(
                          //     closeUpImageFile.path,
                          //     filename:
                          //     "${File(image.path).path.split('/').last}");
                          // Constants.imageList.add(closeUp);
                        }
                      });
                    } on PlatformException catch (e) {
                      print('FAILED $e');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<File?> _cropImage(profileImageFile) async {
    return await ImageCropper().cropImage(
        sourcePath: profileImageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 9, ratioY: 18),
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: 'Cropper',
        ));
  }
}
