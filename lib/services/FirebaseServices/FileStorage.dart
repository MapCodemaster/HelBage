import 'dart:io';

import 'package:helbage/services/FirebaseServices/storage_service.dart';

abstract class FileStorage {
  Future uploadToStorage(File? file);
  Future<void> deleteFromStorage(String url);
}
