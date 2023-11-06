import 'package:famelink/ui/joblinks/explore/UserExplore/widget/job_invites.dart';
import 'package:famelink/ui/joblinks/explore/UserExplore/widget/job_request.dart';
import 'package:famelink/util/colors.dart';
import 'package:famelink/util/config/color.dart';
import 'package:famelink/util/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'provider/user_explore_provider.dart';
import 'widget/saved_talents.dart';

class UserExplore extends StatefulWidget {
  @override
  State<UserExplore> createState() => UserExploreState();
}

class UserExploreState extends State<UserExplore>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    UserExploreProvider provider =
        Provider.of<UserExploreProvider>(context, listen: false);
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      provider.updateTabIndex(tabController.index);
    });
    provider.scrollCtrl.addListener(() {
      if (provider.scrollCtrl.position.maxScrollExtent ==
          provider.scrollCtrl.position.pixels) {
        provider.page++;
      }
    });
    provider.getJobRequest(context, "appliedJobs");
    provider.getSavedTalents(context);
    provider.getJobInvites(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserExploreProvider>(
      builder: (context, provider, widget) {
        return Scaffold(
          appBar: appBarLayout(provider),
          body: bodyLayout(provider),
        );
      },
    );
  }

  PreferredSizeWidget appBarLayout(UserExploreProvider provider) {
    return AppBar(
      elevation: 0,
      backgroundColor: Clr().white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        splashRadius: Dim().d24.r,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: black,
        ),
      ),
      titleSpacing: 0,
      title: Container(
        margin: EdgeInsets.only(
          right: Dim().d12.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(8)),
          color: Colors.white,
        ),
        child: TextFormField(
          onChanged: (val) {
            provider.updateList(val);
          },
          controller: provider.searchController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.search,
          cursorColor: black,
          style: GoogleFonts.nunitoSans(
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
            color: Color(0xff9B9B9B),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(16)),
              borderSide: BorderSide(color: Color(0xff9B9B9B), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(16)),
              borderSide: BorderSide(color: lightRed, width: 1),
            ),
            suffixIcon: Image.asset("assets/icons/search.png",
                color: Color(0xff9B9B9B)),
            hintText: 'Search',
            hintStyle: GoogleFonts.nunitoSans(
              fontSize: ScreenUtil().setSp(14),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: lightGray,
            ),
          ),
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     splashRadius: Dim().d24.r,
      //     icon: Padding(
      //       padding: EdgeInsets.only(
      //         top: 6.h,
      //       ),
      //       child: SvgPicture.asset(
      //         '${Constants().filterSvg}',
      //         color: darkGray,
      //       ),
      //     ),
      //   ),
      // ],
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: black,
        tabs: [
          Tab(
            child: DropdownButton(
              value: provider.sRequestType,
              underline: Container(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: provider.currentTabIndex == 0 ? black : lightGray,
              ),
              items: provider.requestTypeList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: GoogleFonts.nunitoSans(
                      color: provider.currentTabIndex == 0 ? black : lightGray,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                );
              }).toList(),
              onChanged: provider.currentTabIndex == 0
                  ? (String? value) {
                      provider.updateDropdown(context, value!);
                    }
                  : null,
            ),
          ),
          Tab(
            child: Row(
              children: [
                Text(
                  'Saved Talents',
                  style: GoogleFonts.nunitoSans(
                    color: provider.currentTabIndex == 1 ? black : lightGray,
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
                Icon(
                  Icons.bookmark_border,
                  color: provider.currentTabIndex == 1 ? black : lightGray,
                ),
              ],
            ),
          ),
          Tab(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Invites ",
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: provider.currentTabIndex == 2 ? black : lightGray,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                  TextSpan(
                    text: '(${provider.jobInviteListResult.length})',
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0060FF),
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyLayout(UserExploreProvider provider) {
    return TabBarView(
      controller: tabController,
      children: [
        JobRequest(
          provider.sRequestType == "Applied"
              ? provider.appliedList
              : provider.sRequestType == "Saved"
                  ? provider.savedList
                  : provider.sRequestType == "Hired"
                      ? provider.hiredList
                      : provider.shortlistedList,
        ),
        SavedTalent(provider.savedTalentList),
        JobInvites(provider.jobInviteList),
      ],
    );
  }
}
