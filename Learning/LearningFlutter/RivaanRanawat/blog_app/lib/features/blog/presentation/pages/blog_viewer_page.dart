import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final BlogEntity blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          primary: true,
          padding: EdgeInsets.all(ResponsiveUtils.width(16.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                blog.title,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(24),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: ResponsiveUtils.height(20)),
              Text(
                'By ${blog.posterName}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
              SizedBox(height: ResponsiveUtils.height(5)),
              Text(
                '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  blog.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                blog.content,
                style: const TextStyle(fontSize: 16, height: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
