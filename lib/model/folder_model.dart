enum FolderType {
  folder,
  file,
}

/// フォルダ一覧を表示するモデル
class FolderModel {
  FolderModel({
    required this.folderId,
    required this.folderName,
    required this.folderPath,
    required this.folderType,
  });

  /// フォルダID
  final String folderId;

  /// フォルダ名
  final String folderName;

  /// フォルダパス
  final String folderPath;

  /// フォルダタイプ
  final FolderType folderType;
}
