import 'package:helbage/model/IModel.dart';

abstract class pdfServices {
  Future _getStoragePermission();
  Future<bool> toPDF(IModel model);
}
