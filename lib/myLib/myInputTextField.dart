import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'app_constants.dart';

class myInputTextField extends StatefulWidget {
  String? labelText;
  String? hintText;
  TextEditingController controller;
  bool obscured;
  IconData? icon;
  TextInputType typeInputTextField;
  Function()? onPressed;

  myInputTextField({
    super.key,
    this.labelText,
    this.hintText,
    required this.controller,
    this.typeInputTextField = TextInputType.text,
    this.obscured = false,
    this.icon,
    this.onPressed,
  });

  @override
  State<myInputTextField> createState() => _myInputTextFieldState();
}

// ignore: camel_case_types
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
          onTap: widget.onPressed,
          decoration: InputDecoration(
            border: MaterialStateOutlineInputBorder.resolveWith(
              (states) => const OutlineInputBorder(
                borderSide: BorderSide(color: AppConstants.secondColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: const TextStyle(color: AppConstants.secondColor),
            hintTextDirection: TextDirection.ltr,
            hintStyle: const TextStyle(
              color: AppConstants.secondColor,
              fontSize: 15,
            ),
            suffixIcon: widget.obscured
                ? IconButton(
                    icon: const Icon(Icons.visibility),
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
