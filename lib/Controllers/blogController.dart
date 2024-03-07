import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_evaluation/Models/blog.dart';

class BlogController extends ChangeNotifier {
  final CollectionReference _blogCollectionReference =
      FirebaseFirestore.instance.collection("blogs");

  Future<void> addBlog(Blog blog) async {
    try {
      await _blogCollectionReference.add({
        'title': blog.title,
        'auteur': blog.auteur,
        'image': blog.image,
        'contenu': blog.contenu,
      });
      notifyListeners();
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
}
