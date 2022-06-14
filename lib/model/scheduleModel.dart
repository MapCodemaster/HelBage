import 'package:helbage/model/_model.dart';
import 'package:helbage/constant/_constant.dart';

class scheduleModel {
  MalaysiaState _s;
  String _pathName;
  String get pathName => _pathName;
  pathModel _p;
  String get state => _s.getString();
  scheduleModel(this._s, this._p, this._pathName) {}
  pathModel getPath() {
    return _p;
  }
}
