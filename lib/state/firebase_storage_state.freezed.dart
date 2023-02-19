// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_storage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FirebaseStorageState {
  AsyncValue<List<FolderModel>> get fileList =>
      throw _privateConstructorUsedError;
  String get folderName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FirebaseStorageStateCopyWith<FirebaseStorageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirebaseStorageStateCopyWith<$Res> {
  factory $FirebaseStorageStateCopyWith(FirebaseStorageState value,
          $Res Function(FirebaseStorageState) then) =
      _$FirebaseStorageStateCopyWithImpl<$Res, FirebaseStorageState>;
  @useResult
  $Res call({AsyncValue<List<FolderModel>> fileList, String folderName});
}

/// @nodoc
class _$FirebaseStorageStateCopyWithImpl<$Res,
        $Val extends FirebaseStorageState>
    implements $FirebaseStorageStateCopyWith<$Res> {
  _$FirebaseStorageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileList = null,
    Object? folderName = null,
  }) {
    return _then(_value.copyWith(
      fileList: null == fileList
          ? _value.fileList
          : fileList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<FolderModel>>,
      folderName: null == folderName
          ? _value.folderName
          : folderName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirebaseStorageStateCopyWith<$Res>
    implements $FirebaseStorageStateCopyWith<$Res> {
  factory _$$_FirebaseStorageStateCopyWith(_$_FirebaseStorageState value,
          $Res Function(_$_FirebaseStorageState) then) =
      __$$_FirebaseStorageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<FolderModel>> fileList, String folderName});
}

/// @nodoc
class __$$_FirebaseStorageStateCopyWithImpl<$Res>
    extends _$FirebaseStorageStateCopyWithImpl<$Res, _$_FirebaseStorageState>
    implements _$$_FirebaseStorageStateCopyWith<$Res> {
  __$$_FirebaseStorageStateCopyWithImpl(_$_FirebaseStorageState _value,
      $Res Function(_$_FirebaseStorageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileList = null,
    Object? folderName = null,
  }) {
    return _then(_$_FirebaseStorageState(
      fileList: null == fileList
          ? _value.fileList
          : fileList // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<FolderModel>>,
      folderName: null == folderName
          ? _value.folderName
          : folderName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_FirebaseStorageState implements _FirebaseStorageState {
  const _$_FirebaseStorageState(
      {this.fileList = const AsyncValue.loading(), this.folderName = ''});

  @override
  @JsonKey()
  final AsyncValue<List<FolderModel>> fileList;
  @override
  @JsonKey()
  final String folderName;

  @override
  String toString() {
    return 'FirebaseStorageState(fileList: $fileList, folderName: $folderName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirebaseStorageState &&
            (identical(other.fileList, fileList) ||
                other.fileList == fileList) &&
            (identical(other.folderName, folderName) ||
                other.folderName == folderName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fileList, folderName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirebaseStorageStateCopyWith<_$_FirebaseStorageState> get copyWith =>
      __$$_FirebaseStorageStateCopyWithImpl<_$_FirebaseStorageState>(
          this, _$identity);
}

abstract class _FirebaseStorageState implements FirebaseStorageState {
  const factory _FirebaseStorageState(
      {final AsyncValue<List<FolderModel>> fileList,
      final String folderName}) = _$_FirebaseStorageState;

  @override
  AsyncValue<List<FolderModel>> get fileList;
  @override
  String get folderName;
  @override
  @JsonKey(ignore: true)
  _$$_FirebaseStorageStateCopyWith<_$_FirebaseStorageState> get copyWith =>
      throw _privateConstructorUsedError;
}
