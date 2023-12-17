import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/apis/course_api.dart';
import '../../../common/entities/entities.dart';
import '../../../global.dart';
import '../bloc/home_bloc.dart';

class HomeController {
  late BuildContext context;
  UserItem? get userProfile => Global.storageService.getUserProfile();

  static final HomeController _singleton = HomeController._internal();

  HomeController._internal();

  factory HomeController({required BuildContext context}) {
    _singleton.context = context;
    return _singleton;
  }
  Future<void> init() async {
    if (userProfile != null) {
      var result = await CourseApi.courseList();
      if (result.code == HttpStatus.ok) {
        if (context.mounted) {
          context.read<HomeBloc>().add(HomeCourseItemEvent(result.data!));
        }
      } else {
        print(result.code);
      }
    } else {
      print('User already logged out');
    }
  }
}
