import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/recording.dart';
import '../services/audio_service.dart';
import '../core/service_locator.dart';

part 'audio_cubit.freezed.dart';

@freezed
class AudioState with _$AudioState {
  const factory AudioState({
    @Default(AudioRecordingState.idle()) AudioRecordingState recordingState,
    @Default(Duration.zero) Duration recordingDuration,
    @Default(Duration.zero) Duration playbackPosition,
    @Default(Duration.zero) Duration totalDuration,
    String? currentRecordingId,
    String? error,
  }) = _AudioState;
}

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(const AudioState()) {
    _setupListeners();
  }

  final AudioService _audioService = getIt<AudioService>();
  StreamSubscription<Duration>? _recordingDurationSubscription;
  StreamSubscription<Duration>? _playbackPositionSubscription;
  StreamSubscription<AudioRecordingState>? _recordingStateSubscription;

  void _setupListeners() {
    _recordingDurationSubscription = _audioService.recordingDurationStream
        .listen((duration) {
          emit(state.copyWith(recordingDuration: duration));
        });

    _playbackPositionSubscription = _audioService.playbackPositionStream.listen(
      (position) {
        emit(state.copyWith(playbackPosition: position));
      },
    );

    _recordingStateSubscription = _audioService.recordingStateStream.listen((
      recordingState,
    ) {
      emit(state.copyWith(recordingState: recordingState));
    });
  }

  Future<bool> checkPermissions() async {
    try {
      return await _audioService.hasPermission();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to check permissions: $e'));
      return false;
    }
  }

  Future<void> startRecording() async {
    try {
      emit(state.copyWith(error: null));
      await _audioService.startRecording();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to start recording: $e'));
    }
  }

  Future<Recording?> stopRecording() async {
    try {
      final recording = await _audioService.stopRecording();
      emit(
        state.copyWith(
          recordingDuration: Duration.zero,
          recordingState: const AudioRecordingState.idle(),
        ),
      );
      return recording;
    } catch (e) {
      emit(state.copyWith(error: 'Failed to stop recording: $e'));
      return null;
    }
  }

  Future<void> playRecording(String filePath, {Duration? totalDuration}) async {
    try {
      emit(
        state.copyWith(
          error: null,
          totalDuration: totalDuration ?? Duration.zero,
          playbackPosition: Duration.zero,
        ),
      );
      await _audioService.playRecording(filePath);
    } catch (e) {
      emit(state.copyWith(error: 'Failed to play recording: $e'));
    }
  }

  Future<void> pausePlayback() async {
    try {
      await _audioService.pausePlayback();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to pause playback: $e'));
    }
  }

  Future<void> resumePlayback() async {
    try {
      await _audioService.resumePlayback();
    } catch (e) {
      emit(state.copyWith(error: 'Failed to resume playback: $e'));
    }
  }

  Future<void> stopPlayback() async {
    try {
      await _audioService.stopPlayback();
      emit(
        state.copyWith(
          playbackPosition: Duration.zero,
          recordingState: const AudioRecordingState.idle(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: 'Failed to stop playback: $e'));
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await _audioService.seekTo(position);
      emit(state.copyWith(playbackPosition: position));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to seek: $e'));
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  @override
  Future<void> close() {
    _recordingDurationSubscription?.cancel();
    _playbackPositionSubscription?.cancel();
    _recordingStateSubscription?.cancel();
    return super.close();
  }
}
