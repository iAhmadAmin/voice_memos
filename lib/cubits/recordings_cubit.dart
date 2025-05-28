import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
      emit(state.copyWith(recordings: recordings, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load recordings: $e',
        ),
      );
    }
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
}
