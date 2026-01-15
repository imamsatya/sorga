# Sorga - Game Design & Overview

## 🎮 Game Overview
**Sorga** (Sorting Game) is a casual puzzle game where players sort various items into the correct order. The game combines simple mechanics with educational value and cognitive training elements.

### Core Concept
- **Goal**: Arrange all items in the grid according to the specific level instruction (e.g., "Sort Low to High", "Sort A to Z").
- **Mechanics**:
  - **Drag & Drop**: Intuitive touch controls to move items.
  - **Two Control Modes**:
    - **Shift (Default)**: Insert item between others (good for fine validation).
    - **Swap**: Exchange positions between two items (good for quick rough sorting).
- **Winning Condition**: All items are in the correct sorted order.
- **Feedback**: Immediate visual (green/red indicators during daily challenge check) and audio-haptic feedback.

---

## ✨ Current Features (Implemented)

### 1. Categories & Levels
The game features multiple content categories to keep gameplay varied:
- **🔢 Basic**: Integer numbers (e.g., 1, 5, 10, 20).
- **⏱️ Time**: Dates, times, and durations.
- **👥 Names**: Alphabetical sorting of names.
- **📐 Formatted**: Decimals, percentages, currency (e.g., $5.00, 50%).
- **🎲 Mixed**: Combination of different types for higher difficulty.
- **🧠 Knowledge**: Word-based sorting (e.g., "Sort from Smallest to Largest Animal").

### 2. Daily Challenge System
A serverless, infinite content system that generates a unique level for every day of the year.
- **Seeded Generation**: Every player gets the exact same level on the same date.
- **Streaks**: Tracks consecutive days played (Fire emoji 🔥).
- **Social Sharing**: Share results with a generated text summary (Time, Date, Beat my score!).
- **Replayability**: Can be replayed to improve time, but streak counts on first completion.

### 3. Progression & Stats
- **Level Selection**: Grid-based level selector for standard levels.
- **Stars/Completion**: Tracks which levels have been passed.
- **Timer**: Speedrun-friendly timer display.
- **Local Storage**: All progress saved locally on device.

### 4. Technical Polish
- **Haptic Feedback**: Rich vibrations for drag, drop, success, and error.
- **Audio**: Sound effects for interactions (Pop, Ding, Buzz).
- **Confetti**: Visual celebration effect upon level completion.
- **Dynamic Layout**: Responsive grid system that adapts to item count (up to 5 items per row).

---

## 🛣️ Future Roadmap (Confirmed)

These features are planned and confirmed for future updates to enhance depth and monetization.

### 🚀 Phase 1: Gameplay Expansion
- **Memory Mode**:
  - **Fading Numbers**: Items appear briefly then fade out / flip over.
  - Test short-term memory by sorting hidden items.
  - "Peek" mechanic with time penalty.

### 🔓 Phase 2: Progression System
- **Unlockable Content**:
  - Advanced categories (like Memory) locked behind progress (e.g., "Finish Level 20 Basic").
  - Visual Lock icons 🔒 in category menu.

### 💰 Phase 3: Monetization (Sultan/Pro)
- **Life/Undo System**:
  - Limited Undos for free users.
  - Unlimited for Pro users.
- **Ads Integration**:
  - Non-intrusive Banner Ads.
  - Interstitial Ads between levels.
- **In-App Purchase**:
  - "Remove Ads" & "Pro Bundle" one-time purchase.

### 👥 Phase 4: Local Multiplayer
- **Pass-and-Play**:
  - 2-4 Players on one device.
  - Turn-based competition.
  - **Fairness**: Same items, but reshuffled positions for each player to prevent copying.

---

## 🛠️ Tech Stack
- **Framework**: Flutter (Dart)
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Local Data**: Hive / SharedPreferences
- **Design System**: Custom `AppTheme` with consistent color coding per category.
