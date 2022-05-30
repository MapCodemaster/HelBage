import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:helbage/app/route.locator.dart';
import 'package:helbage/app/route.router.dart';
import 'package:helbage/view/Schedule/CreateSchedule.dart';
import 'package:helbage/view/authentication/UserLogin.dart';
import 'package:helbage/view/home/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  setupLocator();
  runApp(MaterialApp(
    title: 'Helbage',
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    navigatorKey: StackedService.navigatorKey,
    onGenerateRoute: StackedRouter().onGenerateRoute,
  ));
}
