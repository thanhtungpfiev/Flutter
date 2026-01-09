import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllBlogsUseCase
    implements UseCase<Either<Failure, List<BlogEntity>>, dynamic> {
  GetAllBlogsUseCase({required this.blogRepository});

  final BlogRepository blogRepository;

  @override
  Future<Either<Failure, List<BlogEntity>>> call({dynamic params}) async {
    return await blogRepository.getAllBlogs();
  }
}
