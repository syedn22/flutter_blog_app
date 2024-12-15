import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/caculate_read_time.dart';
import 'package:blog_app/core/utils/date_format.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) => MaterialPageRoute(
        builder: (context) => BlogViewerPage(
          blog: blog,
        ),
      );

  final Blog blog;

  const BlogViewerPage({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              blog.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'By ${blog.posterName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${DateFormatter.getDateFormatddMMMyyyy(blog.updatedAt)} . ${calculateReadTime(blog.content)} min',
              style: const TextStyle(
                fontSize: 16,
                color: AppPallete.greyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                blog.imageUrl,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const SizedBox(
                            height: 200,
                            child: Loader(),
                          ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              blog.content,
              style: const TextStyle(
                fontSize: 16,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
