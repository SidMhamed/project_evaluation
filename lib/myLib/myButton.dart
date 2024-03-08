// ignore: file_names
import 'package:flutter/material.dart';
import 'app_constants.dart';
import 'config.dart';

class MyButton extends StatefulWidget {
  final Function()? onPressed;
  final String? title;
  final Color color;
  final Color textColor;

  const MyButton({
    super.key,
    this.onPressed,
    this.title,
    this.color = AppConstants.primaryColor,
    this.textColor = Colors.white,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: fontSize10(context) * 1),
        backgroundColor: AppConstants.secondColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        maximumSize: Size(fullWidth(context) * 0.9, fullHeight(context) * 0.06),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.title!,
        style: TextStyle(color: widget.textColor),
      ),
    );
  }
}
