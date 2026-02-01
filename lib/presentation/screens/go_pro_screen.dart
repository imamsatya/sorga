import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/pro_service.dart';
import '../../l10n/app_localizations.dart';

/// Go Pro upgrade screen
class GoProScreen extends ConsumerStatefulWidget {
  const GoProScreen({super.key});

  @override
  ConsumerState<GoProScreen> createState() => _GoProScreenState();
}

class _GoProScreenState extends ConsumerState<GoProScreen> {
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _setupCallbacks();
  }
  
  void _setupCallbacks() {
    ProService.instance.onPurchaseSuccess = () {
      setState(() => _isLoading = false);
      _showSuccessDialog();
    };
    
    ProService.instance.onPurchaseError = (error) {
      setState(() => _isLoading = false);
      _showErrorSnackbar(error);
    };
    
    ProService.instance.onStateChanged = () {
      if (mounted) setState(() {});
    };
  }
  
  void _showSuccessDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Text('🎉', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Text(l10n.purchaseSuccess, style: const TextStyle(color: AppTheme.textPrimary)),
          ],
        ),
        content: Text(
          l10n.youAreNowPro,
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.go('/');
            },
            child: Text(l10n.ok, style: const TextStyle(color: AppTheme.primaryColor)),
          ),
        ],
      ),
    );
  }
  
  void _showErrorSnackbar(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('❌ $error'),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }
  
  Future<void> _handlePurchase() async {
    if (ProService.instance.isPro) {
      _showAlreadyProSnackbar();
      return;
    }
    
    setState(() => _isLoading = true);
    await ProService.instance.purchasePro();
  }
  
  Future<void> _handleRestore() async {
    setState(() => _isLoading = true);
    await ProService.instance.restorePurchases();
    
    // Wait a bit for restore to process
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      if (ProService.instance.isPro) {
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.noPurchasesToRestore),
            backgroundColor: AppTheme.warningColor,
          ),
        );
      }
    }
  }
  
  void _showAlreadyProSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ ${AppLocalizations.of(context)!.alreadyPro}'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPro = ProService.instance.isPro;
    final price = ProService.instance.priceString;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildProBadge(),
                      const SizedBox(height: 24),
                      _buildBenefitsList(l10n),
                      const SizedBox(height: 32),
                      if (!isPro) ...[
                        _buildPurchaseButton(l10n, price),
                        const SizedBox(height: 16),
                        _buildRestoreButton(l10n),
                      ] else
                        _buildAlreadyProBadge(l10n),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
          ),
          const Expanded(
            child: Text(
              'Go Pro',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
  
  Widget _buildProBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('👑', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 12),
          const Text(
            'SORTIQ PRO',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ProService.instance.isPro ? 'Activated!' : 'Premium Experience',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBenefitsList(AppLocalizations l10n) {
    final benefits = [
      (icon: '🚫', title: l10n.noAds, subtitle: l10n.noAdsDesc),
      (icon: '♾️', title: l10n.unlimitedAttempts, subtitle: l10n.unlimitedAttemptsDesc),
      (icon: '👑', title: l10n.proBadge, subtitle: l10n.proBadgeDesc),
      (icon: '💝', title: l10n.supportDev, subtitle: l10n.supportDevDesc),
    ];
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.textMuted.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.whatYouGet,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...benefits.map((b) => _buildBenefitItem(b.icon, b.title, b.subtitle)),
        ],
      ),
    );
  }
  
  Widget _buildBenefitItem(String icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: AppTheme.successColor, size: 24),
        ],
      ),
    );
  }
  
  Widget _buildPurchaseButton(AppLocalizations l10n, String price) {
    final isLoading = _isLoading || ProService.instance.isPurchasing;
    
    return GestureDetector(
      onTap: isLoading ? null : _handlePurchase,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: isLoading 
              ? null 
              : const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                ),
          color: isLoading ? AppTheme.textMuted : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isLoading ? null : [
            BoxShadow(
              color: const Color(0xFFFFD700).withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            else ...[
              const Text('👑', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
            ],
            const SizedBox(width: 8),
            Text(
              isLoading ? l10n.processing : '${l10n.goPro} - $price',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRestoreButton(AppLocalizations l10n) {
    return TextButton(
      onPressed: _isLoading ? null : _handleRestore,
      child: Text(
        l10n.restorePurchases,
        style: TextStyle(
          fontSize: 14,
          color: AppTheme.textSecondary.withValues(alpha: 0.8),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
  
  Widget _buildAlreadyProBadge(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.successColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('✅', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Text(
            l10n.alreadyPro,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.successColor,
            ),
          ),
        ],
      ),
    );
  }
}
