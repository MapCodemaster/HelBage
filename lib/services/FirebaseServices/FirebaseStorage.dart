import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStor implements storage_service {
  @override
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<bool> insert(String uid, String table, dynamic data) async {
    try {
      print(uid);
      print(table);
      print(data);
      db
          .collection(table)
          .doc(uid)
          .set(data)
          .onError((error, stackTrace) => {throw Exception()});
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> update(
      String uid, String table, String field, dynamic data) async {
    try {
      db.collection(table).doc(uid).update({'${field}': data}).onError(
          (error, stackTrace) => {throw Exception()});
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<DocumentSnapshot> read(String collection, String document) async {
    return db.collection(collection).doc(document).get();
  }
}
