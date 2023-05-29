import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:question_maker_app/routes/routes.dart';

class RegisterService {

  BuildContext context;

  RegisterService(this.context);

  Future<void> register(String email, String password, String displayName) async {
    try {
      UserCredential response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? user = response.user;

      if (user != null) {
        user.updateDisplayName(displayName);
      }
      
      Navigator.of(context).popAndPushNamed(RoutesManager.homepage);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: const Text("Cadastro realizado com sucesso")
      ));
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

}