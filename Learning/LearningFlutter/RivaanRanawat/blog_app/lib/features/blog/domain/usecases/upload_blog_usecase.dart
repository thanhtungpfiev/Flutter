import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:dartz/dartz.dart';

class UploadBlogUseCase
    implements UseCase<Either<Failure, BlogEntity>, UploadBlogUseCaseParams> {
  final BlogRepository blogRepository;
  UploadBlogUseCase({required this.blogRepository});

  @override
  Future<Either<Failure, BlogEntity>> call({
    UploadBlogUseCaseParams? params,
  }) async {
    return await blogRepository.uploadBlog(
      image: params!.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogUseCaseParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogUseCaseParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}
