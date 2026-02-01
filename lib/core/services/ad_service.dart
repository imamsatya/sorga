import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Service to manage AdMob ads
/// Only works on iOS and Android - gracefully disabled on web
class AdService {
  static AdService? _instance;
  static AdService get instance => _instance ??= AdService._();
  
  AdService._();
  
  bool _isInitialized = false;
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoading = false;
  
  /// Check if ads are supported on current platform
  static bool get isSupported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  
  // Test Ad Unit IDs
  static String get _bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Android test
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS test
    }
    return '';
  }
  
  static String get _rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Android test
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // iOS test
    }
    return '';
  }
  
  /// Initialize Mobile Ads SDK
  Future<void> initialize() async {
    if (!isSupported || _isInitialized) return;
    
    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('AdMob initialized successfully');
      
      // Pre-load rewarded ad
      _loadRewardedAd();
    } catch (e) {
      debugPrint('AdMob initialization failed: $e');
    }
  }
  
  /// Load a banner ad
  BannerAd? loadBannerAd({
    required void Function(Ad) onAdLoaded,
    required void Function(Ad, LoadAdError) onAdFailedToLoad,
  }) {
    if (!isSupported || !_isInitialized) return null;
    
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
      ),
    );
    
    _bannerAd!.load();
    return _bannerAd;
  }
  
  /// Load rewarded ad (pre-load for later use)
  void _loadRewardedAd() {
    if (!isSupported || !_isInitialized || _isRewardedAdLoading) return;
    
    _isRewardedAdLoading = true;
    
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedAdLoading = false;
          debugPrint('Rewarded ad loaded');
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _isRewardedAdLoading = false;
          debugPrint('Rewarded ad failed to load: $error');
        },
      ),
    );
  }
  
  /// Check if rewarded ad is ready
  bool get isRewardedAdReady => _rewardedAd != null;
  
  /// Show rewarded ad and call callback on reward earned
  Future<bool> showRewardedAd({
    required void Function() onRewarded,
    void Function()? onAdClosed,
  }) async {
    if (!isSupported || _rewardedAd == null) {
      debugPrint('Rewarded ad not ready');
      return false;
    }
    
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        onAdClosed?.call();
        // Pre-load next ad
        _loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewardedAd = null;
        debugPrint('Rewarded ad failed to show: $error');
        // Pre-load next ad
        _loadRewardedAd();
      },
    );
    
    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('User earned reward: ${reward.amount} ${reward.type}');
        onRewarded();
      },
    );
    
    return true;
  }
  
  /// Dispose banner ad
  void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }
  
  /// Dispose all ads
  void dispose() {
    disposeBannerAd();
    _rewardedAd?.dispose();
    _rewardedAd = null;
  }
}
