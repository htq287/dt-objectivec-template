#!/bin/sh -e

xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

echo "MACH_O_TYPE = staticlib" >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"

# --no-use-binaries otherwise we can't compile 'em as static frameworks
carthage build --no-use-binaries "$@"