part of 'course_cubit.dart';

@immutable
abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitialState extends CourseState {
  const CourseInitialState();
}

class AddingCourseState extends CourseState {
  const AddingCourseState();
}

class CourseAddedState extends CourseState {
  const CourseAddedState();
}

class LoadingCoursesState extends CourseState {
  const LoadingCoursesState();
}

class CoursesLoadedState extends CourseState {
  const CoursesLoadedState({required this.courses});
  final List<CourseEntity> courses;
  @override
  List<Object> get props => [courses];
}

class CourseErrorState extends CourseState {
  const CourseErrorState({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
