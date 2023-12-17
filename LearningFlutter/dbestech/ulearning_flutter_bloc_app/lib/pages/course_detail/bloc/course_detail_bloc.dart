import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/entities/course.dart';

part 'course_detail_event.dart';
part 'course_detail_state.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  CourseDetailBloc() : super(const CourseDetailState()) {
    on<TriggerCourseDetail>(_triggerCourseDetail);
  }

  FutureOr<void> _triggerCourseDetail(
      TriggerCourseDetail event, Emitter<CourseDetailState> emit) {
    emit(state.copyWith(courseItem: event.courseItem));
  }
}
