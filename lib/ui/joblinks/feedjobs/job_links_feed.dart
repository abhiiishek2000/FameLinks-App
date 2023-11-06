import 'package:famelink/ui/joblinks/createjob/createJob.dart';
import 'package:famelink/ui/joblinks/explore/BrandExplore/brand_explore.dart';
import 'package:famelink/ui/joblinks/feedjobs/explore_talents.dart';
import 'package:famelink/ui/joblinks/feedjobs/provider/feed_provider.dart';
import 'package:famelink/ui/joblinks/feedjobs/your_jobs.dart';
import 'package:famelink/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common/common_image.dart';
import '../../../manager/static_method.dart';
import '../../../networking/config.dart';
import '../../../util/colors.dart';
import '../../../util/config/color.dart';
import '../../../util/dimens.dart';
import '../../../util/registerDialog.dart';
import '../../home_feed/provider/home_feed_provider.dart';
import '../../notification/notification_screen.dart';
import '../explore/UserExplore/user_explore.dart';
import 'explore_jobs.dart';
import 'past_jobs.dart';

class JobLinksFeed extends StatefulWidget {
  @override
  State<JobLinksFeed> createState() => JobLinksFeedState();
}

class JobLinksFeedState extends State<JobLinksFeed>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    print(ApiProvider.userType.toString());
    JobLinksFeedProvider provider = Provider.of(context, listen: false);
    provider.init();
    provider.tabController = TabController(
      vsync: this,
      length: ApiProvider.userType == 'brand' ? 3 : 4,
    );
    provider.tabController?.addListener(() {
      provider.updateTabIndex(provider.tabController!.index);
    });

    HomeFeedProvider homeProvider = Provider.of(context, listen: false);
    if (homeProvider.getIsRegistered) {
      provider.getJobLinksFeed(provider.page);
    } else {
      provider.loadjob = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeFeedProvider, JobLinksFeedProvider>(
      builder: (context, homeProvider, provider, widget) {
        return NestedScrollView(
          headerSliverBuilder: (context, b) {
            return [
              appbar(homeProvider, provider),
            ];
          },
          body: Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(CommonImage.dart_back_img),
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                provider.loadjob
                    ? Center(child: CircularProgressIndicator())
                    : TabBarView(
                        controller: provider.tabController,
                        children: [
                          if (ApiProvider.userType != 'brand') ExploreJobs(),
                          YourJobs(),
                          ExploreTalents(),
                          PastJobs(),
                        ],
                      ),
                Positioned(
                  bottom: Dim().d20,
                  right: Dim().d24,
                  child: InkWell(
                    onTap: () {
                      STM().redirect2page(context, NotificationScreen());
                    },
                    child: SvgPicture.asset(
                      'assets/notification_button.svg',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 110.h,
                  left: Dim().d0,
                  child: InkWell(
                    onTap: () {
                      STM().redirect2page(
                          context,
                          ApiProvider.userType == 'brand'
                              ? BrandExplorePage()
                              : UserExplore());
                    },
                    child: SvgPicture.asset(
                      'assets/job_explore.svg',
                      height: Dim().d48,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  SliverAppBar appbar(
      HomeFeedProvider homeProvider, JobLinksFeedProvider provider) {
    var name1 = provider.list[ApiProvider.userType == 'brand'
            ? (provider.currentTabIndex + 1)
            : provider.currentTabIndex]
        .split(" ")[0];
    var name2 = provider.list[ApiProvider.userType == 'brand'
            ? (provider.currentTabIndex + 1)
            : provider.currentTabIndex]
        .split(" ")[1];
    return SliverAppBar(
      backgroundColor: Clr().appBarColor,
      pinned: true,
      floating: true,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/filter_button.svg',
          width: Dim().d24,
        ),
      ),
      centerTitle: true,
      title: Wrap(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$name1 ',
                  style: Sty().toolbarText.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
                ),
                TextSpan(
                  text: '$name2',
                  style: Sty().toolbarText.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: orange,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (homeProvider.getIsRegistered) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateJob()),
              );
            } else {
              registerDialog(context);
            }
          },
          icon: SvgPicture.asset(
            'assets/plus_button.svg',
            width: Dim().d24,
          ),
        ),
      ],
      bottom: TabBar(
        controller: provider.tabController,
        indicatorColor: orange,
        isScrollable: true,
        labelColor: orange,
        labelStyle: Sty().toolbarText.copyWith(fontWeight: FontWeight.w700),
        unselectedLabelColor: lightGray,
        unselectedLabelStyle:
            Sty().toolbarText.copyWith(fontWeight: FontWeight.w700),
        tabs: [
          if (ApiProvider.userType != 'brand') Tab(text: '${provider.list[0]}'),
          Tab(text: '${provider.list[1]}'),
          Tab(text: '${provider.list[2]}'),
          Tab(text: '${provider.list[3]}'),
        ],
      ),
    );
  }
}
