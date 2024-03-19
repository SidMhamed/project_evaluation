import 'package:flutter/material.dart';
import 'package:project_evaluation/UI/widgets/addBlog.dart';
import 'package:project_evaluation/UI/widgets/blogList.dart';
import 'package:project_evaluation/UI/widgets/myAppBar.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import 'package:provider/provider.dart';

import '../../business/blogManager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BlogManager>(context, listen: false).getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: MyAppBar(title: "Bolgs"),
      body: Center(
        child: BlogList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConstants.primaryColor,
        child: const Icon(
          Icons.add,
          color: AppConstants.secondColor,
          size: 30,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddBlog();
              });
        },
      ),
    );
  }
}
