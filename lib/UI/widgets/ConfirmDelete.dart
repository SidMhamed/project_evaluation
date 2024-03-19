import 'package:flutter/material.dart';
import 'package:project_evaluation/business/blogManager.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import 'package:project_evaluation/ui/widgets/myButton.dart';
import 'package:provider/provider.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String blogId;

  const DeleteConfirmationDialog({
    required this.blogId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Confirmation",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppConstants.secondColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: const Text("Êtes-vous sûr de bien vouloir supprimer cet blog ?"),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        MyButton(
          title: "Cancel",
          onPressed: () => Navigator.pop(context),
        ),
        Consumer<BlogManager>(builder: (context, _blogManager, child) {
          return MyButton(
            title: "Supprimer",
            onPressed: () {
              _blogManager.deleteBlog(blogId);
              Navigator.pop(context);
            },
          );
        }),
      ],
    );
  }
}
