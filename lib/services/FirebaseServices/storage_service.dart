import 'package:cloud_firestore/cloud_firestore.dart';

abstract class storage_service {
  Future<bool> insert(String uid, String table, dynamic data);
  Future<bool> add(String table, dynamic data);
  Future<bool> update(String docid, String table, dynamic data);
  Future<bool> delete(String docid, String table);
  Future<bool> updateSingleField(
      String collection, String document, String field, dynamic data);
  Future<DocumentSnapshot<Map<String, dynamic>>> read(
      String collection, String document);
  Stream<DocumentSnapshot<Map<String, dynamic>>> readDocumentAsStream(
      String collection, String document);
  Stream<QuerySnapshot<Map<String, dynamic>>> readCollectionAsStream(
      String collection);
  Future<QuerySnapshot<Map<String, dynamic>>> readCollectionAsFuture(
      String collection);
  Stream<QuerySnapshot<Map<String, dynamic>>>
      readCollectionAsStreamArrayCondition(
          String collection, String field, String item);
  Future<void> insertLevel2(
      {required collection,
      required document,
      required subCollection,
      required subColDoc,
      required data});
  Future<void> newsSetup(String url);
  String getCreatedDocumentID(String collection);
}
