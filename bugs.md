# Known Bugs & Improvements

## 🐛 BUGS

### BUG-001: All Levels Unlocked Despite Incomplete Progress
**Severity**: High | **Status**: Open | **Reported**: Feb 10, 2026

User hanya menyelesaikan beberapa level di setiap kategori, tetapi SEMUA level sudah unlocked.

**Root Cause**: `isLevelUnlockedProvider` di `game_providers.dart` membuka level pertama SETIAP kategori secara default.

**Fix**: Hanya unlock Level 1 default. Kategori lain baru terbuka jika level terakhir kategori sebelumnya completed.

### BUG-002: Rewarded Ad Resets Game Progress
**Severity**: High | **Status**: Open | **Reported**: Feb 24, 2026

Setelah gagal 2x, Watch Ad, urutan item RESET ke awal. Seharusnya melanjutkan dari posisi terakhir.

**Root Cause**: `continueGame()` di `game_state_provider.dart` kemungkinan me-reset `currentOrder`.

## 💡 IMPROVEMENTS

### IMP-001: Interstitial Ad Before Multiplayer Leaderboard
**Priority**: Medium | **Reported**: Feb 24, 2026

Tambahkan interstitial ad SEBELUM layar hasil multiplayer. Skip untuk Pro users.
