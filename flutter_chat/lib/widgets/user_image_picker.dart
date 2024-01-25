import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickeImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 150, imageQuality: 50);

      if (pickedImage == null) {
        return;
      }

      final pickedImageFile = File(pickedImage.path);
      print('Image picked = ${pickedImageFile.path}');
      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });

      widget.onPickImage(pickedImageFile);
    } catch (error) {
      print('error = ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
            onPressed: _pickeImage,
            icon: const Icon(Icons.image),
            label: Text("Add Image",
                style: TextStyle(color: Theme.of(context).primaryColor)))
      ],
    );
  }
}
