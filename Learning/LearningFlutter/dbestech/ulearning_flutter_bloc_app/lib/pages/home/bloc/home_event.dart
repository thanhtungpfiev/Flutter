part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  const HomeEvent();
}

class HomeDotsEvent extends HomeEvent {
  final int index;

  const HomeDotsEvent(this.index);
}

class HomeCourseItemEvent extends HomeEvent {
  final List<CourseItem> courseItem;

  const HomeCourseItemEvent(this.courseItem);
}
