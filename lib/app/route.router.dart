// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:helbage/model/_model.dart';
import 'package:helbage/view/admin/Guideline/AddGuidelineView.dart';
import 'package:helbage/view/admin/Schedule/_schedule.dart';
import 'package:helbage/view/admin/noticeboard/_noticeboard.dart';
import 'package:helbage/view/authentication/_authentication.dart';
import 'package:helbage/view/home/_home.dart';
import 'package:helbage/view/main/_main.dart';

import 'package:stacked/stacked.dart';

class Routes {
  static const String homeScreen = '/';
  static const String userLogin = '/user-login';
  static const String residentMainScreen = '/resident-main-screen';
  static const String adminMainScreen = '/admin-main-screen';
  static const String forgetPassword = '/forget-password';
  static const String userSignUp = '/user-sign-up';
  static const String newsList = '/news-list';
  static const String createSchedule = '/create-schedule';
  static const String editScheduleView = '/edit-schedule-view';
  static const String addGuidelineView = '/add-guideline-view';

  static const all = <String>{
    homeScreen,
    userLogin,
    residentMainScreen,
    adminMainScreen,
    forgetPassword,
    userSignUp,
    newsList,
    createSchedule,
    editScheduleView,
    addGuidelineView,
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
    RouteDef(Routes.newsList, page: NewsList),
    RouteDef(Routes.createSchedule, page: CreateSchedule),
    RouteDef(Routes.editScheduleView, page: EditScheduleView),
    RouteDef(Routes.addGuidelineView, page: AddGuidelineView),
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
      var args = data.getArgs<AdminMainScreenArguments>(
        orElse: () => AdminMainScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AdminMainScreen(
          key: args.key,
          initial: args.initial,
        ),
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
    NewsList: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const NewsList(),
        settings: data,
      );
    },
    CreateSchedule: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CreateSchedule(),
        settings: data,
      );
    },
    EditScheduleView: (data) {
      var args = data.getArgs<EditScheduleViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditScheduleView(
          key: args.key,
          schedule: args.schedule,
        ),
        settings: data,
      );
    },
    AddGuidelineView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AddGuidelineView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// AdminMainScreen arguments holder class
class AdminMainScreenArguments {
  final Key? key;
  final dynamic initial;
  AdminMainScreenArguments({this.key, this.initial});
}

/// EditScheduleView arguments holder class
class EditScheduleViewArguments {
  final Key? key;
  final scheduleModel schedule;
  EditScheduleViewArguments({this.key, required this.schedule});
}
