import 'package:blog_app/feature/blog/presentation/pages/add_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddBlogPage.route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
    );
  }
}
