// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AudioState {
  AudioRecordingState get recordingState => throw _privateConstructorUsedError;
  Duration get recordingDuration => throw _privateConstructorUsedError;
  Duration get playbackPosition => throw _privateConstructorUsedError;
  Duration get totalDuration => throw _privateConstructorUsedError;
  String? get currentRecordingId => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioStateCopyWith<AudioState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStateCopyWith<$Res> {
  factory $AudioStateCopyWith(
    AudioState value,
    $Res Function(AudioState) then,
  ) = _$AudioStateCopyWithImpl<$Res, AudioState>;
  @useResult
  $Res call({
    AudioRecordingState recordingState,
    Duration recordingDuration,
    Duration playbackPosition,
    Duration totalDuration,
    String? currentRecordingId,
    String? error,
  });

  $AudioRecordingStateCopyWith<$Res> get recordingState;
}

/// @nodoc
class _$AudioStateCopyWithImpl<$Res, $Val extends AudioState>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordingState = null,
    Object? recordingDuration = null,
    Object? playbackPosition = null,
    Object? totalDuration = null,
    Object? currentRecordingId = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            recordingState:
                null == recordingState
                    ? _value.recordingState
                    : recordingState // ignore: cast_nullable_to_non_nullable
                        as AudioRecordingState,
            recordingDuration:
                null == recordingDuration
                    ? _value.recordingDuration
                    : recordingDuration // ignore: cast_nullable_to_non_nullable
                        as Duration,
            playbackPosition:
                null == playbackPosition
                    ? _value.playbackPosition
                    : playbackPosition // ignore: cast_nullable_to_non_nullable
                        as Duration,
            totalDuration:
                null == totalDuration
                    ? _value.totalDuration
                    : totalDuration // ignore: cast_nullable_to_non_nullable
                        as Duration,
            currentRecordingId:
                freezed == currentRecordingId
                    ? _value.currentRecordingId
                    : currentRecordingId // ignore: cast_nullable_to_non_nullable
                        as String?,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AudioRecordingStateCopyWith<$Res> get recordingState {
    return $AudioRecordingStateCopyWith<$Res>(_value.recordingState, (value) {
      return _then(_value.copyWith(recordingState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AudioStateImplCopyWith<$Res>
    implements $AudioStateCopyWith<$Res> {
  factory _$$AudioStateImplCopyWith(
    _$AudioStateImpl value,
    $Res Function(_$AudioStateImpl) then,
  ) = __$$AudioStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AudioRecordingState recordingState,
    Duration recordingDuration,
    Duration playbackPosition,
    Duration totalDuration,
    String? currentRecordingId,
    String? error,
  });

  @override
  $AudioRecordingStateCopyWith<$Res> get recordingState;
}

/// @nodoc
class __$$AudioStateImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$AudioStateImpl>
    implements _$$AudioStateImplCopyWith<$Res> {
  __$$AudioStateImplCopyWithImpl(
    _$AudioStateImpl _value,
    $Res Function(_$AudioStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordingState = null,
    Object? recordingDuration = null,
    Object? playbackPosition = null,
    Object? totalDuration = null,
    Object? currentRecordingId = freezed,
    Object? error = freezed,
  }) {
    return _then(
      _$AudioStateImpl(
        recordingState:
            null == recordingState
                ? _value.recordingState
                : recordingState // ignore: cast_nullable_to_non_nullable
                    as AudioRecordingState,
        recordingDuration:
            null == recordingDuration
                ? _value.recordingDuration
                : recordingDuration // ignore: cast_nullable_to_non_nullable
                    as Duration,
        playbackPosition:
            null == playbackPosition
                ? _value.playbackPosition
                : playbackPosition // ignore: cast_nullable_to_non_nullable
                    as Duration,
        totalDuration:
            null == totalDuration
                ? _value.totalDuration
                : totalDuration // ignore: cast_nullable_to_non_nullable
                    as Duration,
        currentRecordingId:
            freezed == currentRecordingId
                ? _value.currentRecordingId
                : currentRecordingId // ignore: cast_nullable_to_non_nullable
                    as String?,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$AudioStateImpl implements _AudioState {
  const _$AudioStateImpl({
    this.recordingState = const AudioRecordingState.idle(),
    this.recordingDuration = Duration.zero,
    this.playbackPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.currentRecordingId,
    this.error,
  });

  @override
  @JsonKey()
  final AudioRecordingState recordingState;
  @override
  @JsonKey()
  final Duration recordingDuration;
  @override
  @JsonKey()
  final Duration playbackPosition;
  @override
  @JsonKey()
  final Duration totalDuration;
  @override
  final String? currentRecordingId;
  @override
  final String? error;

  @override
  String toString() {
    return 'AudioState(recordingState: $recordingState, recordingDuration: $recordingDuration, playbackPosition: $playbackPosition, totalDuration: $totalDuration, currentRecordingId: $currentRecordingId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioStateImpl &&
            (identical(other.recordingState, recordingState) ||
                other.recordingState == recordingState) &&
            (identical(other.recordingDuration, recordingDuration) ||
                other.recordingDuration == recordingDuration) &&
            (identical(other.playbackPosition, playbackPosition) ||
                other.playbackPosition == playbackPosition) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.currentRecordingId, currentRecordingId) ||
                other.currentRecordingId == currentRecordingId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    recordingState,
    recordingDuration,
    playbackPosition,
    totalDuration,
    currentRecordingId,
    error,
  );

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioStateImplCopyWith<_$AudioStateImpl> get copyWith =>
      __$$AudioStateImplCopyWithImpl<_$AudioStateImpl>(this, _$identity);
}

abstract class _AudioState implements AudioState {
  const factory _AudioState({
    final AudioRecordingState recordingState,
    final Duration recordingDuration,
    final Duration playbackPosition,
    final Duration totalDuration,
    final String? currentRecordingId,
    final String? error,
  }) = _$AudioStateImpl;

  @override
  AudioRecordingState get recordingState;
  @override
  Duration get recordingDuration;
  @override
  Duration get playbackPosition;
  @override
  Duration get totalDuration;
  @override
  String? get currentRecordingId;
  @override
  String? get error;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioStateImplCopyWith<_$AudioStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
