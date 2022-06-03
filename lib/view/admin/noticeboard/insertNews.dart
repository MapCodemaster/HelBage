import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helbage/shared/buttons.dart';
import 'package:helbage/shared/textInputForm.dart';
import 'package:helbage/shared/color.dart';
import 'package:helbage/shared/validation.dart';
import 'package:helbage/shared/validation.dart';
import 'package:helbage/view/authentication/UserSignUp.dart';
import 'package:helbage/viewmodel/admin/noticeboard/insertNewsModel.dart';
import 'package:stacked/stacked.dart';


class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(text),
        onPressed: onClicked,
      );
}

class EditNewsPage extends StatefulWidget {
  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  @override
  TextEditingController UrlField = TextEditingController();
  Validation validate = Validation();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<insertNewsViewModel>.nonReactive(
        viewModelBuilder: () => insertNewsViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                      elevation: 0,
                      backgroundColor: logoColor,
                      centerTitle: true,
                      title: Text("Insert Url"),
                    ),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 30),
                  TextinputForm(
                    "Url",
                    Colors.black,
                    Colors.white,
                    UrlField,
                    validator: validate.validateForEmpty,
                    inputype: TextInputType.text,
                  ),
                  const SizedBox(height: 25),
                  Center(
                      child: txtButton("Insert", () async {
                    setState(() {
                      _loading = true;
                    });
                    bool check =
                        await model.insertNews(UrlField).whenComplete(() {
                      setState(() {
                        _loading = false;
                      });
                    });
                    if (check) {
                      model.NavigateToNews();
                    }
                  },
                          primaryColor,
                          120,
                          20,
                          TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          radius: 50)),
                ],
              ),
            ));
  }

}
