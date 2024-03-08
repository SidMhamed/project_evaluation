import 'package:flutter/material.dart';
import 'package:project_evaluation/Controllers/blogController.dart';
import 'package:project_evaluation/Models/blog.dart';
import 'package:project_evaluation/Views/screens/AddBlogScreen.dart';
import 'package:project_evaluation/Views/screens/DetielsScreen.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import 'package:project_evaluation/myLib/myAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BlogController _blogController = BlogController();
  Future<void> _refreshBlogs() async {
    setState(() {});
  }

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
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppConstants.secondColor,
                        ),
                        onPressed: () async {
                          try {
                            await _blogController.deleteBlog(blogs[index].id);
                            _refreshBlogs();
                            print("delete success");
                          } catch (e) {
                            print("Error $e");
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetielsScreen(
                              blog: blogs[index],
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
        child: const Icon(
          Icons.add,
          color: AppConstants.secondColor,
          size: 30,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddBlogScreen(refreshCallback: _refreshBlogs);
              });
        },
      ),
    );
  }
}
