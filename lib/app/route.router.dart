// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import '../view/authentication/UserSignUp.dart';
import '../view/authentication/ForgetPassword.dart';
import '../view/authentication/UserLogin.dart';
import '../view/authentication/UserRegister.dart';
import '../view/home/HomeScreen.dart';
import '../view/main/AdminMainScreen.dart';
import '../view/main/ResidentMainScreen.dart';

class Routes {
  static const String homeScreen = '/';
  static const String userLogin = '/user-login';
  static const String userRegister = '/user-sign-up';
  static const String residentMainScreen = '/resident-main-screen';
  static const String adminMainScreen = '/admin-main-screen';
  static const String forgetPassword = '/forget-password';
  static const all = <String>{
    homeScreen,
    userLogin,
    userRegister,
    residentMainScreen,
    adminMainScreen,
    forgetPassword,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.userLogin, page: UserLogin),
    RouteDef(Routes.userRegister, page: UserSignUp),
    RouteDef(Routes.residentMainScreen, page: ResidentMainScreen),
    RouteDef(Routes.adminMainScreen, page: AdminMainScreen),
    RouteDef(Routes.forgetPassword, page: ForgetPassword),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeScreen(),
        settings: data,
      );
    },
    UserLogin: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UserLogin(),
        settings: data,
      );
    },
    UserSignUp: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UserSignUp(),
        settings: data,
      );
    },
    ResidentMainScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ResidentMainScreen(),
        settings: data,
      );
    },
    AdminMainScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AdminMainScreen(),
        settings: data,
      );
    },
    ForgetPassword: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ForgetPassword(),
        settings: data,
      );
    },
  };
}
