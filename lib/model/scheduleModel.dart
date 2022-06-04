import 'package:helbage/model/constant/State.dart';
import 'package:helbage/model/pathModel.dart';

class scheduleModel
{
  MalaysiaState _state;
  String _pathName;
  String get pathName=>_pathName;
  pathModel _p;
  String get state=>_state.getString();
  scheduleModel(this._state,this._p,this._pathName);
  pathModel getPath()
  {
    return _p;
  }

  
}