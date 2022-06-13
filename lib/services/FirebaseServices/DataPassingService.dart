import 'package:helbage/model/collectionPointModel.dart';
import 'package:helbage/model/newsModel.dart';

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
