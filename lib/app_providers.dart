import 'package:famelink/check_app_update.dart';
import 'package:famelink/databse/db_provider.dart';
import 'package:famelink/media_compression_provider.dart';
import 'package:famelink/providers/AuthProvider/auth_provider.dart';
import 'package:famelink/providers/ChallengeProvider/famelinkChallengeProvider.dart';
import 'package:famelink/tour_links_dialogs/provider/tour_dialog_provider.dart';
import 'package:famelink/ui/fameLinks/provider/FameLinksFeedProvider.dart';
import 'package:famelink/ui/followLinks/provider/FollowLinksFeedProvider.dart';
import 'package:famelink/ui/funlinks/provider/FunLinksFeedProvider.dart';
import 'package:famelink/providers/FeedProvider/GetParticularFunLinksProfileProvider.dart';
import 'package:famelink/providers/FeedProvider/GetParticularUserProfileProvider.dart';
import 'package:famelink/providers/FeedProvider/GetPerticularFollowLinksProfileProvider.dart';
import 'package:famelink/providers/FeedVideoProvider/FeedVideoProvider.dart';
import 'package:famelink/providers/JobLinks/ambassadors_provider.dart';
import 'package:famelink/providers/NotificationProvider/famelink_notification_provider.dart';
import 'package:famelink/providers/UserProfileProvider/edit_user_profile_provider.dart';
import 'package:famelink/providers/UserProfileProvider/userProfile_provider.dart';
import 'package:famelink/providers/messages_provider.dart';
import 'package:famelink/ui/fameLinks/provider/FameLinksFeedProvider.dart';
import 'package:famelink/ui/followLinks/provider/FollowLinksFeedProvider.dart';
import 'package:famelink/ui/funlinks/provider/FunLinksFeedProvider.dart';
import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:famelink/util/tour_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'databse/pathlinkprovider.dart';
import 'nativeads/nativeadsprovider.dart';
import 'ui/Famelinkprofile/function/famelinkFun.dart';
import 'ui/Famelinkprofile/function/otplogin.dart';
import 'ui/followlinkexplore/followexploreprovider.dart';
import 'ui/otherUserProfile/provder/OtherPofileprovider.dart';

class AppProvider {
  AppProvider._();

  static final AppProvider appProvider = AppProvider._();

  List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (_) => Pathlink()),
      ChangeNotifierProvider(create: (_) => Followexploreprovider()),
      ChangeNotifierProvider(create: (_) => Nativeadsprovider()),
      ChangeNotifierProvider(create: (_) => HomeFeedProvider()),
      ChangeNotifierProvider(create: (_) => Otplogin()),
      ChangeNotifierProvider(create: (_) => OtherPofileprovider()),
      ChangeNotifierProvider(create: (_) => FameLinkFun()),
      ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ChangeNotifierProvider(create: (_) => FameLinksFeedProvider()),
      ChangeNotifierProvider(create: (_) => FunLinksFeedProvider()),
      ChangeNotifierProvider(create: (_) => FollowLinksFeedProvider()),
      ChangeNotifierProvider(
          create: (_) => GetParticularFunLinksProfileProvider()),
      ChangeNotifierProvider(
          create: (_) => GetParticularFameLinksProfileProvider()),
      ChangeNotifierProvider(
          create: (_) => GetParticularFollowLinksProfileProvider()),
      ChangeNotifierProvider(create: (_) => ChallengeScreenProvider()),
      ChangeNotifierProvider(create: (_) => GetAmbassadorsProvider()),
      ChangeNotifierProvider(create: (_) => GetNotificationProvider()),
      ChangeNotifierProvider(create: (_) => UserEditProfileProvider()),
      ChangeNotifierProvider(create: (_) => MessagesProvider()),
      ChangeNotifierProvider(create: (_) => CheckAppUpdateProvider()),
      ChangeNotifierProvider(create: (_) => MediaCompressionProvider()),
      ChangeNotifierProvider(create: (_) => FeedVideoProvider()),
      ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ChangeNotifierProvider(create: (_) => TourDialogProvider()),
      ChangeNotifierProvider(create: (_) => TourService()),
    ];
  }
}
