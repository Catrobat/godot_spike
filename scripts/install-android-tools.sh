#!/bin/bash

set -o errexit # Abort on nonzero exitstatus
set -o nounset # Abort on unbound variable
set -o pipefail # Don't hide errors within pipes
set -x # Show all executed commands

echo "This script will install the Android SDK into a subdirectory of this repo."
echo

# Determine the operating system
OS=$(uname)
if [[ $OS == "Darwin" ]]; then # MacOS
    ANDROID_CMDLINE_URL="https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip"
elif [[ $OS == CYGWIN* || $OS == MINGW* || $OS == MSYS* ]]; then # Windows
    ANDROID_CMDLINE_URL="https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
else # Linux
    ANDROID_CMDLINE_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"
fi

# To use the latest versions, update the following strings:
ANDROID_API_VERSION="34.0.0"
ANDROID_NDK_VERSION="26.3.11579264"
# Note: Do not forget to update also in justfile

SDKMANAGER_PACKAGES="ndk;$ANDROID_NDK_VERSION build-tools;$ANDROID_API_VERSION platform-tools"

# The rest of the script should not have to be touched!

ANDROID_SDK_ROOT="dependencies/android-sdk"
ANDROID_HOME="$ANDROID_SDK_ROOT" # Deprecated: Still used by gradle, once gradle respects ANDROID_SDK_ROOT, this can be removed

if [[ $OS == CYGWIN* || $OS == MINGW* || $OS == MSYS* ]]; then
    SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/bin/sdkmanager.bat"
else
    SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/bin/sdkmanager"
fi

# Ensure SDK folder is empty
rm -rf "$ANDROID_SDK_ROOT"
mkdir -p $ANDROID_SDK_ROOT

# Install CLI tools
curl $ANDROID_CMDLINE_URL --output /tmp/android_cmd.zip
unzip -d $ANDROID_SDK_ROOT /tmp/android_cmd.zip

# Install rest of the requirements using sdkmanager
yes "y" | $SDKMANAGER --install $SDKMANAGER_PACKAGES --sdk_root="$ANDROID_SDK_ROOT" || true

exit 0
