# SORTIQ – Brain Sorting Game

## 📖 Complete Documentation

---

## Overview

**SORTIQ** is a brain training mobile game focused on sorting puzzles. Players must arrange items in ascending or descending order as fast as possible. The game features 1100+ levels across multiple categories, daily challenges, multiplayer mode, and a comprehensive achievement system.

---

## Table of Contents

1. [App Information](#app-information)
2. [Features](#features)
3. [Game Modes](#game-modes)
4. [Level Categories](#level-categories)
5. [Architecture](#architecture)
6. [Project Structure](#project-structure)
7. [Technical Stack](#technical-stack)
8. [Localization](#localization)
9. [Monetization](#monetization)
10. [Build & Deployment](#build--deployment)
11. [Contact & Links](#contact--links)

---

## App Information

| Property | Value |
|----------|-------|
| **App Name** | SORTIQ – Brain Sorting Game |
| **Package Name** | `com.sorga.sorga` |
| **Current Version** | 1.0.1+2 |
| **Min Android SDK** | 24 (Android 7.0) |
| **Target SDK** | 36 |
| **Flutter SDK** | ^3.10.4 |
| **Developer** | SORTIQ Team |
| **Contact Email** | sortiq.app@gmail.com |

---

## Features

### Core Features
- ✅ **1100+ Levels**: 600 Normal + 500 Memory Mode
- ✅ **6 Categories**: Basic, Formatted, Time, Names, Mixed, Knowledge
- ✅ **Daily Challenges**: Fresh puzzle every day
- ✅ **Pass & Play Multiplayer**: Up to 4 players on same device
- ✅ **Achievements System**: 37+ achievements to unlock
- ✅ **Statistics Tracking**: Detailed progress analytics
- ✅ **11 Languages**: Global reach

### Game Mechanics
- Tap items in correct order (ASC/DESC)
- Timer-based scoring
- Limited attempts (2 for Normal, 3 for Memory)
- Pro version: Unlimited attempts

### UI/UX
- Dark theme with neon accents
- Confetti celebrations on level complete
- Haptic feedback
- Sound effects (pop, success, etc.)

---

## Game Modes

### 1. Normal Mode (600 Levels)
Standard sorting gameplay. See items and sort them.

| Phase | Description |
|-------|-------------|
| View | See all items |
| Sort | Tap in correct order |
| Result | Time + accuracy shown |

### 2. Memory Mode (500 Levels)
Memorize items first, then sort from memory.

| Phase | Description |
|-------|-------------|
| Memorize | View items for limited time |
| Playing | Items scrambled, labels hidden |
| Sort | Remember and tap in order |

**Unlock Requirement**: Complete 30 Normal Mode levels

### 3. Daily Challenge
New puzzle every day generated from date seed.

- 15-30 items per challenge
- Leaderboard potential (future)
- Streak tracking

### 4. Pass & Play Multiplayer
Local multiplayer for 2-4 players.

- Same puzzle, fair competition
- Turn-based gameplay
- Winner determined by fastest time

---

## Level Categories

| # | Category | Levels | Description |
|---|----------|--------|-------------|
| 1 | **Basic Numbers** | 1-100 | Simple integers (1, 42, 789) |
| 2 | **Formatted Numbers** | 101-200 | Fractions, powers, percentages (½, 2³, 50%) |
| 3 | **Time Formats** | 201-300 | Durations (30 sec, 1.5 min, 2 hr) |
| 4 | **Name Sorting** | 301-400 | Alphabetical names (Alice, Bob, Charlie) |
| 5 | **Mixed Formats** | 401-500 | Combination of all formats |
| 6 | **Knowledge** | 501-600 | Educational facts (planets, mountains, etc.) |

### Level Progression

Levels scale in difficulty:

| Level Range | Items |
|-------------|-------|
| 1-20 | 3-8 items |
| 21-60 | 9-20 items |
| 61-100 | 21-30 items |

### Sort Order Pattern

- Each category has unpredictable ASC/DESC pattern
- Maximum 3 consecutive same type
- Seeded random for reproducibility

---

## Architecture

### Clean Architecture Layers

```
lib/
├── core/           # Constants, services, theme
├── data/           # Repositories, data sources
├── domain/         # Entities, business logic
├── levels/         # Level generators
├── l10n/           # Localization
└── presentation/   # UI (screens, widgets, providers)
```

### State Management

**Riverpod** is used throughout the app:

| Provider | Purpose |
|----------|---------|
| `gameStateProvider` | Current game state |
| `userProgressProvider` | User progress & stats |
| `proStatusProvider` | Pro subscription status |
| `dailyChallengeProvider` | Daily challenge state |
| `multiplayerSessionProvider` | Multiplayer state |
| `achievementProvider` | Achievement tracking |

### Data Persistence

**Hive** (local NoSQL database):

| Box | Data |
|-----|------|
| `user_progress` | Level completion, times, stars |
| `settings` | Sound, haptics, pro status |

---

## Project Structure

```
sortiq/
├── android/                 # Android native code
├── ios/                     # iOS native code
├── assets/
│   ├── audio/              # Sound effects
│   ├── icons/              # App icons
│   └── playstore/          # Store screenshots
├── fonts/                   # Poppins font family
├── lib/
│   ├── core/
│   │   ├── constants/      # AppConstants
│   │   ├── services/       # AdService, AudioService, etc.
│   │   └── theme/          # AppTheme colors
│   ├── data/
│   │   └── repositories/   # ProgressRepository
│   ├── domain/
│   │   └── entities/       # Level, LevelItem, Achievement, etc.
│   ├── l10n/               # 11 language files (.arb)
│   ├── levels/
│   │   ├── level_generator.dart
│   │   └── daily_challenge_generator.dart
│   └── presentation/
│       ├── providers/      # Riverpod providers
│       ├── screens/        # 14 screens
│       └── widgets/        # Reusable widgets
├── sortiq-privacy/          # Vercel privacy policy
├── docs/                    # GitHub Pages docs
└── pubspec.yaml
```

### Key Files

| File | Description |
|------|-------------|
| `main.dart` | App entry point, initialization |
| `level_generator.dart` | Generates all 600 levels |
| `daily_challenge_generator.dart` | Daily puzzle generator |
| `game_screen.dart` | Main gameplay screen (50KB) |
| `result_screen.dart` | Level completion screen (51KB) |
| `app_constants.dart` | Global constants |

---

## Technical Stack

### Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_riverpod` | ^2.5.1 | State management |
| `hive` / `hive_flutter` | ^2.2.3 | Local database |
| `go_router` | ^14.2.7 | Navigation |
| `google_mobile_ads` | ^7.0.0 | AdMob ads |
| `in_app_purchase` | ^3.2.0 | Pro subscription |
| `audioplayers` | ^6.5.1 | Sound effects |
| `confetti` | ^0.8.0 | Celebration effects |
| `share_plus` | ^12.0.1 | Social sharing |
| `intl` | ^0.20.2 | Internationalization |

### Dev Dependencies

| Package | Purpose |
|---------|---------|
| `hive_generator` | Hive adapters generation |
| `build_runner` | Code generation |
| `flutter_launcher_icons` | App icon generation |

---

## Localization

### Supported Languages (11)

| Code | Language |
|------|----------|
| `en` | English |
| `id` | Indonesian |
| `es` | Spanish |
| `fr` | French |
| `de` | German |
| `pt` | Portuguese |
| `ja` | Japanese |
| `ko` | Korean |
| `zh` | Chinese (Simplified) |
| `ar` | Arabic |
| `hi` | Hindi |

### Localization Files

Located in `lib/l10n/`:
- `app_en.arb` - English (base)
- `app_*.arb` - Other languages
- Generated files: `app_localizations_*.dart`

### Adding New Language

1. Create `lib/l10n/app_XX.arb`
2. Run `flutter gen-l10n`
3. Add locale to `supportedLocales` in `main.dart`

---

## Monetization

### Revenue Streams

| Feature | Type | Details |
|---------|------|---------|
| **Banner Ads** | Free users | Bottom banner on game screens |
| **Interstitial Ads** | Free users | After every 3 levels |
| **Pro Subscription** | One-time IAP | $2.99 (sortiq_pro) |

### Pro Benefits

- ✅ Remove all ads
- ✅ Unlimited attempts (no game over)
- ✅ Support development

### Ad Configuration

```dart
// AppConstants
static const bool adsEnabled = true;
```

Ad Units configured in:
- `AdService` (`lib/core/services/ad_service.dart`)
- Android: `AndroidManifest.xml`
- iOS: `Info.plist`

---

## Build & Deployment

### Development

```bash
# Run on device/emulator
flutter run

# Run with release mode
flutter run --release

# Generate localizations
flutter gen-l10n

# Generate Hive adapters
dart run build_runner build
```

### Production Build

```bash
# Android AAB (for Play Store)
flutter build appbundle --release

# Android APK
flutter build apk --release

# iOS
flutter build ios --release
```

### Version Management

Edit `pubspec.yaml`:
```yaml
version: 1.0.1+2  # versionName+versionCode
```

### Play Store Deployment

1. Build AAB: `flutter build appbundle --release`
2. Upload to Play Console → Testing → Closed Testing
3. Fill release notes
4. Send for review

### Files Location

| File | Path |
|------|------|
| AAB | `build/app/outputs/bundle/release/app-release.aab` |
| APK | `build/app/outputs/apk/release/app-release.apk` |

---

## Contact & Links

| Resource | URL |
|----------|-----|
| **Privacy Policy** | https://sortiq-privacy.vercel.app/ |
| **Contact Email** | sortiq.app@gmail.com |
| **GitHub Repo** | https://github.com/imamsatya/sorga |
| **Play Store** | (Pending approval) |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0+1 | 2024-02-08 | Initial release |
| 1.0.1+2 | 2024-02-09 | Fixed pre-sorted levels bug, Daily Challenge item count |

---

## Future Roadmap

### v1.1.0 (Planned)
- [ ] Animated glowing border for completed levels
- [ ] Force update feature
- [ ] Empty slot tap feature
- [ ] Cloud save/sync

### v1.2.0 (Ideas)
- [ ] Online leaderboards
- [ ] New level categories
- [ ] Themes customization
- [ ] Accessibility improvements

---

*Last updated: February 9, 2026*
