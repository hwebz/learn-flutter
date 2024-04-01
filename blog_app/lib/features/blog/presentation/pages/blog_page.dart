import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const BlogPage(),
      );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog App'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, AddNewBlogPage.route());
                },
                icon: const Icon(
                  CupertinoIcons.add_circled,
                )),
            IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthIsUserLogggedOut());
                },
                icon: const Icon(
                  IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                )),
          ],
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, authState) {
            return BlocConsumer<BlogBloc, BlogState>(
              listener: (context, state) {
                if (state is BlogFailure) {
                  showSnackBar(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is BlogLoading || authState is AuthLoading) {
                  return const Loader();
                }
                if (state is BlogDisplaySuccess) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final blog = state.blogs[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context, BlogViewerPage.route(blog));
                          },
                          child: BlogCard(blog: blog));
                    },
                    itemCount: state.blogs.length,
                  );
                }
                return const SizedBox();
              },
            );
          },
        ));
  }
}
