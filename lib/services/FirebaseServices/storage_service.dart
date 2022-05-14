import 'package:cloud_firestore/cloud_firestore.dart';

abstract class storage_service {
  Future<bool> insert(String uid, String table, dynamic data);
  Future<bool> update(String uid, String table, String field, dynamic data);
  Future<DocumentSnapshot> read(String collection, String document);
}
