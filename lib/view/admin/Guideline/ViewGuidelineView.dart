import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/ViewGuidelineViewModel.dart';
import 'package:stacked/stacked.dart';
class ViewGuidelineView extends StatefulWidget {
  const ViewGuidelineView({Key? key}) : super(key: key);

  @override
  State<ViewGuidelineView> createState() => _ViewGuidelineViewState();
}

class _ViewGuidelineViewState extends State<ViewGuidelineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewGuidelineViewModel>.reactive(
      viewModelBuilder: ()=>ViewGuidelineViewModel(), 
      builder: (context,model,child)=>Scaffold(
        appBar: AppBar(
          title:Text("Guidelines"),
          actions: [
            IconButton(
            onPressed: () 
            {
            model.addGuideline();
            },
            icon: Icon(Icons.add)),
            PopupMenuButton(itemBuilder: (BuildContext context) {
                return getGuidelinetag(model.tagList);},
                onSelected: (vale){model.getGuideline(vale);},)
                ],
          ),
        body:Container(
          
        )
      ));
    
  }
}

List<PopupMenuItem> getGuidelinetag(tag,{size=15.0})
{
  
  List<PopupMenuItem> tagMenu=new List.empty(growable: true);
  tag.forEach((element) {
    tagMenu.add(
      PopupMenuItem(
        child: InkWell(
          child:Text(
            element.toString(),
            style:TextStyle(fontSize: size)
            )
            ),
        value:element),
        );
  });
  return tagMenu;
}