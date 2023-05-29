import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:question_maker_app/app.dart';
import 'package:question_maker_app/config/default_firebase_config.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseConfig.firebaseConfig);
  runApp(const App());
}

