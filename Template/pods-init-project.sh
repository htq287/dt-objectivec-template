#!/bin/sh -e

# remove the old pods-configs
rm -rf ./TPLProjectName.*
rm -rf ./Podfile.lock
rm -rf ./Pods

# generate .xcodeproj
xcodegen

# generate .xcworkspace
pod install