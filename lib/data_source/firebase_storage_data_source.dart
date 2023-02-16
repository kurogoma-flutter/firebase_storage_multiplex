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
}
