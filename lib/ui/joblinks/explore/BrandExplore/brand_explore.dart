import 'package:famelink/ui/joblinks/explore/BrandExplore/widget/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../util/colors.dart';
import '../../../../util/config/color.dart';
import '../../../../util/dimens.dart';
import '../UserExplore/widget/saved_talents.dart';
import 'provider/brand_explore_provider.dart';

class BrandExplorePage extends StatefulWidget {
  @override
  State<BrandExplorePage> createState() => BrandExploreState();
}

class BrandExploreState extends State<BrandExplorePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    BrandExploreProvider provider =
        Provider.of<BrandExploreProvider>(context, listen: false);
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
    provider.getData(context, '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandExploreProvider>(
      builder: (context, provider, widget) {
        return Scaffold(
          appBar: appBarLayout(provider),
          body: bodyLayout(provider),
        );
      },
    );
  }

  PreferredSizeWidget appBarLayout(BrandExploreProvider provider) {
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
          controller: provider.searchCtrl,
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
      bottom: TabBar(
        controller: tabController,
        isScrollable: true,
        indicatorColor: black,
        tabs: [
          Tab(
            child: Text(
              "All",
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                color: provider.currentTabIndex == 0 ? black : lightGray,
                fontSize: ScreenUtil().setSp(12),
              ),
            ),
          ),
          Tab(
            child: Text(
              "Profile",
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.w400,
                color: provider.currentTabIndex == 1 ? black : lightGray,
                fontSize: ScreenUtil().setSp(12),
              ),
            ),
          ),
          Tab(
            child: Row(
              children: [
                Text(
                  'Saved Talents',
                  style: GoogleFonts.nunitoSans(
                    color: provider.currentTabIndex == 2 ? black : lightGray,
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
                Icon(
                  Icons.bookmark_border,
                  color: provider.currentTabIndex == 2 ? black : lightGray,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyLayout(BrandExploreProvider provider) {
    return TabBarView(
      controller: tabController,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (provider.profileList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Text(
                    'Profiles',
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700,
                      color: darkGray,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
              if (provider.profileList.isNotEmpty)
                Profile(provider.profileList),
              if (provider.savedTalentList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
                  child: Text(
                    'Saved Talents',
                    style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700,
                      color: darkGray,
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                ),
              if (provider.savedTalentList.isNotEmpty)
                SavedTalent(provider.savedTalentList),
            ],
          ),
        ),
        Profile(provider.profileList),
        SavedTalent(provider.savedTalentList),
      ],
    );
  }
}
