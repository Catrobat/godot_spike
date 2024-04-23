# -------------------------------------------------
# Settings
export ANDROID_HOME := `echo "$PWD/dependencies/android-sdk"`
export ANDROID_SDK_ROOT := `echo "$PWD/dependencies/android-sdk"`

# -------------------------------------------------
# Internal Helpers
message := "echo -e \"\n==> \""
rustdir := "cd rust;"
godotdir := "cd godot;"
android_keystore := "secrets/debug.keystore"

# -------------------------------------------------
# Build and export binaries for different platforms
[linux]
linux-debug:
	{{rustdir}} cargo build
	{{godotdir}} godot --headless --export-debug "Linux/X11" "../export/linux/Godot Spike.x86_64"

[linux]
linux-release:
	{{rustdir}} cargo build --release
	{{godotdir}} godot --headless --export-release "Linux/X11" "../export/linux/Godot Spike.x86_64"

[linux]
android-debug:
	{{rustdir}} cargo build --target aarch64-linux-android
	{{godotdir}} godot --headless --export-debug "Android" "../export/android/Godot Spike.apk"

[linux]
android-release:
	{{rustdir}} cargo build --target aarch64-linux-android --release
	{{godotdir}} godot --headless --export-release "Android" "../export/android/Godot Spike.apk"

[windows]
windows-debug:
	{{rustdir}} cargo build --target x86_64-pc-windows-msvc
	{{godotdir}} godot --headless --export-debug "Windows Desktop" "../export/windows/Godot Spike.exe"

[windows]
windows-release:
	{{rustdir}} cargo build --target x86_64-pc-windows-gnu --release
	{{godotdir}} godot --headless --export-release "Windows Desktop" "../export/windows/Godot Spike.exe"

[macos]
macos-debug:
	{{rustdir}} cargo build 
	{{godotdir}} godot --headless --export-debug "macOS" "../export/macos/Godot Spike.dmg"

[macos]	
macos-release:
	{{rustdir}} cargo build --release
	{{godotdir}} godot --headless --export-release "macOS" "../export/macos/Godot Spike.dmg"

[macos]
ios-debug:
    # NOTE: can only work on MacOS with xcode
    {{rustdir}} cargo build --target aarch64-apple-ios
    {{godotdir}} godot --headless --export-debug "iOS" "../export/ios/Godot Spike.ipa"

[macos]
ios-release:
    # NOTE: can only work on MacOS with xcode
    {{rustdir}} cargo build --target aarch64-apple-ios --release
    {{godotdir}} godot --headless --export-release "iOS" "../export/ios/Godot Spike.ipa"

# -------------------------------------------------
# Execute prior to development of project
setup:
	just setup-verify-dependencies _setup-precommit _setup-rust _setup-{{os()}}

# -------------------------------------------------
# Execute to verify if all dependencies are installed
setup-verify-dependencies:
	@ {{message}} "Verifying all required programs are installed...\nAll programs need to be in \$PATH!"
	rustup --version
	godot --version
	gdformat --version
	pre-commit --version

_setup-precommit:
	@ {{message}} "Setting up pre-commit hooks..."
	pre-commit install

_setup-rust:
	rustup toolchain install stable
	rustup default stable

_setup-debug-keystore:
	@ {{message}} "Generating debug keypair for Android..."
	test -f {{android_keystore}} \
	|| keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore {{android_keystore}} -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12

_setup-android:
	@ {{message}} "Installing Rust tools for Android builds..."
	rustup target add aarch64-linux-android
	cargo install cargo-ndk
	@ {{message}} "Installing Android NDK & SDK in the dependencies folder..."
	scripts/install-android-tools.sh

_setup-windows:
	@ {{message}} "Installing Rust tools for Windows builds..."
	rustup target add x86_64-pc-windows-gnu

_setup-macos:
	@ {{message}} "Installing Rust tools for iOS builds..."
	rustup target add aarch64-apple-ios
	cargo install cargo-lipo

_setup-linux:
    @ {{message}} "Setup Linux build tools..."
    just _setup-android _setup-debug-keystore 
