---
description: Repository Information Overview
alwaysApply: true
---

# Routined Information

## Summary
Routined is a Flutter application that serves as a productivity tool with multiple features including habit tracking, task management, reminders, and a notepad. The application uses SQLite for local data storage and follows a feature-based architecture.

## Structure
- **lib/**: Contains the Dart source code for the application
  - **common/**: Reusable UI components like custom buttons and appbars
  - **constants/**: Application-wide constants including database constants
  - **core/**: Core functionality, providers, services, and utilities
  - **data/**: Data layer with models and repository implementations
  - **features/**: Feature modules including habit tracker, tasks, reminders, and notepad
- **android/**: Android platform-specific code
- **ios/**: iOS platform-specific code
- **web/**: Web platform-specific code
- **windows/**: Windows platform-specific code
- **linux/**: Linux platform-specific code
- **macos/**: macOS platform-specific code
- **test/**: Contains test files for the application

## Language & Runtime
**Language**: Dart
**Version**: SDK ^3.7.0
**Framework**: Flutter
**Package Manager**: pub (Flutter/Dart package manager)

## Dependencies
**Main Dependencies**:
- flutter_riverpod: ^2.6.1 (State management)
- drift: ^2.26.0 (SQLite ORM)
- sqlite3_flutter_libs: ^0.5.32 (SQLite implementation)
- flutter_slidable: ^4.0.0 (Slidable UI components)
- intl: ^0.20.2 (Internationalization)
- path_provider: ^2.0.11 (File system access)
- permission_handler: ^11.4.0 (Permission management)
- fpdart: ^1.1.1 (Functional programming)

**Development Dependencies**:
- flutter_test (Testing framework)
- drift_dev: ^2.26.0 (Code generation for Drift)
- build_runner: ^2.4.15 (Code generation tool)

## Build & Installation
```bash
# Get dependencies
flutter pub get

# Run the application in debug mode
flutter run

# Build release version for Android
flutter build apk --release

# Build release version for iOS
flutter build ios --release
```

## Testing
**Framework**: flutter_test
**Test Location**: test/
**Run Command**:
```bash
flutter test
```

## Main Entry Points
- **lib/main.dart**: Application entry point that initializes SQLite and sets up the ProviderScope
- **lib/features/bottom_bar.dart**: Main navigation component (SideBarMenu)
- **lib/features/habbit_tracker/view/habbit_tracker_view.dart**: Habit tracker feature
- **lib/features/tasks/view/tasks_screen.dart**: Tasks management feature
- **lib/features/reminders/reminders_screen.dart**: Reminders feature
- **lib/features/notepad/notepad.dart**: Notepad feature

## Data Layer
**Database**: SQLite via Drift ORM
**Models**:
- lib/data/models/tasks.dart
- lib/data/models/habbits.dart
**Database Connection**: lib/data/repository/database_connection.dart