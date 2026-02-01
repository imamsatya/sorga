import 'dart:io';
import 'dart:async';
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
  InterstitialAd? _interstitialAd;
  bool _isRewardedAdLoading = false;
  bool _isInterstitialAdLoading = false;
  int _loadAttempts = 0;
  static const int _maxLoadAttempts = 3;
  
  // Level completion counter for interstitial
  int _levelCompletionCount = 0;
  static const int _levelsPerInterstitial = 3;
  
  // Debug info for troubleshooting
  String _lastError = '';
  String get lastError => _lastError;
  bool get isInitialized => _isInitialized;
  bool get isLoading => _isRewardedAdLoading;
  
  /// Check if ads are supported on current platform
  static bool get isSupported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  
  // Ad Unit IDs
  // Android: Production IDs | iOS: Test IDs (update when iOS is set up)
  static String get _bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Android test (no banner used)
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS test
    }
    return '';
  }
  
  static String get _rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6136140113407207/6347042499'; // Android PRODUCTION
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // iOS test
    }
    return '';
  }
  
  static String get _interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6136140113407207/7618987487'; // Android PRODUCTION
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // iOS test
    }
    return '';
  }
  
  /// Get debug status for UI display
  String getDebugStatus() {
    if (!isSupported) return 'Platform not supported';
    if (!_isInitialized) return 'Not initialized';
    if (_isRewardedAdLoading) return 'Loading ad... (attempt $_loadAttempts)';
    if (_rewardedAd != null) return 'Ad ready ✓';
    if (_lastError.isNotEmpty) return 'Error: $_lastError';
    return 'No ad loaded';
  }
  
  /// Initialize Mobile Ads SDK
  Future<void> initialize() async {
    if (!isSupported) {
      debugPrint('📢 AdService: Platform not supported (web)');
      return;
    }
    
    if (_isInitialized) {
      debugPrint('📢 AdService: Already initialized');
      return;
    }
    
    try {
      debugPrint('📢 AdService: Initializing MobileAds SDK...');
      final initStatus = await MobileAds.instance.initialize();
      
      // Log adapter status
      initStatus.adapterStatuses.forEach((key, value) {
        debugPrint('📢 AdService: Adapter $key: ${value.state} - ${value.description}');
      });
      
      _isInitialized = true;
      debugPrint('📢 AdService: ✓ Initialized successfully');
      
      // Pre-load ads
      _loadRewardedAd();
      _loadInterstitialAd();
    } catch (e) {
      _lastError = e.toString();
      debugPrint('📢 AdService: ✗ Initialization failed: $e');
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
        onAdLoaded: (ad) {
          debugPrint('📢 AdService: Banner ad loaded');
          onAdLoaded(ad);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('📢 AdService: Banner ad failed: ${error.message}');
          onAdFailedToLoad(ad, error);
        },
      ),
    );
    
    _bannerAd!.load();
    return _bannerAd;
  }
  
  /// Load rewarded ad (pre-load for later use)
  void _loadRewardedAd() {
    if (!isSupported || !_isInitialized) {
      debugPrint('📢 AdService: Cannot load - not ready');
      return;
    }
    
    if (_isRewardedAdLoading) {
      debugPrint('📢 AdService: Already loading rewarded ad');
      return;
    }
    
    if (_loadAttempts >= _maxLoadAttempts) {
      debugPrint('📢 AdService: Max load attempts reached');
      _lastError = 'Max attempts reached';
      return;
    }
    
    _isRewardedAdLoading = true;
    _loadAttempts++;
    _lastError = '';
    
    debugPrint('📢 AdService: Loading rewarded ad (attempt $_loadAttempts)...');
    debugPrint('📢 AdService: Using ad unit: ${_rewardedAdUnitId}');
    
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedAdLoading = false;
          _loadAttempts = 0; // Reset on success
          debugPrint('📢 AdService: ✓ Rewarded ad loaded successfully!');
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _isRewardedAdLoading = false;
          _lastError = '${error.code}: ${error.message}';
          debugPrint('📢 AdService: ✗ Rewarded ad failed: ${error.code} - ${error.message}');
          
          // Retry after delay if under max attempts
          if (_loadAttempts < _maxLoadAttempts) {
            debugPrint('📢 AdService: Will retry in 5 seconds...');
            Future.delayed(const Duration(seconds: 5), () {
              _loadRewardedAd();
            });
          }
        },
      ),
    );
  }
  
  /// Force reload rewarded ad (for manual retry)
  void reloadRewardedAd() {
    _loadAttempts = 0;
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _loadRewardedAd();
  }
  
  /// Check if rewarded ad is ready
  bool get isRewardedAdReady => _rewardedAd != null;
  
  /// Show rewarded ad and call callback on reward earned
  Future<bool> showRewardedAd({
    required void Function() onRewarded,
    void Function()? onAdClosed,
  }) async {
    if (!isSupported) {
      debugPrint('📢 AdService: Platform not supported');
      return false;
    }
    
    if (_rewardedAd == null) {
      debugPrint('📢 AdService: Rewarded ad not ready');
      // Try to reload
      if (!_isRewardedAdLoading) {
        _loadAttempts = 0;
        _loadRewardedAd();
      }
      return false;
    }
    
    debugPrint('📢 AdService: Showing rewarded ad...');
    
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        debugPrint('📢 AdService: Ad displayed on screen');
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('📢 AdService: Ad dismissed');
        ad.dispose();
        _rewardedAd = null;
        onAdClosed?.call();
        // Pre-load next ad
        _loadAttempts = 0;
        _loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('📢 AdService: Ad failed to show: ${error.message}');
        _lastError = error.message;
        ad.dispose();
        _rewardedAd = null;
        // Pre-load next ad
        _loadAttempts = 0;
        _loadRewardedAd();
      },
    );
    
    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('📢 AdService: ✓ User earned reward: ${reward.amount} ${reward.type}');
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
  
  /// Load interstitial ad
  void _loadInterstitialAd() {
    if (!isSupported || !_isInitialized || _isInterstitialAdLoading) return;
    
    _isInterstitialAdLoading = true;
    debugPrint('📢 AdService: Loading interstitial ad...');
    
    InterstitialAd.load(
      adUnitId: _interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoading = false;
          debugPrint('📢 AdService: ✓ Interstitial ad loaded');
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _isInterstitialAdLoading = false;
          debugPrint('📢 AdService: ✗ Interstitial ad failed: ${error.message}');
        },
      ),
    );
  }
  
  /// Call this when a level is completed successfully
  /// Returns true if an interstitial ad was shown
  Future<bool> onLevelCompleted() async {
    if (!isSupported || !_isInitialized) return false;
    
    _levelCompletionCount++;
    debugPrint('📢 AdService: Level completed ($_levelCompletionCount/$_levelsPerInterstitial)');
    
    if (_levelCompletionCount >= _levelsPerInterstitial) {
      _levelCompletionCount = 0;
      return await _showInterstitialAd();
    }
    
    return false;
  }
  
  /// Show interstitial ad
  Future<bool> _showInterstitialAd() async {
    if (_interstitialAd == null) {
      debugPrint('📢 AdService: Interstitial not ready');
      _loadInterstitialAd();
      return false;
    }
    
    debugPrint('📢 AdService: Showing interstitial ad...');
    
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('📢 AdService: Interstitial dismissed');
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitialAd(); // Pre-load next
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('📢 AdService: Interstitial failed to show: ${error.message}');
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitialAd();
      },
    );
    
    await _interstitialAd!.show();
    return true;
  }
  
  /// Dispose all ads
  void dispose() {
    disposeBannerAd();
    _rewardedAd?.dispose();
    _rewardedAd = null;
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }
}
