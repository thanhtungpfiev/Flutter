import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/apis/course_api.dart';
import '../../../common/entities/course.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../bloc/course_detail_bloc.dart';

class CourseDetailController {
  final BuildContext context;

  CourseDetailController({required this.context});

  void init() async {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    asyncLoadAllData(args['id']);
  }

  void asyncLoadAllData(int? id) async {
    CourseRequestEntity courseRequestEntity = CourseRequestEntity(id: id);
    var result = await CourseApi.courseDetail(params: courseRequestEntity);
    if (result.code == HttpStatus.ok) {
      if (context.mounted) {
        context.read<CourseDetailBloc>().add(TriggerCourseDetail(result.data!));
      }
    } else {
      toastInfo(msg: 'Something went wrong');
      print(result.code);
    }
  }
}
