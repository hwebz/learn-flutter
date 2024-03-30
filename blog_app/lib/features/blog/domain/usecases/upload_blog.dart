import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UserCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog({required this.blogRepository});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      userId: params.userId,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final List<String> topics;
  final String userId;

  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.userId,
  });
}
