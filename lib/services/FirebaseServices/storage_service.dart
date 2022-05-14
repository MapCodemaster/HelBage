abstract class storage_service {
  Future<bool> insert(String uid, String table, dynamic data);
  Future<bool> update(String uid, String table, String field, dynamic data);
}
