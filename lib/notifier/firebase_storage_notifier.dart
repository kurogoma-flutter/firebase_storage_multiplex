import 'package:firebase_storage_multiplex/service/firebase_storage_service.dart';
import 'package:firebase_storage_multiplex/state/firebase_storage_state.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirebaseStorageNotifier extends StateNotifier<FirebaseStorageState> {
  FirebaseStorageNotifier({
    required this.firebaseStorageService,
  }) : super(const FirebaseStorageState());

  final FirebaseStorageService firebaseStorageService;

  Future<void> getFolderList({
    required String folderPath,
  }) async {
    state = state.copyWith(
      fileList: const AsyncValue.loading(),
    );
    try {
      final folderList = await firebaseStorageService.getFolderList(
        folderPath: folderPath,
      );
      state = state.copyWith(
        fileList: AsyncValue.data(folderList),
      );
    } catch (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
      state = state.copyWith(
        fileList: const AsyncValue.data([]),
      );
    }
  }
}
