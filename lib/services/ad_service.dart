import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../utils/constants.dart';

class AdService {
  bool _isRewardedAdLoaded = false;
  bool _isInterstitialAdLoaded = false;

  void initialize() {
    loadRewardedAd();
    loadInterstitialAd();
  }

  void loadRewardedAd() {
    UnityAds.load(
      placementId: AdConstants.rewardedVideoPlacementId,
      onComplete: (placementId) {
        _isRewardedAdLoaded = true;
        print('Rewarded ad loaded successfully');
      },
      onFailed: (placementId, error, message) {
        _isRewardedAdLoaded = false;
        print('Rewarded ad failed to load: $message');
      },
    );
  }

  void loadInterstitialAd() {
    UnityAds.load(
      placementId: AdConstants.interstitialPlacementId,
      onComplete: (placementId) {
        _isInterstitialAdLoaded = true;
        print('Interstitial ad loaded successfully');
      },
      onFailed: (placementId, error, message) {
        _isInterstitialAdLoaded = false;
        print('Interstitial ad failed to load: $message');
      },
    );
  }

  void showRewardedAd({
    required Function(String) onComplete,
    required Function(String, int, String) onFailed,
  }) {
    if (!_isRewardedAdLoaded) {
      onFailed(AdConstants.rewardedVideoPlacementId, 0, 'Rewarded ad not loaded yet');
      loadRewardedAd();
      return;
    }

    UnityAds.showVideoAd(
      placementId: AdConstants.rewardedVideoPlacementId,
      onComplete: (placementId) {
        _isRewardedAdLoaded = false;
        onComplete(placementId);
      },
      onFailed: (placementId, error, message) {
        _isRewardedAdLoaded = false;
        onFailed(placementId, error, message);
        loadRewardedAd(); // Try to load again
      },
      onStart: (placementId) => print('Rewarded ad started'),
      onClick: (placementId) => print('Rewarded ad clicked'),
    );
  }

  void showInterstitialAd({
    required Function(String) onComplete,
    required Function(String, int, String) onFailed,
  }) {
    if (!_isInterstitialAdLoaded) {
      onFailed(AdConstants.interstitialPlacementId, 0, 'Interstitial ad not loaded yet');
      loadInterstitialAd();
      return;
    }

    UnityAds.showVideoAd(
      placementId: AdConstants.interstitialPlacementId,
      onComplete: (placementId) {
        _isInterstitialAdLoaded = false;
        onComplete(placementId);
        loadInterstitialAd(); // Load another ad for next time
      },
      onFailed: (placementId, error, message) {
        _isInterstitialAdLoaded = false;
        onFailed(placementId, error, message);
        loadInterstitialAd(); // Try to load again
      },
      onStart: (placementId) => print('Interstitial ad started'),
      onClick: (placementId) => print('Interstitial ad clicked'),
    );
  }
}
