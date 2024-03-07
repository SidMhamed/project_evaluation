import 'package:flutter/material.dart';
import '../../myLib/config.dart';
import '../../myLib/myButtonWidget.dart';
import '../../myLib/myInputTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
            SizedBox(height: fullHeight(context) * 0.003),
            myInputTextField(
              labelText: 'Email',
              typeInputTextField: TextInputType.emailAddress,
              controller: _emailController,
            ),
            SizedBox(height: fullHeight(context) * 0.03),
            myInputTextField(
              labelText: 'Mot de passe',
              typeInputTextField: TextInputType.visiblePassword,
              controller: _passwordController,
              obscured: true,
            ),
            SizedBox(height: fullHeight(context) * 0.02),
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
            SizedBox(height: fullHeight(context) * 0.05),
            ButtonWidget(
              title: 'Se connecter',
            ),
            SizedBox(height: fullHeight(context) * 0.03),
            RichText(
              text: const TextSpan(
                text: "Vous n'avez pas de compte ?",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
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
