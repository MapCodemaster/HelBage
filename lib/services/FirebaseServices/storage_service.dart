import 'package:cloud_firestore/cloud_firestore.dart';

abstract class storage_service {
  Future<bool> insert(String uid, String table, dynamic data);
  Future<bool> update(String uid, String table, dynamic data);
  Future<DocumentSnapshot<Map<String, dynamic>>> read(
      String collection, String document);
  Stream<DocumentSnapshot<Map<String, dynamic>>> readDocumentAsStream(
      String collection, String document);
  Stream<QuerySnapshot<Map<String, dynamic>>> readCollectionAsStream(
      String collection);
  Future<QuerySnapshot<Map<String, dynamic>>> readCollectionAsFuture(
      String collection);
  Future<bool> delete(String collection, String document);
  Future<void> newsSetup(String url);
}
