import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial());
}
