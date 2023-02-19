import 'package:firebase_storage_multiplex/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'button.dart';
import 'model/folder_model.dart';
import 'notifier/firebase_storage_notifier.dart';

///
/// 下の階層のフォルダーを表示するページ
///
/// [folderPath] フォルダーのパス
///
class FolderDetailPage extends ConsumerStatefulWidget {
  const FolderDetailPage({
    super.key,
    required this.folderPath,
  });

  final String folderPath;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FolderDetailPageState();
}

class _FolderDetailPageState extends ConsumerState<FolderDetailPage>
    with RouteAware {
  @override
  void initState() {
    // Unhandled Exception: Tried to modify a provider while the widget tree was building.
    // 上記エラーを回避するためにWidgetsBinding.instance.addPostFrameCallbackを使用
    WidgetsBinding.instance.addPostFrameCallback((_) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
      Future(() async {
        if (kDebugMode) {
          print('folderPath: ${widget.folderPath}');
        }
        await ref.read(firebaseStorageNotifierProvider.notifier).getFolderList(
              folderPath: widget.folderPath,
            );
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    Future(() async {
      if (kDebugMode) {
        print('folderPath: ${widget.folderPath}');
      }
      await ref.read(firebaseStorageNotifierProvider.notifier).getFolderList(
            folderPath: widget.folderPath,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(firebaseStorageNotifierProvider);
    final notifier = ref.watch(firebaseStorageNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        title: const Text(
          'Firestore Multiplex',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Stack(
        children: [
          state.fileList.when(
            data: (data) {
              return ListView.builder(
                itemCount: data.length,
                padding: const EdgeInsets.only(top: 8),
                itemBuilder: (context, index) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Data'),
                    );
                  }
                  final item = data[index];
                  return item.folderType == FolderType.folder
                      ? Card(
                          child: ListTile(
                            leading: const Icon(Icons.folder),
                            title: Text(
                              item.folderName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FolderDetailPage(
                                  folderPath: item.folderPath,
                                ),
                              ),
                            ),
                          ),
                        )
                      : ListTile(
                          leading: const Icon(
                            Icons.file_copy,
                            color: Colors.white,
                          ),
                          title: Text(
                            item.folderName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                },
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, stack) {
              return const Center(
                child: Text('error'),
              );
            },
          ),
          Positioned(
            bottom: 28,
            right: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FolderCreateButton(
                  currentPath: widget.folderPath,
                  onTap: () async {
                    notifier.createFolder(
                      currentPath: widget.folderPath,
                    );
                  },
                  onChanged: (text) {
                    notifier.setFolderName(text);
                  },
                ),
                const SizedBox(height: 12),
                FileUploadButton(
                  currentPath: widget.folderPath,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
