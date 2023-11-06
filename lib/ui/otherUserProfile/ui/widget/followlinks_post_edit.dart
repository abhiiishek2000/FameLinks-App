import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/models/ChallengesResponse.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/otherUserProfile/model/OtherUserProfileFollowlinksPostModel.dart'
as oldData;
import 'package:famelink/util/custom_snack_bar.dart';
import 'package:famelink/util/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../dio/api/api.dart';
import '../../../../providers/FeedProvider/GetParticularFunLinksProfileProvider.dart';
import '../../../../providers/FeedProvider/GetPerticularFollowLinksProfileProvider.dart';
import '../../../../util/config/color.dart';

class FollowLinksPostEditScreen extends StatefulWidget {
  const FollowLinksPostEditScreen(
      {Key? key,
        required this.postData,
        required this.index,
        required this.provider})
      : super(key: key);
  final oldData.OtherUserProfileFunlinksPostModelResult postData;
  final int index;
  final GetParticularFollowLinksProfileProvider provider;

  @override
  State<FollowLinksPostEditScreen> createState() => _FollowLinksPostEditScreenState();
}

class _FollowLinksPostEditScreenState extends State<FollowLinksPostEditScreen> {
  PageController? smoothPageController;
  TextEditingController commentController = new TextEditingController();
  TextEditingController challengesController = new TextEditingController();
  List<Challenges> challengesList = <Challenges>[];
  List<String> challengesId = <String>[];

  @override
  void initState() {
    smoothPageController = PageController(keepPage: true, initialPage: 0);
    fillData();
    super.initState();
  }

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

  void fillData() {
    if (widget.postData.description != null) {
      commentController.text = widget.postData.description!;
      setState(() {});
    }
    if (widget.postData.challenges != null &&
        widget.postData.challenges!.isNotEmpty) {
      challengesController.text = widget.postData.challenges![0].hashTag!;
      challengesId.add(widget.postData.challenges![0].sId!);
      setState(() {});
    }
  }

  void updatePost() {
    var param = {
      // "challengeId": jsonEncode(challengesId),
      'description': commentController.text,
    };
    Api.put.call(context,
        method: 'media/followlinks/${widget.postData.sId}',
        param: param, onResponseSuccess: (Object? object) {
          print(object);
          showSnackBar(context: context, message: 'Post Updated', isError: false);
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text('Edit FollowLinks',
              style: GoogleFonts.nunitoSans(
                  fontSize: ScreenUtil().setSp(18), color: Colors.black)),
          actions: [
            IconButton(
                onPressed: () => widget.provider
                    .deletePost(widget.index, widget.postData.sId!, context),
                icon: Icon(Icons.delete, color: darkGrey)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: ScreenUtil().setHeight(350),
                padding: EdgeInsets.all(12),
                child: PageView.builder(
                    itemCount: widget.postData.media!.length,
                    scrollDirection: Axis.horizontal,
                    controller: smoothPageController,
                    itemBuilder: (context, int index) {
                      return widget.postData.media![index].type != 'video'
                          ? CachedNetworkImage(
                        imageUrl:
                        '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${widget.postData.media![index].path}',
                      )
                          : Stack(fit: StackFit.expand, children: [
                        CachedNetworkImage(
                            imageUrl:
                            '${ApiProvider.s3UrlPath}/${ApiProvider.followlinks}/${widget.postData.media![index].path}-xs'),
                        Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                              'assets/icons/svg/other_profile_video_play.svg'),
                        ),
                      ]);
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.postData.media!.length == 1
                      ? Container()
                      : SmoothPageIndicator(
                    controller: smoothPageController!,
                    count: widget.postData.media!.length,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                        spacing: 10.0,
                        radius: 3.0,
                        dotWidth: 6.0,
                        dotHeight: 6.0,
                        paintStyle: PaintingStyle.stroke,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: lightRed),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        color: Colors.black.withOpacity(0.49),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        fontSize: ScreenUtil().setSp(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: buttonBlue,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 1,
                          color: buttonBlue,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TypeAheadFormField<Challenges>(
                  direction: AxisDirection.up,
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: challengesController,
                      style: GoogleFonts.nunitoSans(
                          color: darkGray,
                          fontWeight: FontWeight.w300,
                          fontSize: ScreenUtil().setSp(12)),
                      decoration: InputDecoration(
                          labelText: "# Channel Name",
                          labelStyle: GoogleFonts.nunitoSans(
                              color: darkGray,
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(12)))),
                  suggestionsCallback: (pattern) async {
                    return await _getChallengesData(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(
                        suggestion.hashTag ?? '',
                        style: GoogleFonts.nunitoSans(
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
                      challengesController.text = suggestion.hashTag!;
                      challengesId.clear();
                      challengesId.add(suggestion.sId!);
                      setState(() {});
                    });
                  },
                ),
              ),
              UploadButton(text: "Update", onPressed: updatePost),
            ],
          ),
        ),
      ),
    );
  }
}
