import 'package:flutter/material.dart';
import 'package:project_evaluation/Views/screens/LoginScreen.dart';
import 'package:project_evaluation/myLib/app_constants.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String title;
  MyAppBar({
    super.key,
    this.title = "Blogs",
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: AppConstants.secondColor,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppConstants.primaryColor,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: AppConstants.secondColor,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          },
        ),
      ],
    );
  }
}
