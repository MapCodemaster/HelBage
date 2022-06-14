import 'package:helbage/model/_model.dart';

class DataPassingService {
  dynamic object;
  void assignToPointModel(CollectionPointModel x) {
    object = x;
  }

  passObject() {
    return object;
  }

  void assignToNewsModel(NewsModel x) {
    object = x;
  }

  passAsNewsModel() {
    return object;
  }
}
