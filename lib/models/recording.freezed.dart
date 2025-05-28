// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Recording _$RecordingFromJson(Map<String, dynamic> json) {
  return _Recording.fromJson(json);
}

/// @nodoc
mixin _$Recording {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError; // in seconds
  DateTime get dateCreated => throw _privateConstructorUsedError;

  /// Serializes this Recording to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Recording
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordingCopyWith<Recording> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingCopyWith<$Res> {
  factory $RecordingCopyWith(Recording value, $Res Function(Recording) then) =
      _$RecordingCopyWithImpl<$Res, Recording>;
  @useResult
  $Res call({
    String id,
    String name,
    String filePath,
    int duration,
    DateTime dateCreated,
  });
}

/// @nodoc
class _$RecordingCopyWithImpl<$Res, $Val extends Recording>
    implements $RecordingCopyWith<$Res> {
  _$RecordingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Recording
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? duration = null,
    Object? dateCreated = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            filePath:
                null == filePath
                    ? _value.filePath
                    : filePath // ignore: cast_nullable_to_non_nullable
                        as String,
            duration:
                null == duration
                    ? _value.duration
                    : duration // ignore: cast_nullable_to_non_nullable
                        as int,
            dateCreated:
                null == dateCreated
                    ? _value.dateCreated
                    : dateCreated // ignore: cast_nullable_to_non_nullable
                        as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecordingImplCopyWith<$Res>
    implements $RecordingCopyWith<$Res> {
  factory _$$RecordingImplCopyWith(
    _$RecordingImpl value,
    $Res Function(_$RecordingImpl) then,
  ) = __$$RecordingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String filePath,
    int duration,
    DateTime dateCreated,
  });
}

/// @nodoc
class __$$RecordingImplCopyWithImpl<$Res>
    extends _$RecordingCopyWithImpl<$Res, _$RecordingImpl>
    implements _$$RecordingImplCopyWith<$Res> {
  __$$RecordingImplCopyWithImpl(
    _$RecordingImpl _value,
    $Res Function(_$RecordingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Recording
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? duration = null,
    Object? dateCreated = null,
  }) {
    return _then(
      _$RecordingImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        filePath:
            null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                    as String,
        duration:
            null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                    as int,
        dateCreated:
            null == dateCreated
                ? _value.dateCreated
                : dateCreated // ignore: cast_nullable_to_non_nullable
                    as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordingImpl implements _Recording {
  const _$RecordingImpl({
    required this.id,
    required this.name,
    required this.filePath,
    required this.duration,
    required this.dateCreated,
  });

  factory _$RecordingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordingImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String filePath;
  @override
  final int duration;
  // in seconds
  @override
  final DateTime dateCreated;

  @override
  String toString() {
    return 'Recording(id: $id, name: $name, filePath: $filePath, duration: $duration, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, filePath, duration, dateCreated);

  /// Create a copy of Recording
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordingImplCopyWith<_$RecordingImpl> get copyWith =>
      __$$RecordingImplCopyWithImpl<_$RecordingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordingImplToJson(this);
  }
}

abstract class _Recording implements Recording {
  const factory _Recording({
    required final String id,
    required final String name,
    required final String filePath,
    required final int duration,
    required final DateTime dateCreated,
  }) = _$RecordingImpl;

  factory _Recording.fromJson(Map<String, dynamic> json) =
      _$RecordingImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get filePath;
  @override
  int get duration; // in seconds
  @override
  DateTime get dateCreated;

  /// Create a copy of Recording
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordingImplCopyWith<_$RecordingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AudioRecordingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() paused,
    required TResult Function() playing,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? paused,
    TResult? Function()? playing,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? paused,
    TResult Function()? playing,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_RecordingState value) recording,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Playing value) playing,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_RecordingState value)? recording,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Playing value)? playing,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_RecordingState value)? recording,
    TResult Function(_Paused value)? paused,
    TResult Function(_Playing value)? playing,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioRecordingStateCopyWith<$Res> {
  factory $AudioRecordingStateCopyWith(
    AudioRecordingState value,
    $Res Function(AudioRecordingState) then,
  ) = _$AudioRecordingStateCopyWithImpl<$Res, AudioRecordingState>;
}

/// @nodoc
class _$AudioRecordingStateCopyWithImpl<$Res, $Val extends AudioRecordingState>
    implements $AudioRecordingStateCopyWith<$Res> {
  _$AudioRecordingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioRecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
    _$IdleImpl value,
    $Res Function(_$IdleImpl) then,
  ) = __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$AudioRecordingStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
    : super(_value, _then);

  /// Create a copy of AudioRecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl implements _Idle {
  const _$IdleImpl();

  @override
  String toString() {
    return 'AudioRecordingState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() paused,
    required TResult Function() playing,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? paused,
    TResult? Function()? playing,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? paused,
    TResult Function()? playing,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_RecordingState value) recording,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Playing value) playing,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_RecordingState value)? recording,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Playing value)? playing,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_RecordingState value)? recording,
    TResult Function(_Paused value)? paused,
    TResult Function(_Playing value)? playing,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle implements AudioRecordingState {
  const factory _Idle() = _$IdleImpl;
}

