import 'package:flutter/material.dart';
import 'package:project_evaluation/Controllers/blogController.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import 'package:project_evaluation/myLib/myButton.dart';

class DeleteConfirmationDialog extends StatefulWidget {
  final String blogId;
  final VoidCallback refreshCallback;

  DeleteConfirmationDialog({
    super.key,
    required this.blogId,
    required this.refreshCallback,
  });

  @override
  State<DeleteConfirmationDialog> createState() =>
      _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState extends State<DeleteConfirmationDialog> {
  final BlogController _blogController = BlogController();

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
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MyButton(
          title: "Supprimer",
          onPressed: () async {
            try {
              await _blogController.deleteBlog(widget.blogId);
              Navigator.pop(context);
              print("delete success");
            } catch (e) {
              print("Error $e");
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
