import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../constants/app_constants.dart';

/// Service to manage Pro status and In-App Purchases
class ProService {
  static ProService? _instance;
  static ProService get instance => _instance ??= ProService._();
  
  ProService._();
  
  Box<dynamic>? _settingsBox;
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  
  // Purchase state
  bool _isAvailable = false;
  ProductDetails? _proProduct;
  bool _isPurchasing = false;
  String? _lastError;
  
  // Callbacks for UI updates
  Function()? onPurchaseSuccess;
  Function(String error)? onPurchaseError;
  Function()? onStateChanged;
  
  /// Check if IAP is supported on current platform
  static bool get isSupported {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }
  
  /// Initialize with settings box reference and start IAP listener
  Future<void> init(Box<dynamic> settingsBox) async {
    _settingsBox = settingsBox;
    
    if (!isSupported) {
      debugPrint('ProService: IAP not supported on this platform');
      return;
    }
    
    // Check if store is available
    _isAvailable = await _iap.isAvailable();
    if (!_isAvailable) {
      debugPrint('ProService: Store not available');
      return;
    }
    
    // Listen to purchase updates
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (error) {
        debugPrint('ProService: Purchase stream error: $error');
      },
    );
    
    // Load product details
    await _loadProducts();
    
    debugPrint('ProService: Initialized, isPro=$isPro, product=${_proProduct?.id}');
  }
  
  /// Load product details from store
  Future<void> _loadProducts() async {
    try {
      final response = await _iap.queryProductDetails({AppConstants.iapProductId});
      
      if (response.error != null) {
        debugPrint('ProService: Error loading products: ${response.error}');
        return;
      }
      
      if (response.notFoundIDs.isNotEmpty) {
        debugPrint('ProService: Product not found: ${response.notFoundIDs}');
        // Product not configured in store yet
      }
      
      if (response.productDetails.isNotEmpty) {
        _proProduct = response.productDetails.first;
        debugPrint('ProService: Product loaded: ${_proProduct?.id} - ${_proProduct?.price}');
      }
    } catch (e) {
      debugPrint('ProService: Exception loading products: $e');
    }
  }
  
  /// Handle purchase updates
  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchase in purchaseDetailsList) {
      debugPrint('ProService: Purchase update: ${purchase.productID} status=${purchase.status}');
      
      if (purchase.productID != AppConstants.iapProductId) continue;
      
      switch (purchase.status) {
        case PurchaseStatus.pending:
          _isPurchasing = true;
          onStateChanged?.call();
          break;
          
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _handleSuccessfulPurchase(purchase);
          break;
          
        case PurchaseStatus.error:
          _isPurchasing = false;
          _lastError = purchase.error?.message ?? 'Purchase failed';
          onPurchaseError?.call(_lastError!);
          onStateChanged?.call();
          break;
          
        case PurchaseStatus.canceled:
          _isPurchasing = false;
          onStateChanged?.call();
          break;
      }
      
      // Complete pending purchases
      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
  }
  
  /// Handle successful purchase or restore
  Future<void> _handleSuccessfulPurchase(PurchaseDetails purchase) async {
    _isPurchasing = false;
    
    // Verify purchase (basic verification - for production use server-side)
    // For now, we trust the store's verification
    
    await setProStatus(true);
    onPurchaseSuccess?.call();
    onStateChanged?.call();
    
    debugPrint('ProService: Purchase successful! isPro=true');
  }
  
  /// Check if user has Pro status
  bool get isPro {
    return _settingsBox?.get(AppConstants.isProKey, defaultValue: false) ?? false;
  }
  
  /// Is store available
  bool get isStoreAvailable => _isAvailable && _proProduct != null;
  
  /// Is purchase in progress
  bool get isPurchasing => _isPurchasing;
  
  /// Get last error message
  String? get lastError => _lastError;
  
  /// Get Pro product details
  ProductDetails? get proProduct => _proProduct;
  
  /// Get formatted price string
  String get priceString => _proProduct?.price ?? '\$4.99';
  
  /// Set Pro status (for testing or after purchase)
  Future<void> setProStatus(bool value) async {
    await _settingsBox?.put(AppConstants.isProKey, value);
  }
  
  /// Initiate purchase
  Future<bool> purchasePro() async {
    if (!isSupported) {
      _lastError = 'In-app purchase not supported on this platform';
      return false;
    }
    
    if (!_isAvailable || _proProduct == null) {
      _lastError = 'Store not available or product not found';
      return false;
    }
    
    if (_isPurchasing) {
      return false; // Already in progress
    }
    
    _isPurchasing = true;
    _lastError = null;
    onStateChanged?.call();
    
    try {
      final purchaseParam = PurchaseParam(productDetails: _proProduct!);
      final success = await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      
      if (!success) {
        _isPurchasing = false;
        _lastError = 'Failed to initiate purchase';
        onStateChanged?.call();
        return false;
      }
      
      return true;
    } catch (e) {
      _isPurchasing = false;
      _lastError = e.toString();
      onStateChanged?.call();
      return false;
    }
  }
  
  /// Restore previous purchases
  Future<void> restorePurchases() async {
    if (!isSupported || !_isAvailable) {
      _lastError = 'Store not available';
      onPurchaseError?.call(_lastError!);
      return;
    }
    
    try {
      await _iap.restorePurchases();
    } catch (e) {
      _lastError = e.toString();
      onPurchaseError?.call(_lastError!);
    }
  }
  
  /// Get maximum attempts allowed based on game mode and Pro status
  /// Returns -1 for truly unlimited (Pro)
  int getMaxAttempts({required bool isMemoryMode}) {
    if (isPro) {
      return -1; // Truly unlimited
    }
    return isMemoryMode 
        ? AppConstants.maxAttemptsMemory 
        : AppConstants.maxAttemptsRegular;
  }
  
  /// Check if user can continue after failed attempt
  /// Pro users always return true (truly unlimited)
  bool canContinue({required int failedAttempts, required bool isMemoryMode}) {
    if (isPro) {
      return true; // Pro users never run out of chances
    }
    final maxAttempts = getMaxAttempts(isMemoryMode: isMemoryMode);
    return failedAttempts < maxAttempts;
  }
  
  /// Get remaining attempts
  /// Returns -1 for unlimited (Pro users)
  int getRemainingAttempts({required int failedAttempts, required bool isMemoryMode}) {
    if (isPro) {
      return -1; // Unlimited
    }
    final maxAttempts = getMaxAttempts(isMemoryMode: isMemoryMode);
    return maxAttempts - failedAttempts;
  }
  
  /// Check if remaining attempts should be displayed
  /// Returns false for Pro users (unlimited)
  bool shouldShowRemaining({required int failedAttempts, required bool isMemoryMode}) {
    return !isPro;
  }
  
  /// Cleanup
  void dispose() {
    _subscription?.cancel();
  }
}
