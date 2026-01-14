import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.greyColor,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
              SizedBox(height: ResponsiveUtils.height(20)),
              ClipRRect(
                borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
                child: _RetryableCachedImage(
                  imageUrl: blog.imageUrl,
                  height: ResponsiveUtils.height(800),
                ),
              ),
              SizedBox(height: ResponsiveUtils.height(20)),
              Text(
                blog.content,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(16),
                  height: ResponsiveUtils.height(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RetryableCachedImage extends StatefulWidget {
  final String imageUrl;
  final double? height;

  const _RetryableCachedImage({required this.imageUrl, this.height});

  @override
  State<_RetryableCachedImage> createState() => _RetryableCachedImageState();
}

class _RetryableCachedImageState extends State<_RetryableCachedImage> {
  Key _key = UniqueKey();

  void _retry() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: _key,
      imageUrl: widget.imageUrl,
      width: double.infinity,
      height: widget.height,
      fit: BoxFit.cover,
      placeholder: (context, url) => SizedBox(
        height: widget.height ?? ResponsiveUtils.height(200),
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        height: widget.height ?? ResponsiveUtils.height(200),
        color: AppColors.greyColor.withValues(alpha: 0.1),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.broken_image, size: 48, color: Colors.grey),
              SizedBox(height: ResponsiveUtils.height(8)),
              const Text(
                'Image unavailable',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: ResponsiveUtils.height(8)),
              ElevatedButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
