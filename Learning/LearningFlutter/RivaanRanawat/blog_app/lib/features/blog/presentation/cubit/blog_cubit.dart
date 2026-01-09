import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;
  final GetAllBlogsUseCase getAllBlogsUseCase;

  BlogCubit({required this.uploadBlogUseCase, required this.getAllBlogsUseCase})
    : super(BlogInitial());

  Future<void> uploadBlog(UploadBlogUseCaseParams params) async {
    emit(BlogLoading());
    final result = await uploadBlogUseCase.call(params: params);
    result.fold(
      (failure) => emit(BlogError(message: failure.message)),
      (blog) => emit(BlogUploaded(blog: blog)),
    );
  }

  Future<void> fetchAllBlogs() async {
    emit(BlogLoading());
    final result = await getAllBlogsUseCase.call();
    result.fold(
      (failure) => emit(BlogError(message: failure.message)),
      (blogs) => emit(BlogsLoaded(blogs: blogs)),
    );
  }
}
