import 'package:helbage/model/IModel.dart';

abstract class pdfServices
{
Future<bool> toPDF(IModel model);
}