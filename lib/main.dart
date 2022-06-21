import 'package:flutter/material.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/view/home/homeScreen.dart';
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
