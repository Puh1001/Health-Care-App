import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<File?> pickImage() async {
  File? image;
  PlatformFile? pickedFile;
  try {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (file != null && file.files.single != null) {
      pickedFile = file!.files.first;
      image = File(pickedFile!.path.toString());
    }
  } catch (err) {
    debugPrint(err.toString());
  }
  return image;
}
