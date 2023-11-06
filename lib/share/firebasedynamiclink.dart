import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../ui/home_feed/provider/home_feed_provider.dart';
import '../ui/home_feed/view/main_feed_screen.dart';
import '../ui/otherUserProfile/OthersProfile.dart';

class Sharedynamic {
  // Future<void> buildDynamicLinks(List dataurl, String path) async {
  //   String url = 'https://famelinksapp.page.link';
  //   String? data;
  //   dataurl.forEach((element) {
  //     data = "$data/$element";
  //   });
  //   final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
  //       link: Uri.parse('$url/$path/$data'),
  //       uriPrefix: url,
  //       androidParameters:
  //           const AndroidParameters(packageName: 'app.famelinks'),
  //       iosParameters: const IOSParameters(
  //           bundleId: "com.fame.famelink",
  //           minimumVersion: "1.0.1",
  //           appStoreId: "1641070833"),
  //       socialMetaTagParameters: SocialMetaTagParameters(
  //         description: 'In loving memory of ',
  //         title: 'FamLinkFeed',
  //         // imageUrl: Uri.parse("imageurl")
  //       ));
  //
  //   final dynamicLink =
  //       await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
  //   print("buildDynamicLinks $dynamicLink");
  //   await Share.share(dynamicLink.shortUrl.toString(), subject: 'name');
  // }

  static shareprofile(String id, String path, String proname) async {
    String url = 'https://famelinksapp.page.link';
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse('$url/$path/$id'),
        uriPrefix: url,
        androidParameters:
            const AndroidParameters(packageName: 'app.famelinks'),
        iosParameters: const IOSParameters(
            bundleId: "com.fame.famelink",
            minimumVersion: "1.0.1",
            appStoreId: "1641070833"),
        socialMetaTagParameters: SocialMetaTagParameters(
          description: proname,
          title: 'FamLinkFeed',
          // imageUrl: Uri.parse("imageurl")
        ));

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    print("buildDynamicLinks $dynamicLink");
    await Share.share(dynamicLink.shortUrl.toString(), subject: 'name');
  }

  Future<void> onInitDynamicLinks(context) async {
    print("buildDynamicLinksload");
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // Example of using the dynamic link to push the user to a different screen

      handleMyLink(deepLink, context);
      print(deepLink);
      print(deepLink.path);
    }
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleMyLink(dynamicLinkData.link, context);
    }).onError((error) {
      // Handle errors
    });
  }

  void handleMyLink(Uri url, context) async {
    print("data  handleMyLink");
    List<String> splitLink = [];
    splitLink.addAll(url.path.split('/'));
    print("data  $splitLink");
    if (splitLink[1] == 'famelinkfeed') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainFeedScreen(
            initialSelect: ProfileType.FAMELinks,
            id:splitLink[3],
          ),
        ),
      );
   ;
      // rauts().createRoute(FameLinksFeed());
    } else if (splitLink[1] == 'funlinkfeed') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainFeedScreen(
            initialSelect: ProfileType.FUNLinks,
            id:splitLink[3],
          ),
        ),
      );
    } else if (splitLink[1] == 'followlinkfeed') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainFeedScreen(
            initialSelect: ProfileType.FOLLOWLinks,
            id:splitLink[3],
          ),
        ),
      );
    } else if (splitLink[1] == 'otherprofilefame') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtherProfile(id: splitLink[2], selectPhase: 0),
        ),
      );
    } else if (splitLink[1] == 'otherprofilefun') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtherProfile(id: splitLink[2], selectPhase: 1),
        ),
      );
    } else if (splitLink[1] == 'otherprofilefollow') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtherProfile(id: splitLink[2], selectPhase: 2),
        ),
      );
    }
  }
}
