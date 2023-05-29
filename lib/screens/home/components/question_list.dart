import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:question_maker_app/screens/home/components/question_card.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({super.key});

  @override
  State<QuestionList> createState() => QuestionListState();
}

class QuestionListState extends State<QuestionList> {

  List<String> questionIds = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(12),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("questions")
            .orderBy("likeCount", descending: true)
            .orderBy("createdAt", descending: true)
            .limit(50)
            .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && FirebaseAuth.instance.currentUser != null) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.data!.docs;

              return ListView(
                children: documents.map((question) {
                  Map<String, dynamic> data = question.data();
                  List<dynamic> likedUserIds = data["likedUserIds"];
                  bool isLiked = likedUserIds.contains(FirebaseAuth.instance.currentUser!.uid);
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: QuestionCard(
                      id: question.id,
                      question: data["question"],
                      username: data["username"],
                      usernamePhotoUrl: data["usernamePhotoUrl"],
                      likeCount: data["likeCount"],
                      isLiked: isLiked
                    ),
                  );
                } ).toList(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
            } 

            return Center(child: CircularProgressIndicator());
          },
        ),
        // child: ListView(
        //   // children: questions.map((value) {
        //   //   return Padding(
        //   //     padding: const EdgeInsets.all(8.0),
        //   //     child: QuestionCard(),
        //   //   );
        //   // }).toList(),
        // ),
      ),
    );
  }
}