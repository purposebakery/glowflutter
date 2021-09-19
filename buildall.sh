#!/bin/zsh

echo '=== CLEAN ==='
flutter clean

# Android
echo '=== BUILDING ANDROID ==='
flutter build appbundle --release
# RELEASE:
# upload build/app/outputs/bundle/release/app-release.aab to play store

# iOS
echo '=== BUILDING iOS ==='
flutter build ipa --release
# RELEASE:
# > open build/ios/archive/Runner.xcarchive
# -> verify -> distribute

echo '=== BUILD ALL COMPLETE ==='


