import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:helbage/view/admin/Schedule/ViewScheduleViewModel.dart';
class ViewScheduleBody extends StatefulWidget
{
  const ViewScheduleBody({Key? key}):super(key: key);
  @override
  State<ViewScheduleBody> createState()=>_ViewScheduleBody();
}
class _ViewScheduleBody extends State<ViewScheduleBody>
{
  @override
  Widget build(BuildContext context) {
  return ViewModelBuilder<viewScheduleViewModel>.reactive(
  viewModelBuilder: ()=>viewScheduleViewModel(), 
  builder: (context,model,child)=>SingleChildScrollView());
  }
}