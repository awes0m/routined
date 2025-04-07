import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';
import 'dart:io' show  File;

/// Initialize SQLite for Android
Future<void> initializeSqlite() async {
  try {
    // Apply workaround for older Android versions
    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

    // Initialize SQLite for Android
    sqlite3.openInMemory().dispose();
  } catch (e) {
    print('Error initializing SQLite: $e');
  }
}

/// Creates a database connection for Android
LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'routined.sqlite'));

    return NativeDatabase(
      file,
      // Enable foreign keys
      setup: (db) => db.execute('PRAGMA foreign_keys = ON'),
    );
  });
}
