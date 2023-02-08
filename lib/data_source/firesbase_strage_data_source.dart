import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_multiplex/model/folder_model.dart';

class CloudFirestoreDataSource {
  final storage = FirebaseStorage.instance.ref();

  /// フォルダ・ファイル一覧を取得する
  ///
  /// [folderPath] フォルダパス
  ///
  /// List<FolderModel>を返す
  Future<List<FolderModel>> getFolderList(String folderPath) async {
    final folderList = <FolderModel>[];
    final folderRef = storage.child(folderPath);
    final folderSnapshot = await folderRef.listAll();
    final folderListSnapshot = await folderSnapshot.items[0].listAll();
    final fileListSnapshot = await folderSnapshot.items[1].listAll();

    for (var folder in folderListSnapshot.items) {
      folderList.add(
        FolderModel(
          folderId: folder.name,
          folderName: folder.name,
          folderPath: folder.fullPath,
          folderType: FolderType.folder,
        ),
      );
    }

    for (var file in fileListSnapshot.items) {
      folderList.add(
        FolderModel(
          folderId: file.name,
          folderName: file.name,
          folderPath: file.fullPath,
          folderType: FolderType.file,
        ),
      );
    }

    return folderList;
  }
}