/// @nodoc
abstract class _$$RecordingStateImplCopyWith<$Res> {
  factory _$$RecordingStateImplCopyWith(
    _$RecordingStateImpl value,
    $Res Function(_$RecordingStateImpl) then,
  ) = __$$RecordingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RecordingStateImplCopyWithImpl<$Res>
    extends _$AudioRecordingStateCopyWithImpl<$Res, _$RecordingStateImpl>
    implements _$$RecordingStateImplCopyWith<$Res> {
  __$$RecordingStateImplCopyWithImpl(
    _$RecordingStateImpl _value,
    $Res Function(_$RecordingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AudioRecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RecordingStateImpl implements _RecordingState {
  const _$RecordingStateImpl();

  @override
  String toString() {
    return 'AudioRecordingState.recording()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RecordingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() paused,
    required TResult Function() playing,
  }) {
    return recording();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? paused,
    TResult? Function()? playing,
  }) {
    return recording?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? paused,
    TResult Function()? playing,
    required TResult orElse(),
  }) {
    if (recording != null) {
      return recording();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_RecordingState value) recording,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Playing value) playing,
  }) {
    return recording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_RecordingState value)? recording,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Playing value)? playing,
  }) {
    return recording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_RecordingState value)? recording,
    TResult Function(_Paused value)? paused,
    TResult Function(_Playing value)? playing,
    required TResult orElse(),
  }) {
    if (recording != null) {
      return recording(this);
    }
    return orElse();
  }
}

abstract class _RecordingState implements AudioRecordingState {
  const factory _RecordingState() = _$RecordingStateImpl;
}

/// @nodoc
abstract class _$$PausedImplCopyWith<$Res> {
  factory _$$PausedImplCopyWith(
    _$PausedImpl value,
    $Res Function(_$PausedImpl) then,
  ) = __$$PausedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PausedImplCopyWithImpl<$Res>
    extends _$AudioRecordingStateCopyWithImpl<$Res, _$PausedImpl>
    implements _$$PausedImplCopyWith<$Res> {
  __$$PausedImplCopyWithImpl(
    _$PausedImpl _value,
    $Res Function(_$PausedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AudioRecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PausedImpl implements _Paused {
  const _$PausedImpl();

  @override
  String toString() {
    return 'AudioRecordingState.paused()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PausedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() paused,
    required TResult Function() playing,
  }) {
    return paused();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? paused,
    TResult? Function()? playing,
  }) {
    return paused?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? paused,
    TResult Function()? playing,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_RecordingState value) recording,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Playing value) playing,
  }) {
    return paused(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_RecordingState value)? recording,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Playing value)? playing,
  }) {
    return paused?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_RecordingState value)? recording,
    TResult Function(_Paused value)? paused,
    TResult Function(_Playing value)? playing,
    required TResult orElse(),
  }) {
    if (paused != null) {
      return paused(this);
    }
    return orElse();
  }
}

abstract class _Paused implements AudioRecordingState {
  const factory _Paused() = _$PausedImpl;
}

/// @nodoc
abstract class _$$PlayingImplCopyWith<$Res> {
  factory _$$PlayingImplCopyWith(
    _$PlayingImpl value,
    $Res Function(_$PlayingImpl) then,
  ) = __$$PlayingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayingImplCopyWithImpl<$Res>
    extends _$AudioRecordingStateCopyWithImpl<$Res, _$PlayingImpl>
    implements _$$PlayingImplCopyWith<$Res> {
  __$$PlayingImplCopyWithImpl(
    _$PlayingImpl _value,
    $Res Function(_$PlayingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AudioRecordingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PlayingImpl implements _Playing {
  const _$PlayingImpl();

  @override
  String toString() {
    return 'AudioRecordingState.playing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlayingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() recording,
    required TResult Function() paused,
    required TResult Function() playing,
  }) {
    return playing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? recording,
    TResult? Function()? paused,
    TResult? Function()? playing,
  }) {
    return playing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? recording,
    TResult Function()? paused,
    TResult Function()? playing,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle value) idle,
    required TResult Function(_RecordingState value) recording,
    required TResult Function(_Paused value) paused,
    required TResult Function(_Playing value) playing,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle value)? idle,
    TResult? Function(_RecordingState value)? recording,
    TResult? Function(_Paused value)? paused,
    TResult? Function(_Playing value)? playing,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle value)? idle,
    TResult Function(_RecordingState value)? recording,
    TResult Function(_Paused value)? paused,
    TResult Function(_Playing value)? playing,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class _Playing implements AudioRecordingState {
  const factory _Playing() = _$PlayingImpl;
}
