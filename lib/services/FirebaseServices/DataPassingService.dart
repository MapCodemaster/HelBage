import 'package:helbage/model/newsModel.dart';

class DataPassingService {
  dynamic object;
  void assignToNewsModel(NewsModel x) {
    object = x;
  }

  passAsNewsModel() {
    return object;
  }
}
