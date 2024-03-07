import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_evaluation/Views/screens/HomeScreen.dart';
import 'Views/screens/LoginScreen.dart';
import 'package:project_evaluation/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
