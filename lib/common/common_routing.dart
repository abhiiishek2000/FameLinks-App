import 'package:famelink/ui/Famelinkprofile/ProfileFameLink.dart';
import 'package:famelink/ui/followLinks/ui/FollowLinksUserProfile.dart';
import 'package:famelink/ui/funlinks/ui/FunLinksUserProfile.dart';
import 'package:famelink/ui/home_feed/component/home_feed.dart';
import 'package:famelink/ui/homedial/ui/editUserProfile.dart';
import 'package:famelink/ui/otherUserProfile/OthersProfile.dart';
import 'package:flutter/material.dart';

// goto FameLinks Feed
gotoFameLinksFeedScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomeFeed(),
    ),
  );
}

gotoProfileFameLinkScreen(BuildContext context, {id, selectPhase, status}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ProfileFameLink(selectPhase: selectPhase, id: id, status: status),
    ),
  );
}

gotoOtherProfileScreen(BuildContext context, String id, int selectPhase) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OtherProfile(id: id, selectPhase: selectPhase),
    ),
  );
}

// gotoFameLinkUserProfileScreen(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => FameLinksUserProfile(),
//     ),
//   );
// }

gotoFunLinksUserProfileScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => FunLinksUserProfile(),
    ),
  );
}

gotoProfileFunLinksScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil<void>(
    context,
    MaterialPageRoute<void>(
        builder: (BuildContext context) => ProfileFameLink(
              selectPhase: 1,
            )),
    ModalRoute.withName('/'),
  );
}

gotoFollowLinksUserProfileScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FollowLinksUserProfile(),
    ),
  );
}

gotoProfileFollowLinksScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil<void>(
    context,
    MaterialPageRoute<void>(
        builder: (BuildContext context) => ProfileFameLink(
              selectPhase: 2,
            )),
    ModalRoute.withName('/'),
  );
}

gotoJobLinksUserProfileScreen(BuildContext context) {}

gotoUserEditProfileScreen(
  BuildContext context, {
  int? runTypes,
  String? names,
  String? professions,
  String? bios,
  String? imagUrls,
  String? imageType,
  String? userNames,
  String? districts,
  String? states,
  String? countrys,
  bool? isProfileUpdate,
  String? dobs,
}) {
  debugPrint("111 runType ${runTypes}");
  debugPrint("111 name ${names}");
  debugPrint("111 profession ${professions}");
  debugPrint("111 bio ${bios}");
  debugPrint("111 imagUrl ${imagUrls}");
  debugPrint("111 imgType ${imageType}");
  debugPrint("111 userName ${userNames}");
  debugPrint("111 district ${districts}");
  debugPrint("111 state ${states}");
  debugPrint("111 country ${countrys}");
  debugPrint("111 dob ${dobs}");
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => EditUserProfile(
              runType: runTypes!.toInt(),
              dob: dobs.toString(),
              name: names.toString(),
              profession: professions.toString(),
              bio: bios.toString(),
              imagUrl: imagUrls.toString(),
              imageType: imageType.toString(),
              userName: userNames.toString(),
              district: districts.toString(),
              state: states.toString(),
              isProfileUpdate: false,
              country: countrys.toString(),
            ),
        maintainState: true),
  );
}
