part of 'course_detail_bloc.dart';

abstract class CourseDetailEvent {
  const CourseDetailEvent();
}

class TriggerCourseDetail extends CourseDetailEvent {
  final CourseItem courseItem;

  const TriggerCourseDetail(this.courseItem);
}
