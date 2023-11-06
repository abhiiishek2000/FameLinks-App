import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:flutter/material.dart';

import '../tour_links_dialogs/famelinks_tour_dialog.dart';

class TourService extends DatabaseProvider {
  Future<bool> checkTourShown(BuildContext context, bool? fromFameLinks,
      bool? fromFunLinks, bool? fromFollowLinks) async {
    bool isShown = await getIsTourShown();
    bool isShownFameLinks = await getIsFameLinksTourShown();
    bool isShownFunLinks = await getIsFunLinksTourShown();
    bool isShownFollowLinks = await getIsFollowLinksTourShown();

    notifyListeners();
    if (isShown == false) {
      print('hii');
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => FameLinksTourDialog(),
        ),
      );
      return false;
    } else if (isShownFameLinks == false && fromFameLinks == true) {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => FameLinksTourDialog(
            initialSelected: ProfileType.FAMELinks,
          ),
        ),
      );
      return false;
    } else if (isShownFunLinks == false && fromFunLinks == true) {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => FameLinksTourDialog(
            initialSelected: ProfileType.FUNLinks,
          ),
        ),
      );
      return false;
    } else if (isShownFollowLinks == false && fromFollowLinks == true) {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => FameLinksTourDialog(
            initialSelected: ProfileType.FOLLOWLinks,
          ),
        ),
      );
      return false;
    } else {
      return true;
    }
  }
}
