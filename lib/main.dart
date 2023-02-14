import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage_multiplex/firebase_options.dart';
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
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    data[index].folderName,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    notifier.getFolderList(
                      folderPath: data[index].folderPath,
                    );
                  },
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
