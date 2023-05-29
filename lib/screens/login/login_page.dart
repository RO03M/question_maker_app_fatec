import 'package:flutter/material.dart';
import 'package:question_maker_app/routes/routes.dart';
import 'package:question_maker_app/screens/login/components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Q&A Login"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(10),
            child: const Text(
              "Bem-vindo novamente",
              style: TextStyle(
                fontSize: 34,
              ),
            ),
          ),
          LoginForm(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: const Text("Não possui uma conta? Crie uma"),
              onTap: () => Navigator.of(context).popAndPushNamed(RoutesManager.register),
            ),
          )
        ],
      ),
    );
  }
}