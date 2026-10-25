# Known Bugs & Improvements

## 🐛 BUGS

### BUG-001: All Levels Unlocked Despite Incomplete Progress
**Severity**: High | **Status**: Fixed (ad84450) | **Reported**: Feb 10, 2026

User hanya menyelesaikan beberapa level di setiap kategori, tetapi SEMUA level sudah unlocked.

**Root Cause**: `isLevelUnlockedProvider` di `game_providers.dart` memakai `highestUnlockedProvider` (global), sehingga semua level dengan ID di bawah level tertinggi yang pernah diselesaikan ikut terbuka.

**Fix**: Unlock sekarang per-kategori: level N terbuka jika level N-1 di kategori yang sama completed. Level pertama setiap kategori tetap terbuka.

### BUG-002: Rewarded Ad Resets Game Progress
**Severity**: High | **Status**: Fixed (ad84450) | **Reported**: Feb 24, 2026

Setelah gagal 2x, Watch Ad, urutan item RESET ke awal. Seharusnya melanjutkan dari posisi terakhir.

**Root Cause**: Reward callback tidak memanggil `continueGame()`, sehingga `GameScreen` yang baru menganggap game sudah selesai dan memanggil `startGame()` lagi.

**Fix**: Reward callback memanggil `continueGame()` sebelum navigasi kembali ke game.

### BUG-003: Jawaban Benar Ditolak (Sorting Name Multiplayer, dll.)
**Severity**: High | **Status**: Fixed (082158c) | **Reported**: Oct 25, 2026

Urutan yang terlihat benar di layar ditolak karena `sortValue` tidak sesuai dengan `displayValue`.

**Root Cause**:
- Multiplayer names: `sortValue` dihitung base-26 per huruf, jadi nama yang lebih panjang selalu dianggap lebih besar (`Abigail` > `Noah`).
- Multiplayer time: durasi ≥ 1 jam ditampilkan tanpa detik ("1h 47m"), tapi `sortValue` menyimpan detik.
- Multiplayer mixed: desimal bisa dibulatkan ke integer berikutnya ("4428.00" vs "4428").
- Memory formatted: `formatType` 3/4 jatuh ke branch default yang display dan `sortValue`-nya dari dua angka random berbeda.
- Time (regular, memory, daily): display dibulatkan ("17.96 hr" vs "0.75 days"), `sortValue` tidak.

**Fix**: `sortValue` selalu dihitung dari nilai yang ditampilkan. Dijaga oleh `test/sort_value_consistency_test.dart`.

### BUG-004: Interstitial Ad Muncul untuk Pro Users di Multiplayer
**Severity**: High | **Status**: Fixed | **Reported**: Oct 25, 2026

**Root Cause**: `MultiplayerResultsScreen` memanggil `AdService.onLevelCompleted()` tanpa cek `ProService.isPro`.

**Fix**: Tambahkan cek `!ProService.instance.isPro`, sama seperti `ResultScreen`.

## 💡 IMPROVEMENTS

### IMP-001: Interstitial Ad Before Multiplayer Leaderboard
**Priority**: Medium | **Status**: Done | **Reported**: Feb 24, 2026

Tambahkan interstitial ad SEBELUM layar hasil multiplayer. Skip untuk Pro users.
