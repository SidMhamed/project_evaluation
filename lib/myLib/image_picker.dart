import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyImagePicker {
  final _picker = ImagePicker();

  Future<File?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> captureImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
