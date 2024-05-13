import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/src/course/domain/entities/course_entity.dart';
import 'package:education_app/src/course/domain/repositories/course_repository.dart';

class GetCoursesUseCase extends UseCaseWithoutParams<List<CourseEntity>> {
  GetCoursesUseCase(this._repository);

  final CourseRepository _repository;

  @override
  Future<Either<Failure, List<CourseEntity>>> call({void params}) async {
    return _repository.getCourses();
  }
}
