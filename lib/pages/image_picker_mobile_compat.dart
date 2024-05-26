// Only import if running on mobile platforms
import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageMobile() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}
