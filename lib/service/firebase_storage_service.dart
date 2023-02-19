import 'package:firebase_storage_multiplex/model/folder_model.dart';
import 'package:firebase_storage_multiplex/repository/firebase_storage_repository.dart';
import 'package:flutter/foundation.dart';
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
  /// [List]<[FolderModel]>を返す
  Future<List<FolderModel>> getFolderList({
    required String folderPath,
  }) async {
    return await repository.getFolderList(folderPath: folderPath);
  }

  /// Storageにファイルを登録
  ///
  /// [folderPath] フォルダパス
  ///
  /// [fileName] ファイル名
  ///
  /// [fileBytes] ファイルのバイトデータ
  ///
  /// [void]を返す
  Future<void> uploadFileToStorage({
    required String folderPath,
    required String fileName,
    required Uint8List fileBytes,
  }) async {
    return await repository.uploadFileToStorage(
      folderPath: folderPath,
      fileName: fileName,
      fileBytes: fileBytes,
    );
  }

  /// Storageにフォルダを作成
  ///
  /// [folderPath] フォルダパス
  ///
  /// [void]を返す
  Future<void> createFolder({
    required String folderPath,
  }) async {
    return await repository.createFolder(folderPath: folderPath);
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
    return await repository.deleteFile(
      folderPath: folderPath,
      fileName: fileName,
    );
  }

  /// Storageのフォルダを削除
  ///
  /// [folderPath] フォルダパス
  ///
  /// [void]を返す
  Future<void> deleteFolder({
    required String folderPath,
  }) async {
    return await repository.deleteFolderContents(folderPath: folderPath);
  }

  /// Storageのファイルをダウンロード
  ///
  /// [folderPath] フォルダパス
  ///
  /// [fileName] ファイル名
  ///
  /// [Uint8List]を返す
  Future<Uint8List?> downloadFile({
    required String folderPath,
    required String fileName,
  }) async {
    return await repository.downloadFile(
      folderPath: folderPath,
      fileName: fileName,
    );
  }
}
