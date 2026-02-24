# Sorga App - Development Roadmap & To-Do List

Dokumen ini merangkum rencana pengembangan aplikasi "Sorga" (SORTIQ) berdasarkan diskusi kita sejauh ini, mencakup fitur baru, strategi monetisasi, dan peningkatan teknis.

## 🚀 Phase 1: Gameplay Expansion (Memory Mode)
Fitur utama berikutnya: Mode Hafalan untuk 5 kategori angka.

- [x] **Implementasi Kategori Baru**: Menambahkan 5 varian kategori "Memory" di `LevelCategory` (Basic Memory, Time Memory, etc).
- [x] **Mekanik "Fading Numbers"**:
    - [x] Ubah `GameItem` agar bisa memiliki state `isVisible`.
    - [x] Buat Timer Countdown di awal level (durasi dinamis berdasarkan jumlah item).
    - [x] Implementasi efek *fade out* / tutup angka setelah timer habis.
    - [x] Opsi tombol "Peek" (Intip) dengan penalti (opsional).
- [x] **Level Data**: Generate level data khusus untuk mode Memory (bisa re-use pola level normal tapi dengan flag `isMemory`).

## 🔓 Phase 2: Progression System (Sistem Kunci)
Agar game terasa menantang dan berjenjang.

- [x] **Logic Lock/Unlock**:
    - [x] Update `isLevelUnlocked` provider.
    - [x] Rule: Kategori Memory terkunci sampai user menyelesaikan Level 30 di Kategori Normal.
- [ ] **Pro Feature Refinement**:
    - [ ] **Unlock Memory Mode Immediately**: Bagi user Pro, hilangkan syarat level 30 untuk membuka Memory Mode.
    - [ ] **Do NOT Unlock All Levels**: Biarkan level normal tetap terkunci bertahap untuk menjaga *sense of progression*.

## 💰 Phase 3: Monetization (Sultan/Pro Version) [IMPROVED]
Strategi mendapatkan revenue tanpa server.

- [x] **In-App Purchase (IAP)**:
    - [x] Setup Product `sortiq_pro` ($2.99).
    - [x] Implementasi Pro Provider.
- [ ] **User Value Proposition**:
    - [x] **Ad-Free Experience**: 100% bersih dari iklan.
    - [x] **Unlimited Attempts**: Nyawa tak terbatas (Anti Game Over).
    - [ ] **Support Developer**: Pesan terima kasih khusus.
    - [ ] **Future Pro Exclusives**:
        - [ ] **Gold Theme**: Tema warna eksklusif.
        - [ ] **Special Icons**: Pilihan icon aplikasi premium.

## 🛠️ Phase 4: Technical Polish (Local-First Improvements)
Peningkatan kualitas tanpa biaya server.

- [ ] **Cloud Save (Backup)**:
    - [ ] Integrasi `games_services` (Android) dan iCloud (iOS) agar data save aman saat ganti HP.
- [x] **Localization (Bahasa)**:
    - [x] Ekstrak hardcoded strings ke file `.arb`.
    - [x] Tambahkan 11 Bahasa (Indo, Inggris, Jepang, Korea, dll).
- [ ] **Game Juice (Visual Enhancements)**:
    - [x] Partikel/Confetti lebih heboh saat menang.
    - [ ] **Animated Glowing Border**: Efek visual untuk level yang sudah selesai.
    - [ ] **Empty Slot Tap**: Mekanik tap slot kosong untuk memindahkan item (nice-to-have).
    - [ ] **Force Update Support**: Persiapan update wajib jika ada bug kritis.

## 👥 Phase 5: Local Multiplayer (Pass-and-Play)
Mode kompetisi lokal untuk seru-seruan bareng teman (Tanpa Internet).

- [x] **Setup Screen**:
    - [x] Pilihan Jumlah Item (Soal).
    - [x] Input Jumlah Player (2-4 orang) & Nama Player.
- [x] **Game Loop (Turn-Based)**:
    - [x] Player 1 Main -> Timer Catat -> Layar Ganti Player -> Player 2 Main.
    - [x] **Fairness Logic**: Gunakan set soal yang sama untuk semua pemain, TETAPI acak ulang posisi/urutan kartu setiap giliran agar pemain berikutnya tidak bisa menyontek jawaban pemain sebelumnya.
- [x] **Leaderboard Akhir**:
    - [x] Urutkan ranking berdasarkan Waktu Tercepat.
    - [x] Tampilkan selisih waktu.

## 📅 Phase 6: Daily Challenge (Infinite Content)
Fitur tantangan harian tanpa server menggunakan algoritma "Seeded Procedural Generation".

- [x] **Daily Generator System**:
    - [x] Gunakan `DateTime.now()` (YYYYMMDD) sebagai *Seed* untuk Random Number Generator.
    - [x] Algoritma generate level unik berdasarkan seed tersebut (Tipe soal, jumlah item, tingkat kesulitan).
    - [x] Pastikan semua user di seluruh dunia mendapatkan level yang SAMA persis pada tanggal yang sama.
- [x] **Challenge Interface**:
    - [x] Menu khusus "Daily Challenge" yang hanya bisa dimainkan 1x per hari (atau boleh replay untuk perbaiki skor).
    - [x] Tampilkan "Global Leaderboard" (bisa dummy/lokal highscore dulu jika tanpa server) atau "Personal Streak".

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
