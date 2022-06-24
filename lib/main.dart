import 'package:flutter/material.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/view/home/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  setupLocator();
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelDescription: 'Notification channel for basic tests',
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
  );
  AwesomeNotifications().actionStream.listen((event) {
    String? state = event.title!
        .substring(event.title!.indexOf(":") + 2, event.title!.length - 1);
    String? location = event.title!.substring(0, event.title!.indexOf("(") - 1);
  });

  runApp(MaterialApp(
    title: 'Helbage',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    navigatorKey: StackedService.navigatorKey,
    onGenerateRoute: StackedRouter().onGenerateRoute,
  ));
}
