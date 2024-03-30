import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc({
    required this.uploadBlog,
  }) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(UploadBlogParams(
      image: event.image,
      title: event.title,
      content: event.content,
      topics: event.topics,
      userId: event.userId,
    ));

    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (blog) => emit(
        BlogSuccess(),
      ),
    );
  }
}
