import 'package:firebase_storage_multiplex/data_source/firebase_storage_data_source.dart';
import 'package:firebase_storage_multiplex/model/folder_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Riverpod Provider
final firebaseStorageRepository = Provider<FirebaseStorageRepository>(
  (ref) => FirebaseStorageRepository(),
);

class FirebaseStorageRepository {
  final FirebaseStorageDataSource _dataSource = FirebaseStorageDataSource();

  Future<List<FolderModel>> getFolderList({
    required String folderPath,
  }) async {
    return await _dataSource.getFolderList(folderPath);
  }
}
