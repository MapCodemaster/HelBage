import 'package:cloud_firestore/cloud_firestore.dart';

abstract class storage_service {
  Future<bool> insert(String uid, String table, dynamic data);
  Future<bool> update(String uid, String table, dynamic data);
  Future<DocumentSnapshot<Map<String, dynamic>>> read(
      String collection, String document);
  Stream<DocumentSnapshot<Map<String, dynamic>>> readDocumentAsStream(
      String collection, String document);
}
