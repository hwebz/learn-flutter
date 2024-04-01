import 'dart:io';

import 'package:blog_app/core/constants/constants.dart';
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
          .from(DatabaseTables.blogs)
          .insert(
            blog.toJson(),
          )
          .select();

      return BlogModel.fromJson(blogData.first);
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(message: e.message);
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      const storageBucket = StorageBuckets.blogImages;
      final imagePath = blog.id;
      await supabaseClient.storage.from(storageBucket).upload(imagePath, image);
      // .upload(
      //   'blog_images/${blog.id}.jpg',
      //   image,
      // );

      return supabaseClient.storage.from(storageBucket).getPublicUrl(imagePath);
    } on StorageException catch (e) {
      print(e);
      throw ServerException(message: e.message);
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, ${DatabaseTables.profiles} (name)');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              userName: blog[DatabaseTables.profiles]['name'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      print(e);
      throw ServerException(message: e.message);
    } catch (e) {
      print(e);
      throw ServerException(message: e.toString());
    }
  }
}
