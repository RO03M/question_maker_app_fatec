import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class QuestionService {

  BuildContext context;

  QuestionService(this.context);

  Future<void> insertQuestion(String question, bool anonymous) async {
    try {

      FirebaseFirestore.instance.collection("questions").add({
        "question": question,
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "username": anonymous ? null : FirebaseAuth.instance.currentUser!.displayName,
        "usernamePhotoUrl": anonymous ? null : FirebaseAuth.instance.currentUser!.photoURL,
        "likeCount": 0,
        "likedUserIds": [],
        "unlikedUserIds": [],
        "createdAt": FieldValue.serverTimestamp()
      });
    } on FirebaseException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: const Text("Ocorreu um erro ao enviar a pergunta, tente novamente")
      ));
    }
  }

  Future<bool> handleLike(String questionId) async {
    bool isLiked = false;
    try {
      DocumentReference document = await FirebaseFirestore.instance.collection("questions").doc(questionId);

      await document.get().then((value) {
        List<dynamic> likedUserIds = value["likedUserIds"];
        bool userHasLiked = likedUserIds.contains(FirebaseAuth.instance.currentUser!.uid);
        
        if (!userHasLiked) {
          document.update({
            "likedUserIds": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
            "likeCount": FieldValue.increment(1)
          });
          isLiked = true;
        } else {
          document.update({
            "likedUserIds": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid]),
            "likeCount": FieldValue.increment(-1)
          });
          isLiked = false;
        }
      });
    } on FirebaseException catch(e) {
      print(e.code);
    }

    return isLiked;
  }
}