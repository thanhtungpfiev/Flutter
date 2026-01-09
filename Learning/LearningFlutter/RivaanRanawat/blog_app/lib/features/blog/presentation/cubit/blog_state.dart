part of 'blog_cubit.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploaded extends BlogState {
  final BlogEntity blog;
  BlogUploaded({required this.blog});
}

final class BlogsLoaded extends BlogState {
  final List<BlogEntity> blogs;
  BlogsLoaded({required this.blogs});
}

final class BlogError extends BlogState {
  final String message;
  BlogError({required this.message});
}
