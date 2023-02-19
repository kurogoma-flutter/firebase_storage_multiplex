import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dialog.dart';

class FolderCreateButton extends StatelessWidget {
  const FolderCreateButton({
    super.key,
    required this.currentPath,
    required this.onTap,
    required this.onChanged,
  });

  final String currentPath;
  final Future<void> Function() onTap;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
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
              onTap: onTap,
              onChanged: (text) {
                onChanged;
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
