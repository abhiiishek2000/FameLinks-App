import 'dart:io';

class AdHelper {
  static String get famelinks {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8256017943830665~2663473544';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get famelinksExplore {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8256017943830665/7342506035';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get famelinksFeed {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8256017943830665/4907914388';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get followLinksExplore {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8256017943830665/6612302003';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get followLinksFeed {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8256017943830665/6689105191';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get funlinksExplore {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8256017943830665/1628350206';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get funlinksFeed {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8256017943830665/9506840220';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }

  // static String get nativeAdUnitId {
  //   if (Platform.isAndroid) {
  //     // return 'ca-app-pub-8256017943830665/4907914388';
  //     return 'ca-app-pub-3940256099942544/2247696110';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-1224122391151794/3915692145';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
  // static String get fameIntersAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-8256017943830665/3876047431';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-1224122391151794/3915692145';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
  // static String get funLinksNativeAdUnitId {
  //   if (Platform.isAndroid) {
  //     // return 'ca-app-pub-1224122391151794/5838555004';
  //     return 'ca-app-pub-3940256099942544/2247696110';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-1224122391151794/3915692145';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
  // static String get followLinksNativeAdUnitId {
  //   if (Platform.isAndroid) {
  //     // return 'ca-app-pub-1224122391151794/9662766866';
  //     return 'ca-app-pub-3940256099942544/2247696110';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-1224122391151794/3915692145';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
  // static String get exploreNativeAdUnitId {
  //   if (Platform.isAndroid) {
  //     // return 'ca-app-pub-8256017943830665/7342506035';
  //     return 'ca-app-pub-8256017943830665/1988250692';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-1224122391151794/3915692145';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
  // static String get exploreFunLinksNativeAdUnitId {
  //   if (Platform.isAndroid) {
  //     // return 'ca-app-pub-8256017943830665/1628350206';
  //     return 'ca-app-pub-8256017943830665/3109760676';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-1224122391151794/3915692145';
  //   }
  //   throw new UnsupportedError("Unsupported platform");
  // }
}
