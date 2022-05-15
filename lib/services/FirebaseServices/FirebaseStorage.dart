import 'package:helbage/model/userModel.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStor implements storage_service {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<bool> insert(String uid, String table, dynamic data) async {
    try {
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

  Future<bool> update(String uid, String table, dynamic data) async {
    try {
      db
          .collection(table)
          .doc(uid)
          .update(data)
          .onError((error, stackTrace) => {throw Exception()});
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> read(
      String collection, String document) async {
    return db.collection(collection).doc(document).get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> readDocumentAsStream(
      String collection, String document) {
    return db.collection(collection).doc(document).snapshots();
  }
}
