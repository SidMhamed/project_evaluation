import 'package:flutter/material.dart';
import 'package:project_evaluation/UI/Screens/DetielsScreen.dart';
import 'package:project_evaluation/UI/widgets/ConfirmDelete.dart';
import 'package:project_evaluation/business/servises/blogServise.dart';
import '../../myLib/app_constants.dart';

class BlogCard extends StatefulWidget {
  BlogWithId blogWithId;
  BlogCard({required this.blogWithId});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(widget.blogWithId.blog.title),
        subtitle: Text(widget.blogWithId.blog.auteur),
        leading: Image.network(widget.blogWithId.blog.image),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: AppConstants.secondColor,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return DeleteConfirmationDialog(
                  blogId: widget.blogWithId.documentId,
                );
              },
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetielsScreen(
                blog: widget.blogWithId.blog,
              ),
            ),
          );
        },
      ),
    );
  }
}
