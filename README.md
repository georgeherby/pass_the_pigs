# 🐷 Pass The Pigs

[![Codemagic build status](https://api.codemagic.io/apps/62d46b2bb2128b2809d61031/62d46b2bb2128b2809d61030/status_badge.svg)](https://codemagic.io/app/62d46b2bb2128b2809d61031/62d46b2bb2128b2809d61030/latest_build)

[![X (formerly Twitter)](https://img.shields.io/badge/Twitter-black?style=for-the-badge&logo=x)](https://x.com/georgeherby_dev) [![LinkedIn](https://img.shields.io/badge/LinkedIn-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/georgeherbert/)

Unofficial scoring app for the game Pass the Pigs. Built with ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter)

> Disclaimer: This is an unofficial app and is not affiliated with the original game.

[Download the latest Android version](https://codemagic.io/app/62d46b2bb2128b2809d61031/62d46b2bb2128b2809d61030/latest_build)

## Demo

![Demo](/docs//demo.gif)

## Development

This project uses [FVM](https://fvm.app/) to pin the Flutter SDK (`stable`). Install FVM, then from the project root:

```sh
fvm install
fvm flutter pub get
```

### Run

```sh
fvm flutter run
```

Pass a device id if needed: `fvm flutter devices` then `fvm flutter run -d <device_id>`.

### Test

```sh
fvm flutter test
```

### Build

```sh
# Android APK
fvm flutter build apk

# Android App Bundle
fvm flutter build appbundle

# iOS (macOS with Xcode)
fvm flutter build ios
```
