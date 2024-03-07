import 'package:flutter/material.dart';
import 'app_constants.dart';

class myInputTextField extends StatefulWidget {
  String? labelText;
  String? hintText;
  TextEditingController controller;
  bool obscured;
  IconData? icon;
  TextInputType typeInputTextField;

  myInputTextField({
    super.key,
    required this.labelText,
    this.hintText,
    required this.controller,
    this.typeInputTextField = TextInputType.text,
    this.obscured = false,
    this.icon,
  });

  @override
  State<myInputTextField> createState() => _myInputTextFieldState();
}

class _myInputTextFieldState extends State<myInputTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.typeInputTextField,
          obscureText: widget.obscured,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintTextDirection: TextDirection.ltr,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
            suffixIcon: widget.obscured
                ? IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.obscured = !widget.obscured;
                      });
                    },
                    color: AppConstants.secondColor,
                  )
                : null,
            prefixIcon: Icon(
              widget.icon,
              color: AppConstants.secondColor,
            ),
          ),
        ),
      ),
    );
  }
}
