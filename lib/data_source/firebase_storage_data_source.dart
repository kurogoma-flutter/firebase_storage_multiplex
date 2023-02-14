import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_multiplex/model/folder_model.dart';

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
}
