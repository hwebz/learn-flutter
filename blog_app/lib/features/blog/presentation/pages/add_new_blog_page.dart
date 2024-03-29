import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Blog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              DottedBorder(
                  color: AppPallete.borderColor,
                  dashPattern: const [10, 4],
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, size: 40),
                        SizedBox(height: 15),
                        Text('Select your image',
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(e)) {
                                      selectedTopics.remove(e);
                                    } else {
                                      selectedTopics.add(e);
                                    }
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    backgroundColor: selectedTopics.contains(e)
                                        ? AppPallete.gradient1
                                        : null,
                                    side: BorderSide(
                                        color: selectedTopics.contains(e)
                                            ? AppPallete.gradient1
                                            : AppPallete.borderColor),
                                    labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                ),
              ),
              const SizedBox(height: 20),
              BlogEditor(controller: titleController, hintText: 'Blog title'),
              const SizedBox(height: 10),
              BlogEditor(
                  controller: contentController, hintText: 'Blog content')
            ],
          ),
        ),
      ),
    );
  }
}
