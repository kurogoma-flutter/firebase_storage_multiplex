import 'dart:ui';

import 'package:flutter/material.dart';

/// 背景透過させるダイアログ
///
/// [title] タイトル
///
/// [formContent] フォームの内容
///
/// [label] ボタンのラベル
///
/// [onTap] ボタンを押した時の処理
class BlurAlertDialog extends StatelessWidget {
  const BlurAlertDialog({
    super.key,
    required this.title,
    required this.formContent,
    required this.label,
    required this.onTap,
    required this.onChanged,
  });

  final String title;
  final String formContent;
  final String label;
  final Function() onTap;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(title),
        content: TextFormField(
          onChanged: onChanged,
          keyboardType: TextInputType.text,
          maxLines: 1,
          maxLength: 40,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: formContent,
            labelStyle: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'キャンセル',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onTap;
            },
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
