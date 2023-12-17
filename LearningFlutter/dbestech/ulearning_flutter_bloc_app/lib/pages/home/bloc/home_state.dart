part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int index;
  final List<CourseItem> courseItem;

  const HomeState({this.index = 0, this.courseItem = const <CourseItem>[]});

  HomeState copyWith({int? index, List<CourseItem>? courseItem}) {
    return HomeState(
      index: index ?? this.index,
      courseItem: courseItem ?? this.courseItem,
    );
  }

  @override
  List<Object> get props => [index, courseItem];
}
