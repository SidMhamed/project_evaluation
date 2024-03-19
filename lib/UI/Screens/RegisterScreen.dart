import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_evaluation/UI/Screens/LoginScreen.dart';
import 'package:project_evaluation/business/authentications/authentication.dart';

import '../../myLib/config.dart';
import '../widgets/myButton.dart';
import '../widgets/myInputTextField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Authentication auth = Authentication();
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
            sizedBox(fullHeight(context) * 0.003),
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
            sizedBox(fullHeight(context) * 0.05),
            MyButton(
              title: 'Créer un compte',
              onPressed: () {
                auth.signUp(
                  _emailController.text,
                  _passwordController.text,
                  context,
                );
              },
            ),
            sizedBox(fullHeight(context) * 0.03),
            RichText(
              text: TextSpan(
                text: "Vous avez déjà un compte?",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      text: 'Connectez-vous ici',
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
