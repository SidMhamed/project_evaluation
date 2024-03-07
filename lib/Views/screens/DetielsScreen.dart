import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_evaluation/Controllers/blogController.dart';
import 'package:project_evaluation/Models/blog.dart';
import 'package:project_evaluation/myLib/myAppBarWidget.dart';

class DetielsScreen extends StatefulWidget {
  int indexBlog;
  DetielsScreen({
    super.key,
    required this.indexBlog,
  });

  @override
  State<DetielsScreen> createState() => _DetielsScreenState();
}

class _DetielsScreenState extends State<DetielsScreen> {
  final BlogController _blogController = BlogController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Blogs"),
      body: Center(
        child: FutureBuilder<List<Blog>>(
            future: _blogController.getBlogs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final List<Blog> blogs = snapshot.data!;

                return Container(
                  margin: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Image.network(
                        blogs[0].image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(blogs[0].contenu),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
