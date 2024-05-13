import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course_entity.dart';

abstract class CourseRepository {
  const CourseRepository();

  ResultFuture<List<CourseEntity>> getCourses();

  ResultFuture<void> addCourse(CourseEntity courseEntity);
}
