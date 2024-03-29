library config.globals;

import 'package:flutter/material.dart';

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double iconSize10(BuildContext context) {
  return MediaQuery.of(context).size.width * .023;
}

double fontSize10(BuildContext context) {
  return MediaQuery.of(context).size.width * .034;
}

// ignore: non_constant_identifier_names
Widget sizedBox(double Height) {
  return SizedBox(height: Height);
}
