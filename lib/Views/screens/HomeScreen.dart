import 'package:flutter/material.dart';
import 'package:project_evaluation/Controllers/blogController.dart';
import 'package:project_evaluation/Models/blog.dart';
import 'package:project_evaluation/Views/screens/DetielsScreen.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import 'package:project_evaluation/myLib/myAppBarWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BlogController _blogController = BlogController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: MyAppBar(title: "Bolgs"),
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
              return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(blogs[index].title),
                      subtitle: Text(blogs[index].auteur),
                      leading: Image.network(blogs[index].image),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetielsScreen(
                              indexBlog: index,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConstants.primaryColor,
        child: Icon(
          Icons.add,
          color: AppConstants.secondColor,
        ),
        onPressed: () {},
      ),
    );
  }
}
