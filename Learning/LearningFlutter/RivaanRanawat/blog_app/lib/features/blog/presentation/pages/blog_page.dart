import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/helpers/navigator/app_navigator.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  bool _didFetch = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure we fetch once after the widget is inserted in the tree and
    // the top-level BlogCubit provider is available.
    if (!_didFetch) {
      final blogCubit = context.read<BlogCubit>();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Use captured cubit to avoid using context across async gaps
        blogCubit.fetchAllBlogs();
      });
      _didFetch = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () async {
              final blogCubit = context.read<BlogCubit>();
              final result = await AppNavigator.push(context, AddNewBlogPage());
              // If AddNewBlogPage signals a successful upload by returning true,
              // refresh the list. Guard with mounted to ensure the widget is still
              // in the tree after the async gap.
              if (!mounted) return;
              if (result == true) {
                blogCubit.fetchAllBlogs();
              }
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocConsumer<BlogCubit, BlogState>(
        listener: (context, state) {
          if (state is BlogError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const LoaderWidget();
          }
          if (state is BlogsLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCardWidget(
                  blog: blog,
                  color: index % 2 == 0
                      ? AppColors.gradient1
                      : AppColors.gradient2,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
