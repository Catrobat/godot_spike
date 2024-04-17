# -------------
# Settings
export ANDROID_HOME := `echo "$PWD/dependencies/android-sdk"`
export ANDROID_SDK_ROOT := `echo "$PWD/dependencies/android-sdk"`

# -------------
# Internal Helpers
message := "echo -e \"\n==> \""
rustdir := "cd rust;"
godotdir := "cd godot;"
android_keystore := "secrets/debug.keystore"

# -------------
# Export binaries for different platforms
linux-debug:
	{{rustdir}} cargo build
	{{godotdir}} godot --headless --export-debug "Linux/X11" "../export/linux/Godot Spike.x86_64"
	
linux-release:
	{{rustdir}} cargo build --release
	{{godotdir}} godot --headless --export-release "Linux/X11" "../export/linux/Godot Spike.x86_64"

android-debug:
	{{rustdir}} cargo build --target aarch64-linux-android
	{{godotdir}} godot --headless --export-debug "Android" "../export/android/Godot Spike.apk"

android-release:
	{{rustdir}} cargo build --target aarch64-linux-android --release
	{{godotdir}} godot --headless --export-release "Android" "../export/android/Godot Spike.apk"

windows-debug:
	{{rustdir}} cargo build --target x86_64-pc-windows-gnu
	{{godotdir}} godot --headless --export-debug "Windows Desktop" "../export/windows/Godot Spike.exe"

windows-release:
	{{rustdir}} cargo build --target x86_64-pc-windows-gnu --release
	{{godotdir}} godot --headless --export-release "Windows Desktop" "../export/windows/Godot Spike.exe"

# -------------
# TODO: Build for IOS
[macos]
rust-ios:
    # NOTE: can only work on MacOS with xcode
    # untested
    {{rustdir}} cargo +aarch64-apple-ios build --release

# -------------
# Execute prior to development of project
setup: setup-verify-dependencies setup-precommit setup-debug-keystore setup-rust setup-windows setup-android setup-ios

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
