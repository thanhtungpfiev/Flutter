import 'package:blog_app/core/helpers/navigator/app_navigator.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCardWidget extends StatelessWidget {
  final BlogEntity blog;
  final Color color;
  const BlogCardWidget({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, BlogViewerPage(blog: blog));
      },
      child: Container(
        height: ResponsiveUtils.height(200),
        margin: EdgeInsets.all(
          ResponsiveUtils.width(16),
        ).copyWith(bottom: ResponsiveUtils.height(4)),
        padding: EdgeInsets.all(ResponsiveUtils.width(16)),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.all(ResponsiveUtils.width(5)),
                            child: Chip(label: Text(e)),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(22),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
