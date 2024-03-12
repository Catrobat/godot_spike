alias b := build-rust






build-rust:
	cd rust; cargo build
	cd rust; cargo build --release


# -------------

android_keystore := "secrets/debug.keystore"


# -------------
# Internal Helpers

message := "echo -e \"\n==> \""

# -------------

setup: setup-verify-dependencies setup-debug-keystore setup-rust setup-android setup-ios

setup-verify-dependencies:
	@ {{message}} "Verifying rustup is installed..."
	rustup --version
	godot --version

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
