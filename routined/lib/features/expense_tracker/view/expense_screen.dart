import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routined/core/core.dart';
import '../../../common/custom_appbar.dart';
import '../../settings/view_model/settings_notifier.dart';
import '../view_model/expense_providers.dart';
import '../../../data/models/transactions.dart';

class ExpenseScreen extends ConsumerWidget {
  static const routeName = '/expenses';
  const ExpenseScreen({super.key});

  String _fmt(WidgetRef ref, int cents) {
    final cur = ref.watch(settingsProvider).value?.currencyCode ?? 'USD';
    final sign = cents < 0 ? '-' : '';
    final absCents = cents.abs();
    final whole = absCents ~/ 100;
    final fraction = (absCents % 100).toString().padLeft(2, '0');
    return '$sign$cur $whole.$fraction';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    // final categories = ref.watch(categoriesProvider); // Unused watcher removed to fix analyzer warning
    final txs = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: customAppBar(
        titleText: 'Expense Tracker',
        appBarColor: Colors.greenAccent,
        key: Globals.drawerKey,
        actions: [
          IconButton(
            tooltip: 'Add account',
            icon: const Icon(Icons.account_balance),
            onPressed: () => _showAddAccountDialog(context, ref),
          ),
          IconButton(
            tooltip: 'Add category',
            icon: const Icon(Icons.category),
            onPressed: () => _showAddCategoryDialog(context, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddTransactionDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Accounts summary
          accounts.when(
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => ListTile(title: Text('Accounts error: $e')),
            data:
                (list) => SizedBox(
                  height: 80,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, i) {
                      final a = list[i];
                      return Chip(
                        label: Text('${a.name}: ${_fmt(ref, a.balanceCents)}'),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: list.length,
                  ),
                ),
          ),
          const Divider(height: 1),
          // Transactions
          Expanded(
            child: txs.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Transactions error: $e')),
              data:
                  (list) => ListView.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final t = list[index];
                      final isIncome = t.type == TxType.income;
                      final amount = isIncome ? t.amountCents : -t.amountCents;
                      return ListTile(
                        leading: Icon(
                          isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isIncome ? Colors.green : Colors.red,
                        ),
                        title: Text(
                          t.description ?? (isIncome ? 'Income' : 'Expense'),
                        ),
                        subtitle: Text('${t.timestamp}'),
                        trailing: Text(
                          _fmt(ref, amount),
                          style: TextStyle(
                            color: isIncome ? Colors.green : Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddTransactionDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final accs = ref.read(accountsProvider).value ?? [];
    final cats = ref.read(categoriesProvider).value ?? [];
    if (accs.isEmpty || cats.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create an account and category first')),
        );
      }
      return;
    }

    TxType selectedType = TxType.expense;
    int selectedAccountId = accs.first.id;
    int selectedCategoryId = cats.first.id;
    final amountCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('Add transaction'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<TxType>(
                    value: selectedType,
                    items: const [
                      DropdownMenuItem(
                        value: TxType.expense,
                        child: Text('Expense'),
                      ),
                      DropdownMenuItem(
                        value: TxType.income,
                        child: Text('Income'),
                      ),
                    ],
                    onChanged: (v) => selectedType = v ?? TxType.expense,
                    decoration: const InputDecoration(labelText: 'Type'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: selectedAccountId,
                    items: [
                      for (final a in accs)
                        DropdownMenuItem(value: a.id, child: Text(a.name)),
                    ],
                    onChanged: (v) => selectedAccountId = v ?? accs.first.id,
                    decoration: const InputDecoration(labelText: 'Account'),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: selectedCategoryId,
                    items: [
                      for (final cat in cats)
                        DropdownMenuItem(value: cat.id, child: Text(cat.name)),
                    ],
                    onChanged: (v) => selectedCategoryId = v ?? cats.first.id,
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: amountCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      hintText: 'e.g. 12.99',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(c).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(c).pop(true),
                child: const Text('Add'),
              ),
            ],
          ),
    );

    if (result != true) return;

    final text = amountCtrl.text.trim();
    if (text.isEmpty) return;
    final parts = text.split('.');
    int cents = 0;
    try {
      if (parts.length == 1) {
        cents = int.parse(parts[0]) * 100;
      } else if (parts.length == 2) {
        final whole = int.parse(parts[0]);
        final frac = parts[1].padRight(2, '0').substring(0, 2);
        cents = whole * 100 + int.parse(frac);
      } else {
        return;
      }
    } catch (_) {
      return;
    }

    await ref
        .read(transactionsProvider.notifier)
        .addTransaction(
          type: selectedType,
          amountCents: cents,
          categoryId: selectedCategoryId,
          accountId: selectedAccountId,
          description:
              descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
        );
  }

  Future<void> _showAddAccountDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('New account'),
            content: TextField(
              controller: ctrl,
              decoration: const InputDecoration(labelText: 'Account name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(c).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(c).pop(true),
                child: const Text('Add'),
              ),
            ],
          ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      await ref
          .read(accountsProvider.notifier)
          .addAccount(name: ctrl.text.trim());
    }
  }

  Future<void> _showAddCategoryDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('New category'),
            content: TextField(
              controller: ctrl,
              decoration: const InputDecoration(labelText: 'Category name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(c).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(c).pop(true),
                child: const Text('Add'),
              ),
            ],
          ),
    );
    if (ok == true && ctrl.text.trim().isNotEmpty) {
      await ref
          .read(categoriesProvider.notifier)
          .addCategory(name: ctrl.text.trim());
    }
  }
}
