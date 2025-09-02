import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repository/app_database.dart';

final settingsProvider =
    AutoDisposeAsyncNotifierProvider<SettingsNotifier, SettingsState>(
      SettingsNotifier.new,
    );

class SettingsState {
  final String currencyCode; // e.g., "USD"
  const SettingsState({required this.currencyCode});

  SettingsState copyWith({String? currencyCode}) =>
      SettingsState(currencyCode: currencyCode ?? this.currencyCode);
}

class SettingsNotifier extends AutoDisposeAsyncNotifier<SettingsState> {
  static const _keyCurrency = 'currency_code';

  @override
  Future<SettingsState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_keyCurrency) ?? 'USD';
    return SettingsState(currencyCode: code);
  }

  Future<void> setCurrency(String code) async {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(currencyCode: code));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrency, code);
  }

  // -------- Backup & Restore --------

  Future<Directory> _getDatabaseDir() async {
    // Same location as database_connection.dart
    return getApplicationDocumentsDirectory();
  }

  Future<File> _getDatabaseFile() async {
    final dir = await _getDatabaseDir();
    return File(p.join(dir.path, 'routined.sqlite'));
  }

  Future<Directory> _getDefaultBackupDir() async {
    // Try platform-specific sensible locations
    if (!kIsWeb) {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        final dl = await getDownloadsDirectory();
        if (dl != null) return Directory(p.join(dl.path, 'RoutinedBackups'));
      }
      if (Platform.isAndroid) {
        // App-specific external files dir (visible in file managers)
        final ext = await getExternalStorageDirectory();
        if (ext != null) return Directory(p.join(ext.path, 'RoutinedBackups'));
      }
      // iOS or fallback
      final docs = await getApplicationDocumentsDirectory();
      return Directory(p.join(docs.path, 'RoutinedBackups'));
    }
    final docs = await getApplicationDocumentsDirectory();
    return Directory(p.join(docs.path, 'RoutinedBackups'));
  }

  String _timestamp() {
    final now = DateTime.now();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${now.year}${two(now.month)}${two(now.day)}_${two(now.hour)}${two(now.minute)}${two(now.second)}';
  }

  Future<String> exportAllData() async {
    final dbFile = await _getDatabaseFile();
    if (!await dbFile.exists()) {
      throw Exception('Database file not found');
    }

    final backupDir = await _getDefaultBackupDir();
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }

    final backupPath = p.join(
      backupDir.path,
      'routined_backup_${_timestamp()}.sqlite',
    );

    // Prefer SQLite VACUUM INTO when possible; fallback to raw copy
    try {
      // If DB is open, VACUUM INTO creates a consistent copy without closing
      // Not all sqlite builds support it; if it fails, we just copy the file.
      await AppDatabase.instance().customStatement(
        "VACUUM INTO '" + backupPath.replaceAll("'", "''") + "'",
      );
      if (!await File(backupPath).exists()) {
        // Some platforms may not create due to permissions; fallback
        await dbFile.copy(backupPath);
      }
    } catch (_) {
      await dbFile.copy(backupPath);
    }

    return backupPath;
  }

  Future<bool> importLatestBackup() async {
    final backupDir = await _getDefaultBackupDir();
    if (!await backupDir.exists()) return false;

    final files =
        backupDir
            .listSync()
            .whereType<File>()
            .where((f) => f.path.toLowerCase().endsWith('.sqlite'))
            .toList()
          ..sort(
            (a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()),
          );

    if (files.isEmpty) return false;

    final source = files.first;
    final dbFile = await _getDatabaseFile();

    // Close DB before replacing to avoid locks
    try {
      await AppDatabase.instance().close();
    } catch (_) {
      // Ignore; proceed to replace
    }

    // Replace database file
    if (await dbFile.exists()) {
      await dbFile.delete();
    }
    await source.copy(dbFile.path);

    // We recommend app restart to re-open the singleton DB cleanly
    return true;
  }
}
