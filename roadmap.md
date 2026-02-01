# Sorga App - Development Roadmap & To-Do List

Dokumen ini merangkum rencana pengembangan aplikasi "Sorga" berdasarkan diskusi kita sejauh ini, mencakup fitur baru, strategi monetisasi, dan peningkatan teknis.

## 🚀 Phase 1: Gameplay Expansion (Memory Mode)
Fitur utama berikutnya: Mode Hafalan untuk 5 kategori angka.

- [ ] **Implementasi Kategori Baru**: Menambahkan 5 varian kategori "Memory" di `LevelCategory` (Basic Memory, Time Memory, etc).
- [ ] **Mekanik "Fading Numbers"**:
    - [ ] Ubah `GameItem` agar bisa memiliki state `isVisible`.
    - [ ] Buat Timer Countdown di awal level (durasi dinamis berdasarkan jumlah item).
    - [ ] Implementasi efek *fade out* / tutup angka setelah timer habis.
    - [ ] Opsi tombol "Peek" (Intip) dengan penalti (opsional).
- [ ] **Level Data**: Generate level data khusus untuk mode Memory (bisa re-use pola level normal tapi dengan flag `isMemory`).

## 🔓 Phase 2: Progression System (Sistem Kunci)
Agar game terasa menantang dan berjenjang.

- [ ] **Logic Lock/Unlock**:
    - [ ] Update `isLevelUnlocked` provider.
    - [ ] Rule: Kategori Memory terkunci sampai user menyelesaikan Level X (misal Lv 50) di Kategori Normal.
- [ ] **Visual Feedback**:
    - [ ] Tampilkan ikon Gembok 🔒 di menu kategori yang belum terbuka.
    - [ ] Tampilkan syarat progress bar: "Finish 20/50 levels to unlock".

## 💰 Phase 3: Monetization (Sultan/Pro Version)
Strategi mendapatkan revenue tanpa server.

- [ ] **Fitur "Undo" & "Life"**:
    - [ ] Tambahkan tombol Undo.
    - [ ] Limit Undo untuk user gratis (misal 3x per level).
    - [ ] Unlimited Undo untuk user Pro.
- [ ] **Ads Integration (AdMob)**:
    - [ ] Banner Ad di bawah layar (non-intrusive).
    - [ ] Interstitial Ad setiap X level selesai.
- [ ] **In-App Purchase (IAP)**:
    - [ ] Paket "Remove Ads" (Beli Putus).
    - [ ] Paket "Pro Bundle" (Remove Ads + Unlimited Undo + Unlock All Themes).

## 🛠️ Phase 4: Technical Polish (Local-First Improvements)
Peningkatan kualitas tanpa biaya server.

- [ ] **Cloud Save (Backup)**:
    - [ ] Integrasi `games_services` (Android) dan iCloud (iOS) agar data save aman saat ganti HP.
- [ ] **Localization (Bahasa)**:
    - [ ] Ekstrak hardcoded strings ke file `.arb`.
    - [ ] Tambahkan Bahasa Indonesia & Inggris.
- [ ] **Game Juice (Visual Enhancements)**:
    - [ ] Partikel/Confetti lebih heboh saat menang.
    - [ ] Animasi "Wiggle/Shake" saat salah drop kartu.
    - [ ] Responsiveness check untuk layar Tablet.

## 👥 Phase 5: Local Multiplayer (Pass-and-Play)
Mode kompetisi lokal untuk seru-seruan bareng teman (Tanpa Internet).

- [ ] **Setup Screen**:
    - [ ] Pilihan Jumlah Item (Soal).
    - [ ] Input Jumlah Player (2-4 orang) & Nama Player.
- [ ] **Game Loop (Turn-Based)**:
    - [ ] Player 1 Main -> Timer Catat -> Layar Ganti Player -> Player 2 Main.
    - [ ] **Fairness Logic**: Gunakan set soal yang sama untuk semua pemain, TETAPI acak ulang posisi/urutan kartu setiap giliran agar pemain berikutnya tidak bisa menyontek jawaban pemain sebelumnya.
- [ ] **Leaderboard Akhir**:
    - [ ] Urutkan ranking berdasarkan Waktu Tercepat.
    - [ ] Tampilkan selisih waktu.

## 📅 Phase 6: Daily Challenge (Infinite Content)
Fitur tantangan harian tanpa server menggunakan algoritma "Seeded Procedural Generation".

- [ ] **Daily Generator System**:
    - [ ] Gunakan `DateTime.now()` (YYYYMMDD) sebagai *Seed* untuk Random Number Generator.
    - [ ] Algoritma generate level unik berdasarkan seed tersebut (Tipe soal, jumlah item, tingkat kesulitan).
    - [ ] Pastikan semua user di seluruh dunia mendapatkan level yang SAMA persis pada tanggal yang sama.
- [ ] **Challenge Interface**:
    - [ ] Menu khusus "Daily Challenge" yang hanya bisa dimainkan 1x per hari (atau boleh replay untuk perbaiki skor).
    - [ ] Tampilkan "Global Leaderboard" (bisa dummy/lokal highscore dulu jika tanpa server) atau "Personal Streak".

    - [ ] Menu khusus "Daily Challenge" yang hanya bisa dimainkan 1x per hari (atau boleh replay untuk perbaiki skor).
    - [ ] Tampilkan "Global Leaderboard" (bisa dummy/lokal highscore dulu jika tanpa server) atau "Personal Streak".

## 🍒 Nice-to-Have Features (Micro-Improvements)
Fitur tambahan yang tidak wajib ("polishing"), tapi bisa meningkatkan nilai jual ("premium feel"). Kerjakan jika Roadmap Utama selesai.

- [ ] **Accessibility (Inklusivitas)**:
    - [ ] **Colorblind Support**: Tambahkan pola (pattern/texture) pada kartu agar tidak bergantung pada warna saja.
- [ ] **Immersion (Game Feel)**:
    - [ ] **Haptic Textures**: Getaran detail (tik... tik... clunk!) saat drag & drop, bukan sekadar buzz standar.
    - [ ] **Adaptive Audio**: Tempo musik yang berubah menjadi cepat/tegang saat sisa waktu menipis.
    - [ ] **OLED Black Mode**: Tema hitam pekat #000000 untuk hemat baterai layar OLED.

## 📝 Catatan Ide Awal (Dibatalkan/Ditunda)
- *Associative Memory (Warna/Simbol)*: Dibatalkan karena sulit diterapkan pada jumlah item banyak (>35 item). Diganti dengan konsep *Fading Numbers*.
- *Server-side API*: Dibatalkan demi efisiensi biaya (Local-first approach).

## 🚫 NOT TO DO List (Anti-Patterns)
Daftar hal yang harus dihindari demi menjaga kualitas UX.

- [ ] **Scrolling Drag & Drop (> 40 Items)**:
    - [ ] Jangan membuat level dengan jumlah item melebihi kapasitas satu layar (kurang lebih 40 item).
    - [ ] *Alasan*: Mekanik "Drag item sambil auto-scroll" sangat menyulitkan user (jari pegal, item jatuh) dan memutus "overview" visual. Tantangan harus datang dari kompleksitas konten, bukan kuantitas item.

