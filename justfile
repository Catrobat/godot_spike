# -------------------------------------------------
# Internal Helpers
message := "echo -e \"\n==> \""
rustdir := "cd rust;"
godotdir := "cd godot;"
android_keystore := "secrets/debug.keystore"

# -------------------------------------------------
# Build and export binaries for different platforms
# Sometimes there are 'same' commands, but for different OS 
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
	{{rustdir}} cargo build --target aarch64-linux-android --config target.aarch64-linux-android.linker=\"../dependencies/android-sdk/ndk/26.3.11579264/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android34-clang\"
	{{godotdir}} godot --headless --export-debug "Android" "../export/android/Godot Spike.apk"

[linux]
android-release:
    {{rustdir}} cargo build --release --target aarch64-linux-android --config target.aarch64-linux-android.linker=\"../dependencies/android-sdk/ndk/26.3.11579264/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android34-clang\"
    ls rust/target
    {{godotdir}} godot --headless --export-release "Android" "../export/android/Godot Spike.apk"

[windows]
android-debug:
    {{rustdir}} cargo build --target aarch64-linux-android --config target.aarch64-linux-android.linker=\"../dependencies/android-sdk/ndk/26.3.11579264/toolchains/llvm/prebuilt/windows-x86_64/bin/aarch64-linux-android34-clang.cmd\"
    {{godotdir}} godot --headless --export-debug "Android" "../export/android/Godot Spike.apk"

[windows]
android-release:
    {{rustdir}} cargo build --release --target aarch64-linux-android --config target.aarch64-linux-android.linker=\"../dependencies/android-sdk/ndk/26.3.11579264/toolchains/llvm/prebuilt/windows-x86_64/bin/aarch64-linux-android34-clang.cmd\"
    {{godotdir}} godot --headless --export-release "Android" "../export/android/Godot Spike.apk"

[windows]
windows-debug:
	{{rustdir}} cargo build --target x86_64-pc-windows-msvc
	{{godotdir}} godot --headless --export-debug "Windows Desktop" "../export/windows/Godot Spike.exe"

[windows]
windows-release:
	{{rustdir}} cargo build --release --target x86_64-pc-windows-msvc
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
    {{rustdir}} cargo build --release --target aarch64-apple-ios
    {{godotdir}} godot --headless --export-release "iOS" "../export/ios/Godot Spike.ipa"

# -------------------------------------------------
# Execute prior to development of project - installing rust dependencies
setup:
	just _setup-verify-dependencies _setup-precommit _setup-rust setup-{{os()}}

# -------------------------------------------------
# Execute to verify if all dependencies are installed
_setup-verify-dependencies:
	@ {{message}} "Verifying all required programs are installed...\nAll programs need to be in \$PATH!"
	rustup --version
	godot --version
	gdformat --version
	pre-commit --version

[windows]
[linux]
setup-android:
	@ {{message}} "Installing Rust tools for Android builds..."
	rustup target add aarch64-linux-android
	cargo install cargo-ndk
	@ {{message}} "Installing Android NDK & SDK in the dependencies folder..."
	scripts/install-android-tools.sh
	just _setup-debug-keystore

[windows]
setup-windows:
	@ {{message}} "Installing Rust tools for Windows builds and setup for android export..."
	rustup target add x86_64-pc-windows-gnu

[macos]
setup-macos:
	@ {{message}} "Installing Rust tools for iOS builds..."
	rustup target add aarch64-apple-ios
	cargo install cargo-lipo

[linux]
setup-linux:
    @ {{message}} "Setup Linux build tools..."

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
