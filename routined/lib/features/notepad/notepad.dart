import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routined/common/custom_appbar.dart';

import '../../core/globals.dart';
import 'notes_provider.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return Scaffold(
      appBar: customAppBar(
        titleText: 'Notes',
        key: Globals.drawerKey,
        actions: [
          IconButton(
            tooltip: 'Add note',
            icon: const Icon(Icons.note_add),
            onPressed: () => _showAddNoteDialog(context, ref),
          ),
        ],
      ),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet. Tap + to add.'));
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: GridView.builder(
              key: ValueKey(notes.length),
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Dismissible(
                  key: ValueKey(note.id),
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  onDismissed:
                      (_) => ref.read(notesProvider.notifier).remove(note.id),
                  child: _NoteCard(noteId: note.id),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<void> _showAddNoteDialog(BuildContext context, WidgetRef ref) async {
    final titleCtrl = TextEditingController();
    final contentCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('New note'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Title (optional)',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: contentCtrl,
                    minLines: 4,
                    maxLines: 8,
                    decoration: const InputDecoration(labelText: 'Content'),
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
    if (ok == true && contentCtrl.text.trim().isNotEmpty) {
      await ref
          .read(notesProvider.notifier)
          .add(title: titleCtrl.text.trim(), content: contentCtrl.text.trim());
    }
  }
}

class _NoteCard extends ConsumerWidget {
  final int noteId;
  const _NoteCard({required this.noteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notesProvider);
    final note = state.value?.firstWhere((n) => n.id == noteId);
    if (note == null) return const SizedBox.shrink();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Color(note.color),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showEdit(context, ref, note),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title.isEmpty ? 'Untitled' : note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: note.pinned ? 'Unpin' : 'Pin',
                    onPressed:
                        () => ref.read(notesProvider.notifier).togglePin(note),
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                      child: Icon(
                        note.pinned ? Icons.push_pin : Icons.push_pin_outlined,
                        key: ValueKey(note.pinned),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  note.content,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEdit(
    BuildContext context,
    WidgetRef ref,
    dynamic note,
  ) async {
    final titleCtrl = TextEditingController(text: note.title);
    final contentCtrl = TextEditingController(text: note.content);
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('Edit note'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Title (optional)',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: contentCtrl,
                    minLines: 4,
                    maxLines: 8,
                    decoration: const InputDecoration(labelText: 'Content'),
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
                child: const Text('Save'),
              ),
            ],
          ),
    );
    if (ok == true && contentCtrl.text.trim().isNotEmpty) {
      await ref
          .read(notesProvider.notifier)
          .updateNote(
            note,
            title: titleCtrl.text.trim(),
            content: contentCtrl.text.trim(),
          );
    }
  }
}
