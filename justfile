
build-all: rust-native rust-android

# -------------
# Settings

export ANDROID_NDK_HOME := "/opt/android-ndk"

# -------------
# Internal Helpers

message := "echo -e \"\n==> \""
rustdir := "cd rust;"
godotdir := "cd godot;"


# -------------
# Godot build commands
godot-debug-linux:
	{{godotdir}} godot --headless --export-debug "Linux/X11" "../export/linux/Godot Spike.x86_64"
	
godot-debug-android:
	{{godotdir}} godot --headless --export-debug "Android" "../export/android/Godot Spike.apk"

godot-debug-windows:
	{{godotdir}} godot --headless --export-debug "Windows Desktop" "../export/windows/Godot Spike.exe"


godot-release-linux:
	{{godotdir}} godot --headless --export-release "Linux/X11" "../export/linux/Godot Spike.x86_64"
	
godot-release-android:
	{{godotdir}} godot --headless --export-release "Android" "../export/android/Godot Spike.apk"

godot-release-windows:
	{{godotdir}} godot --headless --export-release "Windows Desktop" "../export/windows/Godot Spike.exe"


# -------------
# Rust build commands
rust-native:
	{{rustdir}} cargo build
	{{rustdir}} cargo build --release

rust-android:
	{{rustdir}} cargo build --target aarch64-linux-android
	{{rustdir}} cargo build --target aarch64-linux-android --release

rust-windows:
	{{rustdir}} cargo build --target x86_64-pc-windows-gnu
	{{rustdir}} cargo build --target x86_64-pc-windows-gnu --release

[macos]
rust-ios:
    # NOTE: can only work on MacOS with xcode
    # untested
    {{rustdir}} cargo +aarch64-apple-ios build --release

# -------------

android_keystore := "secrets/debug.keystore"



setup: setup-verify-dependencies setup-debug-keystore setup-rust setup-windows setup-android setup-ios

setup-verify-dependencies:
	@ {{message}} "Verifying all required programs are installed...\nAll programs need to be in \$PATH!"
	rustup --version
	godot --version
	gdformat --version
	pre-commit --version

setup-debug-keystore:
	@ {{message}} "Generating debug keypair for Android..."
	test -f {{android_keystore}} \
	|| keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore {{android_keystore}} -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12

setup-precommit:
	@ {{message}} "Setting up pre-commit hooks"
	pre-commit init	

setup-rust:
	rustup toolchain install stable
	rustup default stable

setup-android:
	@ {{message}} "Installing Rust tools for Android builds..."
	rustup target add aarch64-linux-android
	cargo install cargo-ndk
	@ {{message}} "Installing Android NDK & SDK in the dependencies folder..."
	scripts/install-android-tools.sh


setup-windows:
	@ {{message}} "Installing Rust tools for Windows builds..."
	rustup target add x86_64-pc-windows-gnu

setup-ios:
	@ {{message}} "Installing Rust tools for iOS builds..."
	rustup target add aarch64-apple-ios
	cargo install cargo-lipo
