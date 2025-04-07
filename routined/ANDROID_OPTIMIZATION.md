# Android Optimization

This document outlines the changes made to optimize the app for Android-only support by removing all web-related code and dependencies.

## Changes Made

1. **Updated Files:**
   - `lib/data/repository/database_connection.dart` - Simplified for Android-only support
   - `lib/main.dart` - Removed web-specific initialization
   - `pubspec.yaml` - Removed web dependencies and assets
   - `build.yaml` - Updated for Android-only configuration

2. **Files to Delete:**
   These files are no longer needed and should be deleted:
   - `lib/data/repository/database_connection_web.dart`
   - `lib/data/repository/database_connection_native.dart`
   - `lib/data/repository/native_web_stub.dart`
   - `lib/data/repository/wasm_native_stub.dart`
   - `lib/data/repository/platform_web_stub.dart`
   - `lib/data/repository/sqlite3_flutter_libs_web_stub.dart`
   - `lib/data/repository/sqlite3_web_stub.dart`
   - `copy_wasm.bat`
   - `copy_wasm.sh`
   - The entire `web/` directory

## Next Steps

1. Delete the files listed above
2. Run `flutter pub get` to update dependencies
3. Run `flutter build apk` to build for Android

## Benefits

- Smaller app size
- Simplified codebase
- Faster build times
- Focused development for Android platform