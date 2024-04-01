part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final File image;
  final String title;
  final String content;
  final List<String> topics;
  final String userId;

  BlogUpload({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.userId,
  });
}

final class BlogFetchAllBlogs extends BlogEvent {}
