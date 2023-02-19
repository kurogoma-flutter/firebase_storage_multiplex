import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dialog.dart';
import 'notifier/firebase_storage_notifier.dart';

class FolderCreateButton extends ConsumerWidget {
  const FolderCreateButton({
    super.key,
    required this.currentPath,
    required this.folderName,
  });

  final String currentPath;
  final String folderName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuButton(
      icon: Icons.folder_open_rounded,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            // 背景が透ける角丸ダイアログ
            return BlurAlertDialog(
              title: 'フォルダを作成',
              formContent: 'フォルダ名を入力してください',
              label: '作成',
              onTap: () async {
                await ref
                    .read(firebaseStorageNotifierProvider.notifier)
                    .createFolder(
                      currentPath: currentPath,
                      folderName: folderName,
                    );
              },
            );
          },
        );
      },
    );
  }
}

class FileUploadButton extends ConsumerWidget {
  const FileUploadButton({
    super.key,
    required this.currentPath,
  });

  final String currentPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MenuButton(
      icon: Icons.file_upload_rounded,
      onTap: () {},
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(34),
      onTap: onTap,
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34),
          color: const Color.fromARGB(94, 9, 74, 186),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 3,
          ),
        ),
        child: Icon(
          icon,
          size: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}
