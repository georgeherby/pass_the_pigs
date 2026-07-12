# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Unofficial Flutter scoring app for the dice/pig-rolling game "Pass the Pigs" (not affiliated with the original game).

## Commands

This project pins the Flutter SDK via [FVM](https://fvm.app/) (`stable` channel, see `.fvmrc`). Prefix Flutter/Dart commands with `fvm` if FVM is installed; CI uses plain `flutter`/`dart`.

```sh
fvm flutter pub get              # install dependencies
fvm flutter run                  # run the app (pass -d <device_id> if multiple devices)
fvm flutter test                 # run all tests
fvm flutter test test/ui/turn/cubit/turn_cubit_test.dart   # run a single test file
fvm flutter test --plain-name "some test description"      # run a single test by name
dart format --set-exit-if-changed lib test    # check formatting (CI-enforced)
flutter analyze lib test                      # lint/analyze (CI-enforced)
fvm flutter build apk                         # Android APK
fvm flutter build appbundle                   # Android App Bundle
fvm flutter build ios                         # iOS (macOS + Xcode required)
```

CI (`.github/workflows/main.yaml`) runs format check, analyze, and tests on every push/PR. The release workflow additionally signs and builds an Android APK from `main`/`releases/**`.

Localization strings are generated from ARB files (`flutter: generate: true` in `pubspec.yaml`, config in `l10n.yaml`). After editing `lib/l10n/app_en.arb`, run `fvm flutter gen-l10n` (or just `fvm flutter pub get` / `run`, which regenerates automatically) to update `lib/l10n/app_localizations*.dart`. Access strings in widgets via `context.l10n` (see `lib/l10n/l10n.dart`).

## Architecture

The app has two nested Cubits (flutter_bloc) representing two levels of game state:

- **`GameCubit`** (`lib/ui/game/cubit/game_cubit.dart`) owns the `Game` model: the player list, whose turn it is, and whether a game is active. It exposes intents like `startGame`, `addPlayer`/`removePlayer`, `nextPlayer`, `addTurnToPlayer`, `endGame`. It has no knowledge of dice/pig-roll rules.
- **`TurnCalculatorCubit`** (`lib/ui/turn/cubit/turn_cubit.dart`) owns the in-progress turn: the current (possibly incomplete) `Throw` and the list of committed throws for the turn. Its methods (`commitRoll`, `bankTurn`, `resolveOinker`) return a `TurnActionResult` sealed type (`lib/ui/turn/models/turn_action_result.dart`: `TurnContinue`, `TurnBanked`, `TurnPigOut`, `TurnIncomplete`, `TurnNothingToBank`, `TurnOinker`) so the UI can switch on the outcome without re-implementing game rules itself.

`GamePage` → `GameView` (`lib/ui/game/views/game_page.dart`) is the top-level `BlocBuilder<GameCubit, Game>` that switches between `GameInactiveView` (setup/add players), `TurnCalculatorPage` (active turn for the current player), and `GameWinnerView` (score ≥ 100), wiring `TurnCalculatorPage`'s callbacks (`onBankTurn`, `onOinker`, `onPigOut`) back into `GameCubit` methods (`addTurnToPlayer`/`nextPlayer`/`resetAllThrows`/`endGame`). `TurnCalculatorPage` creates its own `TurnCalculatorCubit` scoped to the current turn.

Scoring rules for a single roll of two pigs live in `Throw` (`lib/common/models/throw.dart`): `Position` enum values (`razorback`, `trotter`, `snouter`, `leaningJowler`, `sideNoSpot`, `sideSpot`) map to point values, doubles score higher, and a "Pig Out" (one pig on each side) zeroes the whole turn. An "Oinker" (both pigs on their side/trotter in a specific stacked pose, entered manually via `OinkerDialog`) zeroes the player's entire *game* score, handled via `GameCubit.resetAllThrows` + `nextPlayer`, not through `Throw`/`TurnActionResult`.

Models (`Game`, `Player`, `Throw`) are `Equatable` value objects with `copyWith`; state changes always go through `cubit.emit(state.copyWith(...))` rather than mutation.

`lib/common/` re-exports shared models (currently just `Throw`) via a barrel file (`common.dart`) imported with `package:pass_the_pigs/common/common.dart` elsewhere — follow this barrel-export pattern for cross-feature shared code.

## Conventions

- `analysis_options.yaml` extends `flutter_lints` with a large set of additional enabled lints (e.g. `always_use_package_imports`, `prefer_single_quotes`, `sort_constructors_first`) — run `flutter analyze` before considering a change complete.
- Tests live under `test/`, mirroring the `lib/` structure. `test/helpers/pump_app.dart` provides a `pumpApp` `WidgetTester` extension that wraps widgets in a `MaterialApp` with localization delegates configured — use it instead of raw `pumpWidget` for widget tests.
- Bloc/cubit tests use `bloc_test`; mocking uses `mocktail`.
