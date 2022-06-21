import 'package:flutter/services.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/admin/Guideline/addGuidelineViewModel.dart';
import 'package:stacked/stacked.dart';

class AddGuidelineView extends StatefulWidget {
  const AddGuidelineView({Key? key}) : super(key: key);
  @override
  State<AddGuidelineView> createState() => _AddGuidelineViewState();
}

class _AddGuidelineViewState extends State<AddGuidelineView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Validation validate = Validation();
  TextEditingController _title = new TextEditingController();
  TextEditingController _content = new TextEditingController();
  TextEditingController _tag = new TextEditingController();
  _AddGuidelineViewState() {
    _tag.text = "#";
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddGuidelineViewModel>.reactive(
        viewModelBuilder: () => AddGuidelineViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Add New Guideline"),
              backgroundColor: logoColor,
            ),
            body: SingleChildScrollView(
                child: Form(
              key: _formkey,
              child: Center(
                child: Column(
                  children: [
                    TextinputForm(
                      "Title",
                      Colors.black,
                      Colors.white,
                      _title,
                      readonly: false,
                      validator: validate.validateForEmpty,
                      inputype: TextInputType.text,
                    ),
                    TextinputForm("Tag", Colors.black, Colors.white, _tag,
                        readonly: false,
                        validator: validate.validateTag,
                        inputype: TextInputType.text),
                    TextinputForm(
                        "Content", Colors.black, Colors.white, _content,
                        readonly: false,
                        minLines: 5,
                        validator: validate.validateForEmpty,
                        inputype: TextInputType.text),
                  ],
                ),
              ),
            )),
            floatingActionButton: SaveButton(
              onPressed: () {
                model.createGuideline(
                    _title.text, _tag.text, _content.text, _formkey);
              },
              icon: Icons.save,
              backgoundColor: logoColor,
            )));
  }
}

class SaveButton extends StatelessWidget {
  void Function()? onPressed;
  IconData? icon;
  Color backgoundColor;
  SaveButton(
      {required this.onPressed,
      required this.icon,
      required this.backgoundColor});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: backgoundColor,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
