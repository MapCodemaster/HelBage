import 'package:helbage/model/guidelineRequestModel.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/processPendingGuidelineViewModel.dart';
import 'package:stacked/stacked.dart';

class processPendingGuidelineView extends StatefulWidget {
  guidelineRequestModel request;
  processPendingGuidelineView({Key? key,required this.request}) : super(key: key);

  @override
  State<processPendingGuidelineView> createState() => _processPendingGuidelineViewState();
}

class _processPendingGuidelineViewState extends State<processPendingGuidelineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<processPendingGuidelineiViewModel>.reactive(
      viewModelBuilder: ()=>processPendingGuidelineiViewModel(workingRequest:widget.request),
      builder: (context,model,child)=>Scaffold(
        appBar: AppBar(backgroundColor: logoColor),
        body: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GuidelineWidget(
                      10.0, widget.request.title, FontWeight.bold, 20.0),
                    TextButton(onPressed: (){model.approve();}, child: Container(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                      child:Text("Approve",
                      style: TextStyle(color:Colors.black),),
                      decoration: BoxDecoration(border: Border.all(width: 1),borderRadius: BorderRadius.circular(25),color: Colors.green[200]),)),
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GuidelineWidget(10.0, "Author : " + widget.request.author,
                      FontWeight.normal, 15.0),
                    TextButton(
                      onPressed: (){model.reject();}, 
                      child:Container(
                        
                        padding: EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
                        child:Text("Reject",
                          style: TextStyle(color:Colors.black),
                          ),
                          decoration: BoxDecoration(border: Border.all(width: 1),borderRadius: BorderRadius.circular(25),color: Colors.red[200]),
                          )
                          ),
                  ],),
                  
                  GuidelineWidget(
                      10.0,
                      listToSingleString(widget.request.tag),
                      FontWeight.bold,
                      15.0,
                      logoColor),
                  
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Text(widget.request.content,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ))),
                  Container(
                    child: Center(child: Text("END OF CONTENT")),
                  )
                ],
              )),
      )
      );
    
  }
}
Container GuidelineWidget(padding, text,
    [fontweight = FontWeight.normal, fontsize = 15, color = Colors.black]) {
  return Container(
      padding: EdgeInsets.fromLTRB(padding, 5, padding, 5.0),
      child: Text(text,
          style: TextStyle(
              fontWeight: fontweight, fontSize: fontsize, color: color)));
}

String listToSingleString(list) {
  String tempString = "";
  list.forEach((element) {
    tempString = tempString + "#" + element.toString() + " ";
  });
  return tempString;
}