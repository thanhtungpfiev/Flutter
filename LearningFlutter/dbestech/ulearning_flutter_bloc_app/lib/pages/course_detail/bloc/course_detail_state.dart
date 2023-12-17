part of 'course_detail_bloc.dart';

class CourseDetailState extends Equatable {
  final CourseItem? courseItem;

  const CourseDetailState({this.courseItem});

  CourseDetailState copyWith({
    CourseItem? courseItem,
  }) {
    return CourseDetailState(
      courseItem: courseItem ?? this.courseItem,
    );
  }

  @override
  List<Object?> get props => [courseItem];
}
