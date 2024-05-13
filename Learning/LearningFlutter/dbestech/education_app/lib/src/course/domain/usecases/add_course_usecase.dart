import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/src/course/domain/entities/course_entity.dart';
import 'package:education_app/src/course/domain/repositories/course_repository.dart';

class AddCourseUseCase extends UseCaseWithParams<void, CourseEntity> {
  AddCourseUseCase(this._courseRepository);

  final CourseRepository _courseRepository;

  @override
  Future<Either<Failure, void>> call(
    CourseEntity params,
  ) async {
    return _courseRepository.addCourse(params);
  }
}
