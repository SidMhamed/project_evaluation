import 'package:flutter/material.dart';

class OCErrorWidget extends StatelessWidget {
  String message;
  OCErrorWidget({
    super.key,
    required this.message,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
