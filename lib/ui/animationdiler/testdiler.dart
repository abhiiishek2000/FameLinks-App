import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/UserProfileProvider/userProfile_provider.dart';
import '../../util/constants.dart';
import '../Famelinkprofile/function/famelinkFun.dart';
import '../funlinks/provider/FunLinksFeedProvider.dart';
import '../otherUserProfile/provder/OtherPofileprovider.dart';

class TestDiler extends StatefulWidget {
  const TestDiler({Key? key, required this.id, this.status}) : super(key: key);
  final String id;
  final String? status;
  @override
  State<TestDiler> createState() => _TestDilerState();
}

class _TestDilerState extends State<TestDiler> with TickerProviderStateMixin {
  FameLinkFun? fameLinkFun;

  UserProfileProvider? userProfileProvider;
  RelativeRectTween? fametransition;
  RelativeRectTween? followtransition;
  RelativeRectTween? funtransition;
  RelativeRectTween? jobtransition;
  OtherPofileprovider? otherPofileprovider;
  FunLinksFeedProvider? funLinksFeedProvider;

  @override
  void initState() {
    // setState(() {
    Constants.playing = false;
    // });
    otherPofileprovider =
        Provider.of<OtherPofileprovider>(context, listen: false);
    fameLinkFun = Provider.of<FameLinkFun>(context, listen: false);
    fameLinkFun!.animacon =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    fameLinkFun!.animation =
        Tween(begin: Offset(-2.0, 0.0), end: Offset(0.0, 0.0))
            .animate(fameLinkFun!.animacon.view);

    fameLinkFun!.animacon.addListener(() {
      print(fameLinkFun!.animation.value);
    });
    funLinksFeedProvider =
        Provider.of<FunLinksFeedProvider>(context, listen: false);
    userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);

    //  userProfileProvider!.getProfileFameLinkslocal();
    fameLinkFun!.getProfileFameLinksData(1);
    //_profile();
    otherPofileprovider!.getProfile(context, widget.id.toString());
    // otherPofileprovider!.getFollowLinkProfilelocal();
    // getFollowLinkProfile(widget.id ?? fameLinkFun!.id, context, 1);
    fameLinkFun!.controller = AnimationController(
      vsync: this,
    );
    userProfileProvider!.getUserProfileFollowLinks();
    fameLinkFun!.controller!.duration = Duration(milliseconds: 400);
    fameLinkFun!.controller!.reverseDuration = Duration(milliseconds: 400);
    fameLinkFun!.controller!.addListener(() {
      print("cercal val ${fameLinkFun!.controller!.value}");
      // setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fameLinkFun!.controller!.forward();
    });
    fameLinkFun!.selectPhase = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
