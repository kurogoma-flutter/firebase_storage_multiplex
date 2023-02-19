import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage_multiplex/service/firebase_storage_service.dart';
import 'package:firebase_storage_multiplex/state/firebase_storage_state.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseStorageNotifierProvider = StateNotifierProvider.autoDispose<
    FirebaseStorageNotifier, FirebaseStorageState>(
  (ref) => FirebaseStorageNotifier(
    storageService: ref.read(fireStorageService),
  ),
);

class FirebaseStorageNotifier extends StateNotifier<FirebaseStorageState> {
  FirebaseStorageNotifier({
    required this.storageService,
  }) : super(const FirebaseStorageState());

  final FirebaseStorageService storageService;

  /// フォルダ・ファイル一覧を取得する
  Future<void> getFolderList({
    required String folderPath,
  }) async {
    state = state.copyWith(
      fileList: const AsyncValue.loading(),
    );
    try {
      final folderList = await storageService.getFolderList(
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

      try {
        await storageService.uploadFileToStorage(
          folderPath: folderPath,
          fileName: fileName,
          fileBytes: fileBytes!,
        );
      } catch (error, stack) {
        if (kDebugMode) {
          print(error);
          print(stack);
        }
      }
    }
  }

  /// フォルダを作成
  ///
  /// [folderName] フォルダ名
  ///
  /// [void]を返す
  Future<void> createFolder({
    required String currentPath,
  }) async {
    final folderName = state.folderName;
    if (folderName.isEmpty) {
      return;
    }

    final newFolderName = '$currentPath/$folderName';
    try {
      await storageService.createFolder(
        folderPath: newFolderName,
      );

      state = state.copyWith(
        folderName: '',
      );
    } catch (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
    }
  }

  /// フォルダを削除
  ///
  /// [folderPath] フォルダパス
  ///
  /// [void]を返す
  Future<void> deleteFolder({
    required String folderPath,
  }) async {
    try {
      await storageService.deleteFolder(
        folderPath: folderPath,
      );
    } catch (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
    }
  }

  /// ファイルを削除
  ///
  /// [folderPath] フォルダパス
  ///
  /// [void]を返す
  Future<void> deleteFile({
    required String folderPath,
    required String fileName,
  }) async {
    try {
      await storageService.deleteFile(
        folderPath: folderPath,
        fileName: fileName,
      );
    } catch (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
    }
  }

  /// ファイルをダウンロード
  ///
  /// [folderPath] フォルダパス
  ///
  /// [fileName] ファイル名
  ///
  /// [void]を返す
  Future<void> downloadFile({
    required String folderPath,
    required String fileName,
  }) async {
    try {
      await storageService.downloadFile(
        folderPath: folderPath,
        fileName: fileName,
      );
    } catch (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
    }
  }

  /// フォルダ名の入力を反映する
  void setFolderName(String text) {
    state = state.copyWith(
      folderName: text,
    );
  }
}
