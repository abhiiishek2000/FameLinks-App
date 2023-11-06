import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/joblinks/models/FeedModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class TalentFeedPost extends StatefulWidget {
  int? index;
  int? index1;
  List<Talents>? talentList;
  List<VideoPlayerController>? controller;
  TalentFeedPost({this.index, this.index1, this.talentList, this.controller});

  @override
  State<TalentFeedPost> createState() => _TalentFeedPostState();
}

class _TalentFeedPostState extends State<TalentFeedPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Container(
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
                            widget.talentList![widget.index!.toInt()].profile!.greetVideo == null || widget.talentList![widget.index!.toInt()].profile!.greetVideo == '' ? Container() :
                            Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Container(
                                height: 400.h,
                                width: 300.w,
                                child: Stack(
                                  children: [
                                    Image.asset("assets/icons/rect.png", height: 291.h,
                                      width: 291.w,),
                                    Positioned(
                                      top: 9.h,
                                      left: 7.w,
                                      child: Container(
                                        height: 291.h,
                                        width: 291.w,
                                        child: widget.controller![widget.index!]
                                            .value
                                            .isInitialized
                                            ? VideoPlayer(
                                            widget.controller![widget.index!])
                                            : Container(),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (widget.talentList![widget.index!].isPlaying ==
                                              true) {
                                            widget.controller![widget.index!].pause();
                                            widget.talentList![widget.index!].isPlaying =
                                            false;
                                          } else {
                                            widget.controller![widget.index!].play();
                                            widget.talentList![widget.index!].isPlaying =
                                            true;
                                          }
                                        });
                                      },
                                      child: Center(
                                        child: widget.talentList![widget.index!]
                                            .isPlaying ==
                                            true
                                            ? Container(
                                          height: 40.h,
                                          width: 40.w,
                                        )
                                            : Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: white
                                                      .withOpacity(
                                                      0.5),
                                                  width: 2.w)),
                                          child: Icon(
                                              Icons.play_arrow,
                                              color: white
                                                  .withOpacity(0.5)),
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
                                itemCount: widget.talentList![widget.index!].posts!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, ind) {
                                  if(ind == 0){
                                    ind = widget.index!;
                                  }else if(widget.index1 == ind){
                                    ind = 0;
                                  }
                                  return Padding(
                                    padding: EdgeInsets.only(right: 15.w),
                                    child: Container(
                                      height: 400.h,
                                      width:
                                      MediaQuery.of(context).size.width -
                                          150.w,
                                      child: CachedNetworkImage(
                                        imageUrl: widget.talentList![widget.index!.toInt()]
                                            .posts![ind]
                                            .closeUp !=
                                            null
                                            ? '${ApiProvider.famelinks}/${widget.talentList![widget.index!].posts![ind].closeUp}'
                                            : widget.talentList![widget.index!.toInt()]
                                            .posts![ind]
                                            .medium !=
                                            null
                                            ? '${ApiProvider.famelinks}/${widget.talentList![widget.index!].posts![ind].medium}'
                                            : widget.talentList![widget.index!.toInt()]
                                            .posts![ind]
                                            .long !=
                                            null
                                            ? '${ApiProvider.famelinks}/${widget.talentList![widget.index!].posts![ind].long}'
                                            : widget.talentList![widget.index!.toInt()]
                                            .posts![i]
                                            .pose1 !=
                                            null
                                            ? '${ApiProvider.famelinks}/${widget.talentList![widget.index!].posts![ind].pose1}'
                                            : widget.talentList![widget.index!.toInt()]
                                            .posts![ind]
                                            .pose2 !=
                                            null
                                            ? '${ApiProvider.famelinks}/${widget.talentList![widget.index!.toInt()].posts![ind].pose2}'
                                            : widget.talentList![widget.index!.toInt()]
                                            .posts![
                                        ind]
                                            .additional !=
                                            null
                                            ? '${ApiProvider.famelinks}/${widget.talentList![widget.index!.toInt()].posts![ind].additional}'
                                            : '${ApiProvider.famelinks}/${widget.talentList![widget.index!.toInt()].posts![ind].video}',
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
          )),
    );

  }
}