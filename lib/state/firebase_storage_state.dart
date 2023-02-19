import 'package:firebase_storage_multiplex/model/folder_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'firebase_storage_state.freezed.dart';

@freezed
class FirebaseStorageState with _$FirebaseStorageState {
  const factory FirebaseStorageState({
    @Default(AsyncValue.loading()) AsyncValue<List<FolderModel>> fileList,
    @Default('') String folderName,
  }) = _FirebaseStorageState;
}
