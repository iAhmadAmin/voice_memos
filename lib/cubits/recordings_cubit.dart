import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/recording.dart';
import '../services/database_service.dart';
import '../services/audio_service.dart';
import '../core/service_locator.dart';

part 'recordings_cubit.freezed.dart';

@freezed
class RecordingsState with _$RecordingsState {
  const factory RecordingsState({
    @Default([]) List<Recording> recordings,
    @Default(false) bool isLoading,
    String? error,
  }) = _RecordingsState;
}

class RecordingsCubit extends Cubit<RecordingsState> {
  RecordingsCubit() : super(const RecordingsState()) {
    _loadRecordings();
  }

  final DatabaseService _databaseService = getIt<DatabaseService>();
  final AudioService _audioService = getIt<AudioService>();

  Future<void> _loadRecordings() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final recordings = await _databaseService.getAllRecordings();

      // Validate file paths and fix any issues
      final validatedRecordings = await _validateRecordingFiles(recordings);

      emit(state.copyWith(recordings: validatedRecordings, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load recordings: $e',
        ),
      );
    }
  }

  Future<List<Recording>> _validateRecordingFiles(
    List<Recording> recordings,
  ) async {
    print('RecordingsCubit: Validating ${recordings.length} recordings');
    final validRecordings = <Recording>[];
    final recordingsDir = await getApplicationDocumentsDirectory();
    print('RecordingsCubit: Documents directory: ${recordingsDir.path}');

    for (final recording in recordings) {
      final file = File(recording.filePath);
      print('RecordingsCubit: Checking file: ${recording.filePath}');

      if (await file.exists()) {
        // File exists at the stored path
        print('RecordingsCubit: File exists at stored path');
        validRecordings.add(recording);
      } else {
        // Try to find the file by filename in the documents directory
        final fileName = basename(recording.filePath);
        final expectedPath = join(recordingsDir.path, fileName);
        final expectedFile = File(expectedPath);

        print(
          'RecordingsCubit: File not found at stored path, trying: $expectedPath',
        );

        if (await expectedFile.exists()) {
          // File exists but path was wrong, update the recording
          print(
            'RecordingsCubit: Found file at expected path, updating record',
          );
          final updatedRecording = recording.copyWith(filePath: expectedPath);
          validRecordings.add(updatedRecording);

          // Update the database with the correct path
          await _databaseService.updateRecording(updatedRecording);
        } else {
          // File is missing, we could either:
          // 1. Remove the recording from the list (current approach)
          // 2. Keep it but mark it as unavailable
          // For now, we'll skip missing files
          print(
            'Warning: Audio file not found for recording: ${recording.name}',
          );
        }
      }
    }

    print(
      'RecordingsCubit: Validated ${validRecordings.length} out of ${recordings.length} recordings',
    );
    return validRecordings;
  }

  Future<void> addRecording(Recording recording) async {
    try {
      await _databaseService.insertRecording(recording);
      await _loadRecordings();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to save recording: $e'));
    }
  }

  Future<void> updateRecording(Recording recording) async {
    try {
      await _databaseService.updateRecording(recording);
      await _loadRecordings();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update recording: $e'));
    }
  }

  Future<void> deleteRecording(String id) async {
    try {
      // Find the recording to get the file path
      final recording = state.recordings.firstWhere((r) => r.id == id);

      // Delete the file
      await _audioService.deleteRecordingFile(recording.filePath);

      // Delete from database
      await _databaseService.deleteRecording(id);

      await _loadRecordings();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete recording: $e'));
    }
  }

  Future<void> renameRecording(String id, String newName) async {
    try {
      final recording = state.recordings.firstWhere((r) => r.id == id);
      final updatedRecording = recording.copyWith(name: newName);
      await updateRecording(updatedRecording);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to rename recording: $e'));
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  Future<void> refreshRecordings() async {
    await _loadRecordings();
  }
}
