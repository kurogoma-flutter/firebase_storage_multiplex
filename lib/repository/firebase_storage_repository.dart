import 'package:firebase_storage_multiplex/data_source/firebase_storage_data_source.dart';
import 'package:firebase_storage_multiplex/model/folder_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Riverpod Provider
final firebaseStorageRepository = Provider<FirebaseStorageRepository>(
  (ref) => FirebaseStorageRepository(),
);

class FirebaseStorageRepository {
  final FirebaseStorageDataSource _dataSource = FirebaseStorageDataSource();

  /// フォルダ・ファイル一覧を取得する
  Future<List<FolderModel>> getFolderList({
    required String folderPath,
  }) async {
    return await _dataSource.getFolderList(folderPath);
  }

  /// Storageにファイルを登録
  Future<void> uploadFileToStorage({
    required String folderPath,
    required String fileName,
    required Uint8List fileBytes,
  }) async {
    return await _dataSource.uploadFileToStorage(
      folderPath: folderPath,
      fileName: fileName,
      fileBytes: fileBytes,
    );
  }

  /// Storageにフォルダを作成
  Future<void> createFolder({
    required String folderPath,
  }) async {
    return await _dataSource.createFolder(folderPath: folderPath);
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
    return await _dataSource.deleteFile(
      folderPath: folderPath,
      fileName: fileName,
    );
  }

  /// Storageのフォルダを削除
  ///
  /// [folderPath] フォルダパス
  ///
  /// [void]を返す
  Future<void> deleteFolderContents({
    required String folderPath,
  }) async {
    return await _dataSource.deleteFolderContents(folderPath: folderPath);
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
  ///
  Future<Uint8List?> downloadFile({
    required String folderPath,
    required String fileName,
  }) async {
    return await _dataSource.downloadFile(
      folderPath: folderPath,
      fileName: fileName,
    );
  }
}
