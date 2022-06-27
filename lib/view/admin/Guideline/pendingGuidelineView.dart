// ignore_for_file: camel_case_types

import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/pendingGuidelineViewModel.dart';
import 'package:stacked/stacked.dart';


class pendingGuidelineView extends StatefulWidget {
  const pendingGuidelineView({Key? key}) : super(key: key);

  @override
  State<pendingGuidelineView> createState() => _pendingGuidelineViewState();
}

class _pendingGuidelineViewState extends State<pendingGuidelineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<pendingGuidelineViewModel>.reactive(
      viewModelBuilder: ()=>pendingGuidelineViewModel(), 
      builder:(context,model,child)=>Scaffold(
        appBar: AppBar(backgroundColor: logoColor),
        body:buildList(model)

      ));
    
  }
}

Widget buildList(model)
{
  if(model.requestList.length==0)
  {
    return ListView(
      children: [
        Center(child:
        Container(
          padding:EdgeInsets.only(top:20),
          child: Text("No guideline post request"),)),
          ],
          );
  }
  List<Widget> cardList=List.empty(growable: true);
  model.requestList.forEach(
    (element) {
      
      cardList.add(
        Card(
          
          child:Container(
            padding: EdgeInsets.only(top:10.0,bottom: 10.0),
            child: ListTile(
            
            leading:Icon(Icons.article_sharp,color:Colors.deepPurpleAccent,size: 40,),
            title:Text("Title:  "+ element.title,textScaleFactor: 1.3,),
            subtitle: Text("Author:  "+element.author+"\nContent:  "+element.content,overflow: TextOverflow.ellipsis,textScaleFactor: 1.3,),
            trailing: IconButton(
              icon:Icon(Icons.more_vert,size: 40,),
              onPressed: (){model.navigateToProcess(element);},),
            
          )
        )
      ));

    }
  );
  
  return ListView(
    children: cardList
  );
}