import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_evaluation/Models/blog.dart';

class BlogController {
  final CollectionReference _blogCollectionReference =
      FirebaseFirestore.instance.collection("blogs");
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addBlog({
    String? title,
    String? auteur,
    String? contenu,
    File? image,
  }) async {
    try {
      String imageURL = await _uploadImage(image!);
      await _blogCollectionReference.add({
        'title': title,
        'auteur': auteur,
        'image': imageURL,
        'contenu': contenu,
      });
    } catch (e) {
      print("Error adding blog post: $e");
    }
  }

  Future<List<Blog>> getBlogs() async {
    List<Blog> blogs = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _blogCollectionReference.get()
              as QuerySnapshot<Map<String, dynamic>>;
      for (var doc in snapshot.docs) {
        blogs.add(
          Blog(
            id: doc.id,
            title: doc['title'],
            auteur: doc['auteur'],
            image: doc['image'],
            contenu: doc['contenu'],
          ),
        );
      }
    } catch (e) {
      print("Error fetching blogs: $e");
    }
    return blogs;
  }

  Future<void> deleteBlog(String blogId) async {
    try {
      await _blogCollectionReference.doc(blogId).delete();
    } catch (e) {
      print("Error deleting blog post: $e");
      throw e;
    }
  }

  Future<String> _uploadImage(File imageFile) async {
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
