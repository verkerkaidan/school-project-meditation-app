# School Project: Meditation App

An iOS meditation app built with SwiftUI as a school project at Hogeschool Leiden. You pick a session length, meditate, and earn coins that you spend in a store on cosmetics for your pet companion.

## Features

- **Meditation sessions**: choose a duration and meditate. Leaving the app ends the session, so it only counts when you stay focused.
- **Coin rewards**: finishing a session earns `5 + 2 × minutes` coins.
- **Store**: buy and equip hats for your pet, backgrounds, and soundtracks that play during meditation.
- **Animated pet**: a companion that blinks and wears whichever hat you have equipped.
- **Achievements**: ten milestones, from "A Calm Start" (1 session) to "Enlightened One" (1000 sessions).
- **Profile**: your totals (sessions completed, minutes meditated, coins) and a bar chart of your history, built with Swift Charts.
- **Local persistence**: user data and session history are encoded as JSON and stored in `UserDefaults`, so everything survives app restarts without a backend.

## My contribution

I built the entire app on my own: design, SwiftUI views, data models, persistence, the store and cosmetics system, achievements, audio playback, and the pet animation.

## A note on the artwork

The artwork in this app (the pet, hats and backgrounds) was generated with AI. I wasn't aware of the ethical problems with AI art back then, and I regret using it. I dislike AI art because it is built on the work of artists who never agreed to it and were never paid for it. If I rebuilt this app today, I would commission an artist or use properly licensed work instead.

## Tech stack

- Swift 5 and SwiftUI
- Swift Charts for the profile statistics
- AVFoundation for soundtrack playback
- `UserDefaults` with `Codable` for persistence

## Project structure

```
MeditatieApp/
├── MeditatieAppApp.swift        App entry point
├── ContentView.swift            Root view and navigation
├── MeditationSetupView.swift    Pick a session duration
├── MeditationSessionView.swift  Active session, rewards, interruption handling
├── MeditationSession*.swift     Session model, manager, and history list
├── StoreView.swift              Store, with Hat/Background/Soundtrack item views
├── *Cosmetic.swift              Cosmetic item definitions
├── CosmeticManager.swift        Unlock and equip logic
├── PetView.swift                Animated pet
├── AchievementsView.swift       Milestone tracking
├── ProfileView.swift            Stats and bar chart
├── User.swift / UserManager.swift  User model and persistence
└── MusicPlayer.swift            Soundtrack playback
```

## How to run

**Requirements:** a Mac with Xcode (the project targets iOS 18.0 or newer).

1. Clone the repository:
   ```bash
   git clone https://github.com/verkerkaidan/school-project-meditation-app.git
   cd school-project-meditation-app
   ```
2. Open the project:
   ```bash
   open MeditatieApp.xcodeproj
   ```
3. Pick an iPhone simulator (or a connected device) in the Xcode toolbar and press **Run** (⌘R).

No dependencies, API keys, or backend are needed.
