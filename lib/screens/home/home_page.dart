import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:question_maker_app/components/profile_avatar_action.dart';
import 'package:question_maker_app/screens/home/components/question_form.dart';
import 'package:question_maker_app/screens/home/components/question_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Q&A"),
        actions: [
          ProfileAvatarAction()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            QuestionForm(),
            QuestionList()
          ],
        ),
      ),
    );
  }
}