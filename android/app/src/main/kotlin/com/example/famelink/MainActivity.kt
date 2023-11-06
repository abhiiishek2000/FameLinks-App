package app.famelinks

import androidx.annotation.NonNull;
import com.example.famelink.ListTileNativeAdFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import com.example.google_native_mobile_ads.NativeAdFactoryImplementation;

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
// TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
                flutterEngine, "famelink", ListTileNativeAdFactory(context))
        val factory: GoogleMobileAdsPlugin.NativeAdFactory = NativeAdFactoryImplementation(getLayoutInflater()) // reference to this package created factory
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "google_native_mobile_ads_AdFactory", factory)
    }
    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "famelink")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "google_native_mobile_ads_AdFactory")

    }

}