import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage_multiplex/service/firebase_storage_service.dart';
import 'package:firebase_storage_multiplex/state/firebase_storage_state.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseStorageNotifierProvider = StateNotifierProvider.autoDispose<
    FirebaseStorageNotifier, FirebaseStorageState>(
  (ref) => FirebaseStorageNotifier(
    firebaseStorageService: ref.read(fireStorageService),
  ),
);

class FirebaseStorageNotifier extends StateNotifier<FirebaseStorageState> {
  FirebaseStorageNotifier({
    required this.firebaseStorageService,
  }) : super(const FirebaseStorageState());

  final FirebaseStorageService firebaseStorageService;

  /// フォルダ・ファイル一覧を取得する
  Future<void> getFolderList({
    required String folderPath,
  }) async {
    state = state.copyWith(
      fileList: const AsyncValue.loading(),
    );
    try {
      final folderList = await firebaseStorageService.getFolderList(
        folderPath: folderPath,
      );
      state = state.copyWith(
        fileList: AsyncValue.data(folderList),
      );
    } catch (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
      state = state.copyWith(
        fileList: AsyncValue.error(error, stack),
      );
    }
  }

  /// ファイルを作成
  Future<void> createFile({
    required String folderPath,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      final file = result.files.single;
      final fileName = file.name;
      final filePath = file.path;
      final fileBytes = file.bytes;
      final fileExtension = file.extension;
      final fileSize = file.size;

      if (kDebugMode) {
        print('fileName: $fileName');
        print('filePath: $filePath');
        print('fileBytes: $fileBytes');
        print('fileExtension: $fileExtension');
        print('fileSize: $fileSize');
      }
    }
  }
}
