import 'package:firebase_storage_multiplex/model/folder_model.dart';
import 'package:firebase_storage_multiplex/repository/firebase_storage_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fireStorageService = Provider.autoDispose(
  (ref) => FirebaseStorageService(
    repository: ref.read(firebaseStorageRepository),
  ),
);

class FirebaseStorageService {
  FirebaseStorageService({
    required this.repository,
  });

  final FirebaseStorageRepository repository;

  /// フォルダ・ファイル一覧を取得する
  ///
  /// [folderPath] フォルダパス
  ///
  /// List<FolderModel>を返す
  Future<List<FolderModel>> getFolderList({
    required String folderPath,
  }) async {
    return await repository.getFolderList(folderPath: folderPath);
  }
}
