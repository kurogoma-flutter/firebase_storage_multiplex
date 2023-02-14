import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage_multiplex/firebase_options.dart';
import 'package:firebase_storage_multiplex/model/folder_model.dart';
import 'package:firebase_storage_multiplex/notifier/firebase_storage_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Multiplex',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Unhandled Exception: Tried to modify a provider while the widget tree was building.
    // 上記エラーを回避するためにWidgetsBinding.instance.addPostFrameCallbackを使用
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(() async {
        await ref.read(firebaseStorageNotifierProvider.notifier).getFolderList(
              folderPath: 'users/',
            );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(firebaseStorageNotifierProvider.notifier);
    final state = ref.watch(firebaseStorageNotifierProvider);

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
        body: state.fileList.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.only(top: 8),
              itemBuilder: (context, index) {
                final item = data[index];
                return InkWell(
                  onTap: () {},
                  child: item.folderType == FolderType.folder
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
                            onTap: () async {
                              await notifier.getFolderList(
                                folderPath: item.folderPath,
                              );
                            },
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
        ));
  }
}
