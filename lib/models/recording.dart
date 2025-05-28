import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording.freezed.dart';
part 'recording.g.dart';

@freezed
class Recording with _$Recording {
  const factory Recording({
    required String id,
    required String name,
    required String filePath,
    required int duration, // in seconds
    required DateTime dateCreated,
  }) = _Recording;

  factory Recording.fromJson(Map<String, dynamic> json) =>
      _$RecordingFromJson(json);
}

@freezed
class AudioRecordingState with _$AudioRecordingState {
  const factory AudioRecordingState.idle() = _Idle;
  const factory AudioRecordingState.recording() = _RecordingState;
  const factory AudioRecordingState.paused() = _Paused;
  const factory AudioRecordingState.playing() = _Playing;
}
