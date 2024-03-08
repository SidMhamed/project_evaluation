import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_evaluation/Models/blog.dart';
import 'package:project_evaluation/myLib/image_picker.dart';

class BlogController {
  final CollectionReference _blogCollectionReference =
      FirebaseFirestore.instance.collection("blogs");
  final MyImagePicker _myImagePicker = MyImagePicker();

  Future<void> addBlog({
    String? title,
    String? auteur,
    String? contenu,
    File? image,
  }) async {
    try {
      String imageURL = await _myImagePicker.uploadImage(image!);
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
}
