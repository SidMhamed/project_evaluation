import 'package:flutter/material.dart';
import 'package:project_evaluation/UI/widgets/blogCard.dart';
import 'package:project_evaluation/business/blogManager.dart';
import 'package:project_evaluation/myLib/config.dart';
import 'package:provider/provider.dart';

class BlogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BlogManager>(
      builder: (context, blogManager, child) {
        switch (blogManager.loadState) {
          case LoadState.initial:
          case LoadState.loading:
            return const CircularProgressIndicator();
          case LoadState.loaded:
            if (blogManager.blogsWithId.isEmpty) {
              return const Center(child: Text('No blogs found'));
            }
            return ListView.builder(
              itemCount: blogManager.blogsWithId.length,
              itemBuilder: (BuildContext context, int index) {
                final blogsWithId = blogManager.blogsWithId[index];
                return BlogCard(
                  blogWithId: blogsWithId,
                );
              },
            );
          case LoadState.error:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Error fetching blogs'),
                  sizedBox(fullHeight(context) * 0.1),
                  ElevatedButton(
                    onPressed: () {
                      blogManager.getBlogs();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
