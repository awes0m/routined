import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/custom_appbar.dart';
import '../../../core/core.dart';
import '../view_model/settings_notifier.dart';

class SettingsScreen extends ConsumerWidget {
  static const routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(settingsProvider);

    return Scaffold(
      appBar: customAppBar(
        appBarColor: Colors.grey,
        key: Globals.drawerKey,
        titleText: 'Settings',
      ),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data:
            (s) => ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Default Currency',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: s.currencyCode,
                  items: const [
                    DropdownMenuItem(
                      value: 'USD',
                      child: Text('USD — US Dollar'),
                    ),
                    DropdownMenuItem(value: 'EUR', child: Text('EUR — Euro')),
                    DropdownMenuItem(
                      value: 'GBP',
                      child: Text('GBP — British Pound'),
                    ),
                    DropdownMenuItem(
                      value: 'INR',
                      child: Text('INR — Indian Rupee'),
                    ),
                    DropdownMenuItem(
                      value: 'JPY',
                      child: Text('JPY — Japanese Yen'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(settingsProvider.notifier).setCurrency(val);
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Backup & Restore',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          try {
                            final path =
                                await ref
                                    .read(settingsProvider.notifier)
                                    .exportAllData();
                            messenger.showSnackBar(
                              SnackBar(content: Text('Exported to: $path')),
                            );
                          } catch (e) {
                            messenger.showSnackBar(
                              SnackBar(content: Text('Export failed: $e')),
                            );
                          }
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Export data'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final ok =
                              await ref
                                  .read(settingsProvider.notifier)
                                  .importLatestBackup();
                          if (ok) {
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder:
                                    (c) => AlertDialog(
                                      title: const Text('Import completed'),
                                      content: const Text(
                                        'Please restart the app to apply restored data.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(c).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                              );
                            }
                          } else {
                            messenger.showSnackBar(
                              const SnackBar(
                                content: Text('No backup found to import.'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.download),
                        label: const Text('Import latest'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
