// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:helbage/model/pathModel.dart';
import 'package:helbage/model/scheduleModel.dart';
import 'package:helbage/view/admin/Schedule/CreateSchedule.dart';
import 'package:helbage/view/admin/Schedule/EditScheduleView.dart';
import 'package:helbage/view/admin/Schedule/SingleScheduleView.dart';
import 'package:helbage/view/admin/Schedule/ViewSchedule.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../view/authentication/ForgetPassword.dart';
import '../view/authentication/UserLogin.dart';
import '../view/authentication/UserSignUp.dart';
import '../view/home/HomeScreen.dart';
import '../view/main/AdminMainScreen.dart';
import '../view/main/ResidentMainScreen.dart';

class Routes {
  static const String homeScreen = '/';
  static const String userLogin = '/user-login';
  static const String residentMainScreen = '/resident-main-screen';
  static const String adminMainScreen = '/admin-main-screen';
  static const String forgetPassword = '/forget-password';
  static const String userSignUp = '/user-sign-up';
  static const String createSchedule = '/create-schedule';
  static const String singleScheduleView = '/single-schedule-view';
  static const String viewSchedule = '/view-schedule';
  static const String editScheduleView = '/edit-schedule-view';
  static const all = <String>{
    homeScreen,
    userLogin,
    residentMainScreen,
    adminMainScreen,
    forgetPassword,
    userSignUp,
    createSchedule,
    singleScheduleView,
    viewSchedule,
    editScheduleView
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.userLogin, page: UserLogin),
    RouteDef(Routes.residentMainScreen, page: ResidentMainScreen),
    RouteDef(Routes.adminMainScreen, page: AdminMainScreen),
    RouteDef(Routes.forgetPassword, page: ForgetPassword),
    RouteDef(Routes.userSignUp, page: UserSignUp),
    RouteDef(Routes.singleScheduleView, page: SingleScheduleView),
    RouteDef(Routes.createSchedule, page: CreateSchedule),
    RouteDef(Routes.viewSchedule, page: ViewSchedule),
    RouteDef(Routes.editScheduleView, page: EditScheduleView),
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
    UserSignUp: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const UserSignUp(),
        settings: data,
      );
    },
    CreateSchedule: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CreateSchedule(),
        settings: data,
      );
    },
    SingleScheduleView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleScheduleView(
          value: data.arguments as scheduleModel,
        ),
        settings: data,
      );
    },
    ViewSchedule: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ViewSchedule(),
        settings: data,
      );
    },
    EditScheduleView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            EditScheduleView(schedule: data.arguments as scheduleModel),
        settings: data,
      );
    },
  };
}
