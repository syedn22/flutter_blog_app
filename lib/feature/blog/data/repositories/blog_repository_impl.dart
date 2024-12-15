import 'dart:io';

import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/feature/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/feature/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/feature/blog/data/models/blog_model.dart';
import 'package:blog_app/feature/blog/domain/entities/blog.dart';
import 'package:blog_app/feature/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(
    this.blogRemoteDataSource,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, Blog>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String posterId,
      required List<String> topics}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: Constants.noConnectionMessageString));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        topics: topics,
        imageUrl: '',
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          blog: blogModel, file: image);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedModel = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedModel);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadBlogs(blogs: blogs);

      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
