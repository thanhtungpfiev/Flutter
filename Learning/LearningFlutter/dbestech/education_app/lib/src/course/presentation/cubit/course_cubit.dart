import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/domain/entities/course_entity.dart';
import 'package:education_app/src/course/domain/usecases/add_course_usecase.dart';
import 'package:education_app/src/course/domain/usecases/get_courses_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit(this._addCourseUseCase, this._getCoursesUseCase)
      : super(const CourseInitialState());

  final AddCourseUseCase _addCourseUseCase;
  final GetCoursesUseCase _getCoursesUseCase;

  Future<void> addCourse(CourseEntity courseEntity) async {
    emit(const AddingCourseState());
    final result = await _addCourseUseCase.call(courseEntity);
    result.fold(
      (failure) => emit(CourseErrorState(message: failure.message)),
      (_) => emit(const CourseAddedState()),
    );
  }

  Future<void> getCourses() async {
    emit(const LoadingCoursesState());
    final result = await _getCoursesUseCase.call();
    result.fold(
      (failure) => emit(CourseErrorState(message: failure.message)),
      (courses) => emit(CoursesLoadedState(courses: courses)),
    );
  }
}
