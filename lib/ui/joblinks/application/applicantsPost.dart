import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/models/ApplicantsModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ApplicantsPost extends StatefulWidget {
  int? index;
  int? index1;
  List<Applicants>? applicantsList;
  List<VideoPlayerController>? controller;
  ApplicantsPost({this.index, this.index1, this.applicantsList, this.controller});

  @override
  State<ApplicantsPost> createState() => _ApplicantsPostState();
}

class _ApplicantsPostState extends State<ApplicantsPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
            child: Material(
                type: MaterialType.transparency,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Center(
                    child: Wrap(
                      children: [
                        Container(
                            height: 300.h,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return Container(
                                    height: 400.h,
                                    child: Row(
                                      children: [
                                        widget.applicantsList![0]
                                                        .applicants![widget.index!]
                                                        .greetVideo == null ||
                                                widget.applicantsList![0]
                                                        .applicants![widget.index!]
                                                        .greetVideo ==
                                                    ''
                                            ? Container()
                                            : Padding(
                                                padding: EdgeInsets.only(right: 15.w),
                                                child: Container(
                                                  height: 400.h,
                                                  width: 300.w,
                                                  child: Stack(
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/rect.png",
                                                        height: 291.h,
                                                        width: 291.w,
                                                      ),
                                                      Container(
                                                        height: 400.h,
                                                        width: 300.w,
                                                        child: widget.controller![widget.index!]
                                                                .value
                                                                .isInitialized
                                                            ? VideoPlayer(
                                                                widget.controller![widget.index!])
                                                            : Container(),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (widget.applicantsList![0].applicants![widget.index!].isPlaying == true) {
                                                              widget.controller![widget.index!].pause();
                                                              widget.applicantsList![0].applicants![widget.index!].isPlaying = false;
                                                            } else {
                                                              widget.controller![widget.index!].play();
                                                              widget.applicantsList![0].applicants![widget.index!].isPlaying = true;
                                                            }
                                                          });
                                                        },
                                                        child: Center(
                                                          child: widget.applicantsList![0].applicants![widget.index!].isPlaying == true
                                                              ? Container(
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                )
                                                              : Container(
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .transparent,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border: Border.all(
                                                                          color: white
                                                                              .withOpacity(
                                                                                  0.5),
                                                                          width: 2.w)),
                                                                  child: Icon(
                                                                      Icons.play_arrow,
                                                                      color: white
                                                                          .withOpacity(
                                                                              0.5)),
                                                                ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: widget.applicantsList![0]
                                                .applicants![widget.index!]
                                                .posts!
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, ind) {
                                              if(ind == 0){
                                                ind = widget.index1!;
                                              }else if(widget.index1 == ind){
                                                ind = 0;
                                              }
                                              return Padding(
                                                padding: EdgeInsets.only(right: 15.w),
                                                child: Container(
                                                  height: ScreenUtil().setHeight(400),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      150.w,
                                                  child: CachedNetworkImage(
                                                    imageUrl: widget.applicantsList![0]
                                                                .applicants![widget.index!]
                                                                .posts![i]
                                                                .closeUp !=
                                                            null
                                                        ? '${ApiProvider.famelinks}/${widget.applicantsList![0].applicants![widget.index!].posts![ind].closeUp}'
                                                        : widget.applicantsList![0]
                                                                    .applicants![widget.index!]
                                                                    .posts![i]
                                                                    .medium !=
                                                                null
                                                            ? '${ApiProvider.famelinks}/${widget.applicantsList![0].applicants![widget.index!].posts![ind].medium}'
                                                            : widget.applicantsList![0]
                                                                        .applicants![
                                                                            widget.index!]
                                                                        .posts![i]
                                                                        .long !=
                                                                    null
                                                                ? '${ApiProvider.famelinks}/${widget.applicantsList![0].applicants![widget.index!].posts![ind].long}'
                                                                : widget.applicantsList![0]
                                                                            .applicants![
                                                                                widget.index!]
                                                                            .posts![i]
                                                                            .pose1 !=
                                                                        null
                                                                    ? '${ApiProvider.famelinks}/${widget.applicantsList![0].applicants![widget.index!].posts![ind].pose1}'
                                                                    : widget.applicantsList![0]
                                                                                .applicants![
                                                                                    widget.index!]
                                                                                .posts![
                                                                                    i]
                                                                                .pose2 !=
                                                                            null
                                                                        ? '${ApiProvider.famelinks}/${widget.applicantsList![0].applicants![widget.index!].posts![ind].pose2}'
                                                                        : widget.applicantsList![0]
                                                                                    .applicants![widget.index!]
                                                                                    .posts![i]
                                                                                    .additional !=
                                                                                null
                                                                            ? '${ApiProvider.famelinks}/${widget.applicantsList![0].applicants![widget.index!].posts![ind].additional}'
                                                                            : '${ApiProvider.famelinks}/${widget.applicantsList![0].applicants![widget.index!].posts![ind].video}',
                                                    errorWidget: (context, url, error) {
                                                      print("ER::${error.toString()}");
                                                      return Icon(Icons.error,
                                                          color: white);
                                                    },
                                                    fit: BoxFit.fill,
                                                    height: ScreenUtil().setHeight(116),
                                                    width: ScreenUtil().setWidth(116),
                                                  ),
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                )),
          );
  }
}
