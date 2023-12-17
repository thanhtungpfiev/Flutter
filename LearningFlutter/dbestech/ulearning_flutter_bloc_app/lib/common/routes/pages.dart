import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global.dart';
import '../../pages/application/bloc/app_bloc.dart';
import '../../pages/application/view/application_view.dart';
import '../../pages/course_detail/bloc/course_detail_bloc.dart';
import '../../pages/course_detail/view/course_detail_view.dart';
import '../../pages/home/bloc/home_bloc.dart';
import '../../pages/home/view/home_view.dart';
import '../../pages/register/bloc/register_bloc.dart';
import '../../pages/register/view/register_view.dart';
import '../../pages/setting/bloc/setting_bloc.dart';
import '../../pages/setting/view/setting_view.dart';
import '../../pages/signin/bloc/sign_in_bloc.dart';
import '../../pages/signin/view/sign_in_view.dart';
import '../../pages/welcome/bloc/welcome_bloc.dart';
import '../../pages/welcome/view/welcome_view.dart';
import 'routes.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.initial,
        page: const WelcomeView(),
        bloc: BlocProvider(
          lazy: false,
          create: (BuildContext context) => WelcomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.signIn,
        page: const SignInView(),
        bloc: BlocProvider(
          create: (BuildContext context) => SignInBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.register,
        page: const RegisterView(),
        bloc: BlocProvider(
          create: (BuildContext context) => RegisterBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.application,
        page: const ApplicationView(),
        bloc: BlocProvider(
          create: (BuildContext context) => AppBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.home,
        page: const HomeView(),
        bloc: BlocProvider(
          create: (BuildContext context) => HomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.setting,
        page: const SettingView(),
        bloc: BlocProvider(
          create: (BuildContext context) => SettingBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.courseDetail,
        page: const CourseDetailView(),
        bloc: BlocProvider(
          create: (BuildContext context) => CourseDetailBloc(),
        ),
      ),
    ];
  }

  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.initial && deviceFirstOpen) {
          bool isLoggedIn = Global.storageService.getIsLoggedIn();
          if (isLoggedIn) {
            return MaterialPageRoute(
                builder: (_) => const ApplicationView(), settings: settings);
          }
          return MaterialPageRoute(
              builder: (_) => const SignInView(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const SignInView(), settings: settings);
  }
}

class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({
    required this.route,
    required this.page,
    required this.bloc,
  });
}
