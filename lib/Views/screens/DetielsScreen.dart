import 'package:flutter/material.dart';
import 'package:project_evaluation/Models/blog.dart';
import 'package:project_evaluation/myLib/myAppBar.dart';

class DetielsScreen extends StatelessWidget {
  final Blog blog;
  DetielsScreen({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Blogs"),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Image.network(
                blog.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(blog.contenu),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
