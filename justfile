
build-all: rust-native rust-android

# -------------
# Settings

export ANDROID_NDK_HOME := "/opt/android-ndk"

# -------------
# Internal Helpers

message := "echo -e \"\n==> \""
rustdir := "cd rust;"

# -------------
# Rust build commands
rust-native:
	{{rustdir}} cargo build
	{{rustdir}} cargo build --release

rust-android:
	{{rustdir}} cargo ndk -t arm64-v8a build
	{{rustdir}} cargo ndk -t arm64-v8a build --release

[macos]
rust-ios:
    # NOTE: can only work on MacOS with xcode
    # untested
    {{rustdir}} cargo +aarch64-apple-ios build --release

# -------------

android_keystore := "secrets/debug.keystore"



setup: setup-verify-dependencies setup-debug-keystore setup-rust setup-android setup-ios

setup-verify-dependencies:
	@ {{message}} "Verifying all required programs are installed...\nAll programs need to be in \$PATH!"
	rustup --version
	godot --version
	gdformat --version

setup-debug-keystore:
	@ {{message}} "Generating debug keypair for Android..."
	test -f {{android_keystore}} \
	|| keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android -keystore {{android_keystore}} -storepass android -dname "CN=Android Debug,O=Android,C=US" -validity 9999 -deststoretype pkcs12

setup-rust:
	rustup toolchain install stable
	rustup default stable

setup-android:
	@ {{message}} "Installing Rust tools for Android builds..."
	rustup target add aarch64-linux-android
	cargo install cargo-ndk

setup-ios:
	@ {{message}} "Installing Rust tools for iOS builds..."
	rustup target add aarch64-apple-ios
	cargo install cargo-lipo
