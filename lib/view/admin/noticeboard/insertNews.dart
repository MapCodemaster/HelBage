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

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.text,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            maxLines: widget.maxLines,
          ),
        ],
      );
}

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
              appBar: buildAppBar(context),
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                physics: const BouncingScrollPhysics(),
                children: [
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

  AppBar buildAppBar(BuildContext context) {
    const icon = CupertinoIcons.moon_stars;

    return AppBar(
      leading: const BackButton(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(icon),
          onPressed: () {},
        )
      ],
    );
  }
}
