import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../utils/constants.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // Listen for ad load events
    UnityAds.load(
      placementId: AdConstants.bannerPlacementId,
      onComplete: (placementId) {
        if (mounted) {
          setState(() => _isAdLoaded = true);
        }
      },
      onFailed: (placementId, error, message) {
        print('Banner ad failed to load: $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: UnityBannerAd(
        placementId: AdConstants.bannerPlacementId,
        onLoad: (placementId) => print('Banner ad loaded'),
        onClick: (placementId) => print('Banner ad clicked'),
        onFailed: (placementId, error, message) => print('Banner ad failed: $message'),
        onStart: (placementId) => print('Banner ad started'),
      ),
    );
  }
}
