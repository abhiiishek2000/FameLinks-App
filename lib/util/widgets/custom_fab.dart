import 'package:famelink/ui/notification/notification_screen.dart';
import 'package:famelink/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import '../config/color.dart';
import '../config/image.dart';
import '../../ui/challenge/challenge_screen.dart';
import '../../ui/funlinks/funlinks_feed_screen.dart';
import '../../ui/profile/profile_screen.dart';

class CustomFab extends StatefulWidget {
  bool? isProfile;

  @override
  _CustomFabState createState() => _CustomFabState();

  CustomFab({this.isProfile});
}

class _CustomFabState extends State<CustomFab> with TickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      openBackgroundColor: appBackgroundColor,
      closedBackgroundColor: appBackgroundColor,
      child: SvgPicture.asset(home),
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
          backgroundColor: lightRed,
          label: 'Notification',
          child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
              icon: Icon(
                Icons.notification_important_rounded,
                color: white,
              )), onPressed: (){

        },
        ),
        SpeedDialChild(
          backgroundColor: lightRed,
          label: 'Message',
          child: IconButton(
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => LetsBeginScreen()),
                // );
              },
              icon: SvgPicture.asset(
                dialHome,
                color: white,
              )), onPressed: (){

        },
        ),
        SpeedDialChild(
          backgroundColor: lightRed,
          label: 'Hall of Fame',
          child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FunlinksFeedScreen()),
                );
              },
              icon: SvgPicture.asset(
                funlink,
                color: white,
              )), onPressed: (){

        },
        ),
        SpeedDialChild(
          backgroundColor: lightRed,
          label: 'Challenges',
          child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengeScreen()),
                );
              },
              icon: SvgPicture.asset(
                challenge,
                color: white,
              )), onPressed: (){

        },
        ),
        SpeedDialChild(
            backgroundColor: lightRed,
            label: widget.isProfile! ? 'Home' : 'Profile',
            onPressed: () {
              if (widget.isProfile!) {
                Navigator.pop(context);
              } else {
                Constants.profileUserId = Constants.userId;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              }
            },
            child: widget.isProfile! ? SvgPicture.asset(
              home,
              color: white,
            ):SvgPicture.asset(
              profile,
              color: white,
            )),
      ],
    );
  }
}
