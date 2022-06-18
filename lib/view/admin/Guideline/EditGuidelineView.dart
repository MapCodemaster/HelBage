import 'package:flutter/material.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/EditGuidelineViewModel.dart';
import 'package:stacked/stacked.dart';
class EditGuidelineView extends StatefulWidget {
  guidelineModel guideline;
  EditGuidelineView({Key? key,required this.guideline}) : super(key: key);

  @override
  State<EditGuidelineView> createState() => _EditGuidelineViewState(guideline);
}

class _EditGuidelineViewState extends State<EditGuidelineView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Validation validate = Validation();
  TextEditingController _title=new TextEditingController();
  TextEditingController _content=new TextEditingController();
  TextEditingController _tag=new TextEditingController();
  _EditGuidelineViewState(guidelineModel guideline)
  {
    _title.text=guideline.title;
    _content.text=guideline.content;
    _tag.text=listToSingleString(guideline.tag);
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditGuidelineViewModel>.reactive(
      viewModelBuilder: ()=>EditGuidelineViewModel() ,
      builder: (context,model,child)=>Scaffold(
        appBar: AppBar(
          title: Text("Add New Guideline"),
          backgroundColor: logoColor,
          ),
        body:SingleChildScrollView(
          child:Form(
            key: _formkey,
            child: Center(
              child:Column(
            children: [
            TextinputForm("Title", Colors.black, Colors.white, _title, readonly: false,validator: validate.validateForEmpty,inputype: TextInputType.text,),
            TextinputForm("Tag", Colors.black, Colors.white, _tag, readonly: false,validator:validate.validateTag,inputype:TextInputType.text),
            TextinputForm("Content", Colors.black, Colors.white, _content, readonly: false,minLines: 5,validator: validate.validateForEmpty,inputype:TextInputType.text), 
          ],)
          ,),)
          
          

        ),
        
      floatingActionButton: SaveButton(
        onPressed: (){model.update(_title.text,_tag.text,_content.text,_formkey,widget.guideline);model.toSingleView();},
        icon: Icons.save,
        backgoundColor: logoColor,
        )
      ));
  }
}
class SaveButton extends StatelessWidget
{
  void Function()? onPressed;
  IconData? icon;
  Color backgoundColor;
  SaveButton({required this.onPressed,required this.icon,required this.backgoundColor});
  @override
  Widget build(BuildContext context)
  {
    return FloatingActionButton(
      backgroundColor: backgoundColor,
      onPressed: onPressed,
      child:Icon(icon),
     
    
      );
  }
}
String listToSingleString(list)
{
  String tempString="";
  list.forEach((element){
    tempString=tempString+"#"+element.toString()+"";
  });
  return tempString;
}