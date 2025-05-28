import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_memos/cubits/recordings_cubit.dart';
import 'package:voice_memos/models/recording.dart';
import 'package:voice_memos/widgets/recording_tile.dart';

class RecordingsView extends StatelessWidget {
  const RecordingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecordingsCubit, RecordingsState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
          context.read<RecordingsCubit>().clearError();
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.recordings.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mic_none, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No recordings yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tap the record button to get started',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.recordings.length,
          itemBuilder: (context, index) {
            final recording = state.recordings[index];
            return RecordingTile(
              recording: recording,
              onDelete: () => _showDeleteDialog(context, recording),
              onRename: () => _showRenameDialog(context, recording),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, Recording recording) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Recording'),
            content: Text(
              'Are you sure you want to delete "${recording.name}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<RecordingsCubit>().deleteRecording(recording.id);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  void _showRenameDialog(BuildContext context, Recording recording) {
    final controller = TextEditingController(text: recording.name);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Rename Recording'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Recording name',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final newName = controller.text.trim();
                  if (newName.isNotEmpty) {
                    context.read<RecordingsCubit>().renameRecording(
                      recording.id,
                      newName,
                    );
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }
}
