#!/bin/bash

# TO USE THE LATEST VERSIONS: 
# Update the following strings:

ANDROID_CMDLINE_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"
SDKMANAGER_PACKAGES="ndk;26.2.11394342 build-tools;33.0.0 build-tools;33.0.0 platform-tools"

# END OF VARIABLES
# The rest of the script should not have to be touched.

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes
set -x # show all executed commands

echo "This script will install the Android SDK into a subdirectory of this repo."
echo

ANDROID_SDK_ROOT="dependencies/android-sdk"
ANDROID_HOME="$ANDROID_SDK_ROOT" # Deprecated: Still used by gradle, once gradle respects ANDROID_SDK_ROOT, this can be removed
_SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/bin/sdkmanager"

# ensure SDK folder is empty
rm -rf "$ANDROID_SDK_ROOT"
mkdir -p $ANDROID_SDK_ROOT

# install CLI tools
curl $ANDROID_CMDLINE_URL --output /tmp/android_cmd.zip
unzip -d $ANDROID_SDK_ROOT /tmp/android_cmd.zip

# install rest of the requirements using sdkmanager
yes "y" | $_SDKMANAGER --install $SDKMANAGER_PACKAGES --sdk_root="$ANDROID_SDK_ROOT" || true

exit 0
