import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_multiplex/model/folder_model.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageDataSource {
  final storage = FirebaseStorage.instance.ref();

  /// usersフォルダのフォルダ・ファイル一覧を取得する
  ///
  /// [folderPath] フォルダパス
  ///
  /// List<FolderModel>を返す
  Future<List<FolderModel>> getFolderList(String folderPath) async {
    final folderList = <FolderModel>[];

    final folderRef = storage.child(folderPath);
    final folderListResult = await folderRef.listAll();

    for (final folder in folderListResult.prefixes) {
      final folderModel = FolderModel(
        folderName: folder.name,
        folderId: folder.name,
        folderPath: folder.fullPath,
        folderType: FolderType.folder,
      );
      folderList.add(folderModel);
    }

    for (final file in folderListResult.items) {
      final folderModel = FolderModel(
        folderId: file.name,
        folderName: file.name,
        folderPath: file.fullPath,
        folderType: FolderType.file,
      );
      folderList.add(folderModel);
    }

    return folderList;
  }

  /// Storageにファイルを登録
  Future<void> uploadFileToStorage({
    required String folderPath,
    required String fileName,
    required Uint8List fileBytes,
  }) async {
    final fileRef = storage.child(folderPath).child(fileName);
    await fileRef.putData(fileBytes);
  }

  /// Storageにフォルダを作成
  Future<void> createFolder({
    required String folderPath,
  }) async {
    final folderRef = storage.child(folderPath);
    await folderRef.putData(Uint8List(0));
  }

  /// Storageのファイルを削除
  ///
  /// [folderPath] フォルダパス
  ///
  /// [fileName] ファイル名
  ///
  /// [void]を返す
  Future<void> deleteFile({
    required String folderPath,
    required String fileName,
  }) async {
    final fileRef = storage.child(folderPath).child(fileName);
    await fileRef.delete();
  }

  /// Storageのフォルダを再帰的に削除
  ///
  /// [folderPath] フォルダパス
  ///
  /// [void]を返す
  Future<void> _deleteFolderRecursive({
    required String folderPath,
  }) async {
    final folderRef = storage.child(folderPath);
    final folderListResult = await folderRef.listAll();

    for (final folder in folderListResult.prefixes) {
      await _deleteFolderRecursive(folderPath: folder.fullPath);
    }

    for (final file in folderListResult.items) {
      await file.delete();
    }

    await folderRef.delete();
  }

  /// フォルダの中身をすべて削除
  ///
  /// [folderPath] フォルダパス
  ///
  /// [void]を返す
  Future<void> deleteFolderContents({
    required String folderPath,
  }) async {
    final folderRef = storage.child(folderPath);
    final folderListResult = await folderRef.listAll();

    for (final folder in folderListResult.prefixes) {
      await _deleteFolderRecursive(folderPath: folder.fullPath);
    }

    for (final file in folderListResult.items) {
      await file.delete();
    }
  }

  /// Storageのファイルをダウンロード
  ///
  /// [folderPath] フォルダパス
  ///
  /// [fileName] ファイル名
  ///
  /// [Uint8List]を返す
  ///
  /// ファイルが存在しない場合は空のUint8Listを返す
  Future<Uint8List?> downloadFile({
    required String folderPath,
    required String fileName,
  }) async {
    final fileRef = storage.child(folderPath).child(fileName);
    try {
      final fileBytes = await fileRef.getData();
      return fileBytes;
    } catch (e) {
      return Uint8List(0);
    }
  }
}
