import 'package:blog_app/core/constants/ui_constants.dart';
import 'package:blog_app/core/helpers/navigator/app_navigator.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UIConstants.blogPageTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              AppNavigator.push(context, const AddNewBlogPage());
            },
          ),
        ],
      ),
    );
  }
}
