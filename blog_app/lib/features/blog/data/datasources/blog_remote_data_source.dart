import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(
            blog.toJson(),
          )
          .select();

      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      const storageBucket = 'blog_images';
      final imagePath = blog.id;
      await supabaseClient.storage.from(storageBucket).upload(imagePath, image);
      // .upload(
      //   'blog_images/${blog.id}.jpg',
      //   image,
      // );

      return supabaseClient.storage.from(storageBucket).getPublicUrl(imagePath);
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (name)');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              userName: blog['profiles']['name'],
            ),
          )
          .toList();
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }
}
