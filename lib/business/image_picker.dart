import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker {
  final _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<File?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<File?> captureImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      String filePath =
          'images/${DateTime.now().millisecondsSinceEpoch}.${imageFile.path.split('.').last}';
      Reference ref = _storage.ref().child(filePath);

      UploadTask uploadTask = ref.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String imageURL = await snapshot.ref.getDownloadURL();

      return imageURL;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
}
