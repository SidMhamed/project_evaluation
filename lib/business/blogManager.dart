import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:project_evaluation/business/servises/blogServise.dart';
import 'package:project_evaluation/data/blog.dart';

enum LoadState { initial, loading, loaded, error }

class BlogManager extends ChangeNotifier {
  final BlogService _blogService = BlogService();
  LoadState _state = LoadState.initial;
  List<BlogWithId> _blogsWithId = [];

  Future<void> getBlogs() async {
    _state = LoadState.loading;
    notifyListeners();
    try {
      _blogsWithId = await _blogService.getBlogs().first;
      _state = LoadState.loaded;
    } on Exception catch (e) {
      print('Error fetching posts: $e');
      _state = LoadState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addBlog({
    String? title,
    String? auteur,
    String? contenu,
    File? image,
  }) async {
    await _blogService.addBlog(
      title: title,
      auteur: auteur,
      contenu: contenu,
      image: image,
    );
    getBlogs();
  }

  Future<void> deleteBlog(String blogId) async {
    await _blogService.deleteBlog(blogId);
    getBlogs();
  }

  List<BlogWithId> get blogsWithId => _blogsWithId;

  int getBlogCounter() {
    int counter = 0;
    for (var blogWithId in _blogsWithId) {
      // ignore: unnecessary_null_comparison
      if (blogWithId.blog != null) {
        counter++;
      }
    }
    return counter;
  }

  LoadState get loadState => _state;
}
