import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:helbage/view/home/_home.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    initialization();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => NotificationPermissionDialog(context),
          );
        }
      },
    );
  }

  AlertDialog NotificationPermissionDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Allow Notifications'),
      content: Text('Our app would like to send you notifications'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Don\'t Allow',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () => AwesomeNotifications()
              .requestPermissionToSendNotifications()
              .then((_) => Navigator.pop(context)),
          child: Text(
            'Allow',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 4));

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    var viewModelBuilder2 = ViewModelBuilder<HomeScreenViewModel>.nonReactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/cover.png',
                        width: 250, height: 250),
                    Container(
                      width: 200,
                      margin: EdgeInsets.only(bottom: 0),
                      child: froyoFlatBtn('Sign In', () {
                        model.NavigateToLogin();
                      }),
                    ),
                    Container(
                      width: 200,
                      padding: EdgeInsets.all(0),
                      child: froyoOutlineBtn('Sign Up', () {
                        model.NavigateToRegister();
                      }),
                    ),
                  ],
                ),
              ),
              backgroundColor: bgColor,
            ));
    return viewModelBuilder2;
  }
}
