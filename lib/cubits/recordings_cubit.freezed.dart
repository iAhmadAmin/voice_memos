// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recordings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecordingsState {
  List<Recording> get recordings => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of RecordingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordingsStateCopyWith<RecordingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingsStateCopyWith<$Res> {
  factory $RecordingsStateCopyWith(
    RecordingsState value,
    $Res Function(RecordingsState) then,
  ) = _$RecordingsStateCopyWithImpl<$Res, RecordingsState>;
  @useResult
  $Res call({List<Recording> recordings, bool isLoading, String? error});
}

/// @nodoc
class _$RecordingsStateCopyWithImpl<$Res, $Val extends RecordingsState>
    implements $RecordingsStateCopyWith<$Res> {
  _$RecordingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordings = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            recordings:
                null == recordings
                    ? _value.recordings
                    : recordings // ignore: cast_nullable_to_non_nullable
                        as List<Recording>,
            isLoading:
                null == isLoading
                    ? _value.isLoading
                    : isLoading // ignore: cast_nullable_to_non_nullable
                        as bool,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecordingsStateImplCopyWith<$Res>
    implements $RecordingsStateCopyWith<$Res> {
  factory _$$RecordingsStateImplCopyWith(
    _$RecordingsStateImpl value,
    $Res Function(_$RecordingsStateImpl) then,
  ) = __$$RecordingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Recording> recordings, bool isLoading, String? error});
}

/// @nodoc
class __$$RecordingsStateImplCopyWithImpl<$Res>
    extends _$RecordingsStateCopyWithImpl<$Res, _$RecordingsStateImpl>
    implements _$$RecordingsStateImplCopyWith<$Res> {
  __$$RecordingsStateImplCopyWithImpl(
    _$RecordingsStateImpl _value,
    $Res Function(_$RecordingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecordingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordings = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$RecordingsStateImpl(
        recordings:
            null == recordings
                ? _value._recordings
                : recordings // ignore: cast_nullable_to_non_nullable
                    as List<Recording>,
        isLoading:
            null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                    as bool,
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

class _$RecordingsStateImpl implements _RecordingsState {
  const _$RecordingsStateImpl({
    final List<Recording> recordings = const [],
    this.isLoading = false,
    this.error,
  }) : _recordings = recordings;

  final List<Recording> _recordings;
  @override
  @JsonKey()
  List<Recording> get recordings {
    if (_recordings is EqualUnmodifiableListView) return _recordings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recordings);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'RecordingsState(recordings: $recordings, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordingsStateImpl &&
            const DeepCollectionEquality().equals(
              other._recordings,
              _recordings,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_recordings),
    isLoading,
    error,
  );

  /// Create a copy of RecordingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordingsStateImplCopyWith<_$RecordingsStateImpl> get copyWith =>
      __$$RecordingsStateImplCopyWithImpl<_$RecordingsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RecordingsState implements RecordingsState {
  const factory _RecordingsState({
    final List<Recording> recordings,
    final bool isLoading,
    final String? error,
  }) = _$RecordingsStateImpl;

  @override
  List<Recording> get recordings;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of RecordingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordingsStateImplCopyWith<_$RecordingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
