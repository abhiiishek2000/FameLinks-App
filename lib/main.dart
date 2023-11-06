import 'dart:io';

import 'package:country_codes/country_codes.dart';
import 'package:double_back_to_close/toast.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:famelink/app_providers.dart';
import 'package:famelink/http_override.dart';
import 'package:famelink/ui/home_feed/provider/home_feed_provider.dart';
import 'package:famelink/ui/notification/service/notification_service.dart';
import 'package:famelink/util/share_pref.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'ui/authentication/login_screen.dart';
import 'ui/home_feed/view/main_feed_screen.dart';
import 'util/config/color.dart';
import 'util/constants.dart';

SharedPreferences? prefs;
bool? isShown;

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

Future<void> main() async {
  // first change

  WidgetsFlutterBinding.ensureInitialized();
  final facebookAppEvents = FacebookAppEvents();

  facebookAppEvents.setAdvertiserTracking(enabled: true);
  await MobileAds.instance.initialize();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HttpOverrides.global = MyHttpOverrides();
  configLoading();
  await CountryCodes.init();
  FirebaseApp amar = await Firebase.initializeApp();
  print("amarfirebase ${amar.options.appId}");
  await AppPreference().initialAppPreference();
  tz.initializeTimeZones();

  await AppNotificationService.appNotificationService.init();
  FirebaseMessaging.onBackgroundMessage(AppNotificationService.messageHandler);
  /*await AndroidAlarmManager.oneShotAt(DateTime.now(), 0,(){  
    FlutterLocalNotificationsPlugin().show(
        456,
        "notification.title",
        "notification.body",
        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              priority: Priority.high
            // other properties...
          ),
        ));
  },alarmClock: true,allowWhileIdle: true,exact: true,wakeup: true,rescheduleOnReboot: true
  );*/

  prefs = await SharedPreferences.getInstance();
  isShown = await HomeFeedProvider().checkIsShown();
  Constants.token = prefs!.getString("token");
  runApp(
    MultiProvider(
      providers: AppProvider.appProvider.providers(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  int waitForSecondBackPress = 2;
  int onFirstBackPress = 1;
  void resetBackTimeout() {
    Future.delayed(Duration(seconds: 2), () {
      onFirstBackPress = 1;
      print("object");
    });
  }

  TextStyle textStyle = const TextStyle(fontSize: 14, color: Colors.white);
  Color background = const Color(0xAA000000);
  double backgroundRadius = 20;
  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return MaterialApp(
        //... other code
        builder: (context, widget) {
          //add this line
          ScreenUtil.init(context);
          //  builder: EasyLoading.init();
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: WillPopScope(
                onWillPop: () async {
                  print("back button press");
                  if (onFirstBackPress == 1) {
                    onFirstBackPress = 2;

                    Toast.show(
                      "Press back again to exit app",
                      context,
                      duration: waitForSecondBackPress,
                      gravity: Toast.bottom,
                      textStyle: textStyle,
                      backgroundColor: background,
                      backgroundRadius: backgroundRadius,
                    );
                    resetBackTimeout();
                    return false;
                  }
                  else {
                    Navigator.of(context).pop(true);
                    exit(0);
                    return false;
                  }
                },
                child: widget!),
          );
        },

        title: 'FameLinks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: appBackgroundColor,
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.nunitoSansTextTheme(),
        ),
        initialRoute: '/',
        routes: getAppRoute(),

        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
      );
    });
  }

  Map<String, WidgetBuilder> getAppRoute() {
    //String firstName;

    return {
      '/': (BuildContext context) => prefs!.getBool('isLoggedIn') == true
          // ignore: unrelated_type_equality_checks
          ? isShown == false
              ? MainFeedScreen()
              : MainFeedScreen(initialSelect: ProfileType.FAMELinks)
          //  ? NativeadsShow()
          : LoginScreen(),
      // 'lets_begin_screen': (BuildContext context) => MyApps(),
    };
  }
}
