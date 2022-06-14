import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:helbage/services/FirebaseServices/FileStorage.dart';

class FirebaseFileStorage implements FileStorage {
  Future uploadToStorage(File? file) async {
    final fileName = file!.path.split('/').last;
    final destination = 'image/$fileName';
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      var snapshot = await ref.putFile(file);
      final urlDownload = snapshot.ref.getDownloadURL().whenComplete(() {});
      return urlDownload;
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<void> deleteFromStorage(String url) async {
    await FirebaseStorage.instance.refFromURL(url).delete();
  }
}
