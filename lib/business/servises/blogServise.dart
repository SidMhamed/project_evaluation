import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_evaluation/business/image_picker.dart';
import 'package:project_evaluation/data/blog.dart';

class BlogService {
  final MyImagePicker _myImagePicker = MyImagePicker();
  final CollectionReference _blogCollectionReference =
      FirebaseFirestore.instance.collection("Blogs");
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
      throw Exception("Error adding blog post: $e");
    }
  }

  Stream<List<BlogWithId>> getBlogs() {
    return _blogCollectionReference.snapshots().map((querySnapshot) {
      print("**********************Fetched***********************");
      print('**** Fetched ${querySnapshot.docs.length} blogs ****');
      print("**********************Fetched***********************");
      return querySnapshot.docs.map((doc) {
        String documentId = doc.id; // Extract document ID directly
        Blog blog = Blog.fromMap(doc.data() as Map<String, dynamic>);
        return BlogWithId(blog: blog, documentId: documentId);
      }).toList();
    });
  }

  int getConnterBlog(List<Blog> blog) {
    return blog.length;
  }

  Future<void> deleteBlog(String blogId) {
    try {
      return _blogCollectionReference.doc(blogId).delete();
    } catch (e) {
      print("*********************Exception*********************");
      print("********** Error deleting blog post: $e ***********");
      print("*********************Exception*********************");
      throw e;
    }
  }
}

class BlogWithId {
  final Blog blog;
  final String documentId;

  const BlogWithId({required this.blog, required this.documentId});
}
