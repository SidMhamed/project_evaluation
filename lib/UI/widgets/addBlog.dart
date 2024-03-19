import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_evaluation/business/blogManager.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import 'package:project_evaluation/myLib/config.dart';
import 'package:project_evaluation/ui/widgets/myButton.dart';
import 'package:project_evaluation/ui/widgets/myInputTextField.dart';
import 'package:provider/provider.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _auteurController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();

  File? _image;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _auteurController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _addBlog() async {
    final _blogManager = Provider.of<BlogManager>(context, listen: false);
    final String title = _titleController.text;
    final String author = _auteurController.text;
    final String content = _contenuController.text;

    if (title.isEmpty && author.isEmpty && content.isEmpty && _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields and select an image'),
        ),
      );
      return;
    }

    try {
      await _blogManager.addBlog(
          title: title, auteur: author, contenu: content, image: _image!);
      Navigator.pop(
          context,
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Blog added Success.'),
            ),
          ));
    } catch (e) {
      print('Error adding blog post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding blog. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ajouter un Blog',
                    style: TextStyle(
                      color: AppConstants.secondColor,
                      fontSize: 25,
                    ),
                  ),
                ),
                sizedBox(fullHeight(context) * 0.03),
                myInputTextField(
                  controller: _titleController,
                  labelText: 'Title',
                  hintText: 'Enter Title',
                ),
                sizedBox(fullHeight(context) * 0.03),
                myInputTextField(
                  controller: _auteurController,
                  labelText: 'Auteur',
                  hintText: 'Enter Nom de auteur',
                ),
                sizedBox(fullHeight(context) * 0.03),
                myInputTextField(
                  controller: _contenuController,
                  labelText: 'Contenu',
                  hintText: 'Enter contenu',
                ),
                sizedBox(fullHeight(context) * 0.03),
                _image != null
                    ? SizedBox(
                        width: double.infinity,
                        height: 400,
                        child: Image.file(_image!),
                      )
                    : MyButton(
                        title: 'Ajouter une image',
                        onPressed: _getImageFromGallery,
                      ),
                sizedBox(fullHeight(context) * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(
                      onPressed: () => Navigator.pop(context),
                      title: 'Cancel',
                    ),
                    MyButton(
                      onPressed: _addBlog,
                      title: 'Ajouter',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
