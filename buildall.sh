#!/bin/zsh

START_TIME=$SECONDS

# iOS
echo '=== BUILDING iOS ==='
flutter build ipa --release
# RELEASE:
# > open build/ios/archive/Runner.xcarchive
# -> verify -> distribute

ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo "Build duration $ELAPSED_TIME seconds"

