import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_evaluation/Controllers/authController.dart';
import 'package:project_evaluation/Views/screens/RegisterScreen.dart';
import 'package:project_evaluation/myLib/app_constants.dart';
import '../../myLib/config.dart';
import '../../myLib/myButton.dart';
import '../../myLib/myInputTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthController auth = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: fullWidth(context) * 0.08),
        child: ListView(
          children: [
            Image.asset("assets/images/logo3.png",
                height: fullHeight(context) * 0.4),
            sizedBox(fullHeight(context) * 0.002),
            myInputTextField(
              labelText: 'Email',
              hintText: 'Entrer votre Email',
              typeInputTextField: TextInputType.emailAddress,
              controller: _emailController,
              icon: Icons.email,
            ),
            sizedBox(fullHeight(context) * 0.03),
            myInputTextField(
              labelText: 'Mot de passe',
              hintText: 'Entrer votre Mot de passe',
              typeInputTextField: TextInputType.number,
              controller: _passwordController,
              obscured: true,
              icon: Icons.lock,
            ),
            sizedBox(fullHeight(context) * 0.02),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Text(
                "Mot de passe oublié ?",
                style: TextStyle(
                  fontSize: fontSize10(context),
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            sizedBox(fullHeight(context) * 0.05),
            MyButton(
              title: 'Se connecter',
              onPressed: () {
                auth.signIn(
                  _emailController.text,
                  _passwordController.text,
                  context,
                );
              },
            ),
            sizedBox(fullHeight(context) * 0.03),
            RichText(
              text: TextSpan(
                text: "Vous n'avez pas de compte ?",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()),
                          );
                        },
                      text: 'S\'inscrire',
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
