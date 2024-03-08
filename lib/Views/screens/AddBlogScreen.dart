import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_evaluation/Controllers/blogController.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import 'package:project_evaluation/myLib/config.dart';
import 'package:project_evaluation/myLib/image_picker.dart';
import 'package:project_evaluation/myLib/myButton.dart';
import 'package:project_evaluation/myLib/myInputTextField.dart';

class AddBlogScreen extends StatefulWidget {
  final VoidCallback refreshCallback;

  const AddBlogScreen({
    super.key,
    required this.refreshCallback,
  });

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _auteurController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();

  File? _image;

  final MyImagePicker _imagePicker = MyImagePicker();
  final BlogController _blogController = BlogController();

  Future<void> _getImageFromGallery() async {
    final pickedImage = await _imagePicker.getImageFromGallery();
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _addBlog() async {
    final String title = _titleController.text;
    final String author = _auteurController.text;
    final String content = _contenuController.text;

    if (title.isNotEmpty &&
        author.isNotEmpty &&
        content.isNotEmpty &&
        _image != null) {
      try {
        await _blogController.addBlog(
          title: title,
          auteur: author,
          contenu: content,
          image: _image!,
        );
        widget.refreshCallback();
        Navigator.pop(context);
      } catch (e) {
        print('Error adding blog post: $e');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Message"),
            content: Text('Please fill in all fields and select an image'),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text("Ok"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppConstants.titextColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Ajouter une Blog",
                  style: TextStyle(
                    color: AppConstants.secondColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              sizedBox(fullHeight(context) * 0.03),
              myInputTextField(
                controller: _titleController,
                labelText: 'Title',
                hintText: 'Enter Titile',
              ),
              sizedBox(fullHeight(context) * 0.03),
              myInputTextField(
                controller: _auteurController,
                labelText: 'Auteur',
                hintText: 'Enter Nom de auteur',
              ),
              sizedBox(fullHeight(context) * 0.03),
              _image != null
                  ? SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: Image.file(_image!),
                    )
                  : MyButton(
                      title: 'ajouter une image',
                      // haReadOnly: true,
                      // icon: Icons.image,
                      onPressed: () {
                        _getImageFromGallery(); // Call image picker on tap
                      },
                    ),
              sizedBox(fullHeight(context) * 0.03),
              myInputTextField(
                controller: _contenuController,
                labelText: 'Contenu',
                hintText: 'Enter contenu',
              ),
              sizedBox(fullHeight(context) * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'Cancel',
                  ),
                  MyButton(
                    onPressed: () {
                      _addBlog();
                      Navigator.pop(context);
                    },
                    title: 'Ajouter',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
