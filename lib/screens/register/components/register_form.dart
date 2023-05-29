import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:question_maker_app/routes/routes.dart';
import 'package:question_maker_app/screens/register/services/register_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String displayName = "";

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      RegisterService(context).register(email, password, displayName);
    }
  }

  Future<void> onSubmitAnonymous() async {
    try {
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.signInAnonymously();
      Navigator.of(context).popAndPushNamed(RoutesManager.homepage);
    } on FirebaseAuthException catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              maxLength: 255,
              onSaved: (value) => setState(() => displayName = value ?? ""),
              validator: (value) {
                if (value == null) return "Insira um nome";
                else if (value.isEmpty) return "Insira um nome";
              },
              decoration: InputDecoration(
                hintText: "Seu nome",
                labelText: "Nome",
                border: OutlineInputBorder()
              ),
            ),
            TextFormField(
              maxLength: 255,
              onSaved: (value) => setState(() => email = value ?? ""),
              validator: (value) {
                if (value == null) return "Insira um e-mail válido";
                else if (value.isEmpty) return "Insira um e-mail";
              },
              decoration: InputDecoration(
                hintText: "Seu melhor e-mail",
                labelText: "E-mail",
                border: OutlineInputBorder()
              ),
            ),
            TextFormField(
              obscureText: true,
              onSaved: (value) => setState(() => password = value ?? ""),
              validator: (value) {
                if (value == null) return "Insira uma senha válida";
                else if (value.isEmpty) return "Insira uma senha";
              },
              decoration: InputDecoration(
                hintText: "Uma senha segura",
                labelText: "Senha",
                border: OutlineInputBorder()
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text("Entrar"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50)
                  ),
                ),
                OutlinedButton(
                  onPressed: onSubmitAnonymous,
                  child: const Text("Entrar como anônimo"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                ),
              ].map((widget) => Container(
                margin: EdgeInsets.only(top: 20),
                child: widget,
              )).toList()
            )
          ],
        ),
      )
    );
  }
}