import 'package:famelink/ui/joblinks/jobController.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'explore.dart';
import 'followexploreprovider.dart';

class FollowlinkExplore extends StatefulWidget {
  FollowlinkExplore({Key? key}) : super(key: key);

  @override
  State<FollowlinkExplore> createState() => _FollowlinkExploreState();
}

class _FollowlinkExploreState extends State<FollowlinkExplore>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  JobController controller = Get.put(JobController());
  TabController? tabController;
  String url = 'https://budlinks.app/cluboffers.html';

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    controller.activeIndex.value = 0;
    super.initState();
    final postMdl = Provider.of<Followexploreprovider>(context, listen: false);
    postMdl.followlinksayhi();
    postMdl.followsuggest();
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      controller.activeIndex.value = tabController!.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 10),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        color: black, size: 25),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(16),
                        left: ScreenUtil().setWidth(10),
                        right: ScreenUtil().setWidth(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().radius(8)),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        cursorColor: black,
                        style: GoogleFonts.nunitoSans(
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: Color(0xff9B9B9B)),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.all(ScreenUtil().setWidth(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(16)),
                              borderSide: BorderSide(
                                  color: Color(0xff9B9B9B), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().radius(16)),
                              borderSide: BorderSide(color: lightRed, width: 1),
                            ),
                            suffixIcon: Image.asset("assets/icons/search.png",
                                color: Color(0xff9B9B9B)),
                            hintText: 'Search',
                            hintStyle: GoogleFonts.nunitoSans(
                                fontSize: ScreenUtil().setSp(14),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: lightGray)),
                      ),
                    ),
                  ),
                ),
                controller.activeIndex.value == 0
                    ? Container()
                    : InkWell(
                        onTap: () async {
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'could not launch $url';
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.w, top: 8.h),
                          child: Text('How it\nworks?',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w400,
                                color: darkGray,
                                fontSize: ScreenUtil().setSp(10),
                              )),
                        ),
                      ),
              ],
            ),
            Followexplorepage()
            // Padding(
            //   padding: EdgeInsets.only(top: 8.h),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         height: 25.h,
            //         width: 25.w,
            //       ),
            //       Spacer(),
            //       Flexible(
            //         flex: 3,
            //         child: TabBar(
            //           tabs: [
            //             Tab(
            //               child: IntrinsicWidth(
            //                 child: Text(
            //                   'Explore',
            //                 ),
            //               ),
            //             ),
            //             Tab(
            //               child: IntrinsicWidth(
            //                 child: Text(
            //                   'Club Offers',
            //                 ),
            //               ),
            //             ),
            //           ],
            //           indicatorSize: TabBarIndicatorSize.label,
            //           indicatorColor: orange,
            //           isScrollable: true,
            //           unselectedLabelColor: darkGray,
            //           labelColor: black,
            //           labelStyle: GoogleFonts.nunitoSans(
            //             fontWeight: FontWeight.w700,
            //             fontSize: 14,
            //           ),
            //           unselectedLabelStyle: GoogleFonts.nunitoSans(
            //             fontWeight: FontWeight.w400,
            //             fontSize: 13,
            //           ),
            //           controller: tabController,
            //         ),
            //       ),
            //       Spacer(),
            //       controller.activeIndex.value == 0
            //           ? Container(
            //               height: 25.h,
            //               width: 25.w,
            //             )
            //           : InkWell(
            //               onTap: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => CreateOffer()),
            //                 );
            //               },
            //               child: Padding(
            //                 padding: EdgeInsets.only(right: 16.w),
            //                 child: Container(
            //                   height: 25.h,
            //                   width: 25.w,
            //                   decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(7),
            //                       border: Border.all(color: darkGray)),
            //                   child: Image.asset("assets/icons/plusIcon.png"),
            //                 ),
            //               ),
            //             ),
            //     ],
            //   ),
            // ),
            // Expanded(
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 5.h),
            //     child: TabBarView(
            //       controller: tabController,
            //       children: [
            //         Followexplorepage(),
            //         ClubOffers(),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
