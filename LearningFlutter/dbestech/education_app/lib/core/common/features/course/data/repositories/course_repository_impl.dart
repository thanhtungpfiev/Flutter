import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/features/course/data/data_sources/course_remote_data_source.dart';
import 'package:education_app/core/common/features/course/domain/entities/course_entity.dart';
import 'package:education_app/core/common/features/course/domain/repositories/course_repository.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';

class CourseRepoImpl implements CourseRepository {
  const CourseRepoImpl(this._remoteDataSource);

  final CourseRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<CourseEntity>> getCourses() async {
    try {
      final result = await _remoteDataSource.getCourses();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> addCourse(CourseEntity courseEntity) async {
    try {
      final result = _remoteDataSource.addCourse(courseEntity);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
