package com.example.famelink

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import app.famelinks.R
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class ListTileNativeAdFactory(val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
            nativeAd: NativeAd,
            customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
                .inflate(R.layout.list_tile_native_ad, null) as NativeAdView

        with(nativeAdView) {
//            val attributionViewSmall =
//                    findViewById<TextView>(R.id.primary)
//            val attributionViewLarge =
//                    findViewById<TextView>(R.id.tv_list_tile_native_ad_attribution_large)

            val iconView = findViewById<ImageView>(R.id.icon)
            val icon = nativeAd.icon
            if (icon != null) {
//                attributionViewSmall.visibility = View.VISIBLE
//                attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            } else {
//                attributionViewSmall.visibility = View.INVISIBLE
//                attributionViewLarge.visibility = View.VISIBLE
            }
            this.iconView = iconView

            val media_view = findViewById<MediaView>(R.id.media_view)
            this.mediaView = media_view

            val callToActionView = findViewById<Button>(R.id.cta)
            with(callToActionView) {
                text = nativeAd.callToAction
            }
            this.callToActionView = callToActionView

            val headlineView = findViewById<TextView>(R.id.primary)
            headlineView.text = nativeAd.headline
            this.headlineView = headlineView

            val bodyView = findViewById<TextView>(R.id.body)
            with(bodyView) {
                text = nativeAd.body
            }
            this.bodyView = bodyView

            val rating_bar = findViewById<RatingBar>(R.id.rating_bar)
            with(rating_bar) {
//                 if (nativeAd.starRating != null) {
//                     rating =  nativeAd.starRating.toFloat()
//                }
//                visibility = if (nativeAd.starRating != null) View.VISIBLE else View.INVISIBLE
            }
            this.starRatingView = rating_bar

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}