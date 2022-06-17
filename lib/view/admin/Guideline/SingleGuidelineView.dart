import 'package:flutter/material.dart';
import 'package:helbage/model/guideLineModel.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/SingleGuidelineViewModel.dart';
import 'package:stacked/stacked.dart';

class SingleGuidelineView extends StatefulWidget {
  guidelineModel guideline;
  SingleGuidelineView({Key? key,required this.guideline}) : super(key: key);

  @override
  State<SingleGuidelineView> createState() => _SingleGuidelineViewState();
}

class _SingleGuidelineViewState extends State<SingleGuidelineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleGuidelineViewModel>.reactive(
      viewModelBuilder: ()=>SingleGuidelineViewModel(
        workingGuideline: widget.guideline,
      ),
      builder: (context,model,child)=>Scaffold(
         appBar: AppBar(
          title: Text(widget.guideline.author+": "+widget.guideline.title),
          actions: [
            model.editable?IconButton(onPressed: (){model.edit(widget.guideline);}, icon: Icon(Icons.edit)):Container(),
            model.editable?IconButton(onPressed: (){model.delete(widget.guideline);}, icon: Icon(Icons.delete)):Container()
          ],
          backgroundColor: logoColor,
          ),
          body: SingleChildScrollView(
            
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //title
              GuidelineWidget(10.0,widget.guideline.title,FontWeight.bold,20.0),
              GuidelineWidget(10.0,listToSingleString(widget.guideline.tag),FontWeight.bold,15.0,logoColor),
              GuidelineWidget(10.0,"Author : " +widget.guideline.author,FontWeight.normal,15.0),
              Container(
              width:MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Text(widget.guideline.content,
              textAlign:TextAlign.justify,
                  style: TextStyle(
                      
                      fontWeight: FontWeight.normal, 
                      fontSize: 15,))),
              Container(child: Center(child: Text("END OF CONTENT")),)        
              
                    ],)
          
          ),
      ));
    
  }
}

Container GuidelineWidget(padding,text,[fontweight=FontWeight.normal,fontsize=15,color=Colors.black])
{
  return Container(
      padding:EdgeInsets.fromLTRB(padding, 5, padding, 5.0),
      child: Text(text,
          style: TextStyle(fontWeight: fontweight, fontSize: fontsize,color: color)));
}
String listToSingleString(list)
{
  String tempString="";
  list.forEach((element){
    tempString=tempString+"#"+element.toString()+" ";
  });
  return tempString;
}