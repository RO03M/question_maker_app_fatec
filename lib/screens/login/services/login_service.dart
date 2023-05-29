import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:question_maker_app/routes/routes.dart';

class LoginService {

  BuildContext context;

  LoginService(this.context);

  Future<void> login(String email, String password) async {
    try {
      UserCredential response = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      
      if (response.user != null) {
        Navigator.of(context).popAndPushNamed(RoutesManager.homepage);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: const Text("Usuário logado com sucesso")
        ));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.code)
      ));
    }
  }

}