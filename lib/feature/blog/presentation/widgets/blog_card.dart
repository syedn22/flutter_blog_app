import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/caculate_read_time.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
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
                  children: [
                    ...blog.topics.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Chip(
                            label: Text(e),
                            color: const WidgetStatePropertyAll(
                                AppPallete.backgroundColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                blog.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          Text('${calculateReadTime(blog.content)} min')
        ],
      ),
    );
  }
}
