import 'package:flutter/material.dart';
import 'package:project_evaluation/myLib/ConfirmDelete.dart';
import 'package:project_evaluation/myLib/app_constants.dart';

class MenuActions extends StatefulWidget {
  final VoidCallback refreshCallback;
  String blogId;
  MenuActions({
    required this.blogId,
    required this.refreshCallback,
  });

  @override
  State<MenuActions> createState() => _MenuActionsState();
}

class _MenuActionsState extends State<MenuActions> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Options",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppConstants.secondColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: AppConstants.secondColor,
            ),
            title: const Text("Supprimer"),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DeleteConfirmationDialog(
                      blogId: widget.blogId,
                      refreshCallback: widget.refreshCallback,
                    );
                  });
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.edit,
              color: AppConstants.secondColor,
            ),
            title: const Text("Modifié"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
              color: AppConstants.secondColor,
            ),
            title: const Text("Partage"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
